import { Request, Response } from 'express'
import { Service } from 'typedi';
import UserDA from '../DA/user.da';
import { ErrorMessage } from '../VO/messages';
import { admin } from '../lib/firebaseAdmin';
import { GenerateUUID } from '../lib/commonFunctions';
import MemberService from './member.service';
import { IMember } from '../types/interface';
import AwsClient from '../lib/awsClient';
import axios from '../lib/axios';
import { Template_IDs } from '../VO/constants';
import SchedulerDA from '../DA/scheduler.da';


@Service()
export default class UserService {
    constructor(private readonly userDA: UserDA,
        private readonly memberService: MemberService,
        private readonly schedulerDA: SchedulerDA
    ) { }

    CheckUserExistByNumber = async (req: Request, res: Response) => {
        try {
            const { phone_number } = req.query;

            const row = await this.userDA.CheckIfUserExists(phone_number);

            if (row.length > 0) {
                return res.status(200).send({ msg: "User Found" });
            }

            return res.status(400).send({ msg: "User Not Found" });

        } catch (error) {
            res.status(500).send({ error, msg: "Internal Server Error" });
        }
    }

    Signup = async (req: Request, res: Response) => {
        try {
            const { phone_number, user_type, IsNewUser } = req.body;

            const user_details_rows = await this.userDA.CheckIfUserExists(phone_number);

            if (user_details_rows.length > 0) {
                let { User_Type, Is_Active, Frst_Name, Last_Name, Email, Refresh_Token, User_Id } = user_details_rows[0];
                if (['N', 'Y'].includes(Is_Active)) {
                    let message;
                    if (user_type == 'S' && User_Type == 'P')
                        message = ErrorMessage.SamePhWithPrac;
                    else if (user_type == 'P' && User_Type == 'S')
                        message = ErrorMessage.SamePhWithSeeK
                    else
                        message = ErrorMessage.SamePh
                    return res.status(400).send([{ message }]);
                }
                else if (Is_Active == 'P') {
                    if (IsNewUser) {
                        const { frst_name, last_name, email, refresh_token } = req.body;
                        if (frst_name != Frst_Name || last_name != Last_Name || email != Email || refresh_token != Refresh_Token) {
                            Email = email;
                            this.userDA.UpdateUserDetails(frst_name, last_name, email, refresh_token, phone_number, 'P');
                        }
                        return res.status(200).send()
                    }
                    const { major, spec, experience } = req.body;
                    let firebase_id = await this.GetFirebaseIdByPhoneNumber(phone_number);
                    await this.userDA.UpdatePracDetails(major, spec, experience, firebase_id);
                    try {
                        const result = await axios.post(process.env.EMAIL_ENGINE_URL as string + '/users/sendmail', { templateId: Template_IDs.Signup, email: Email });
                        await this.schedulerDA.CreateApiLog({
                            Process_Name: 'User Signup SES',
                            Process_Type: "PROGRAM_LOG",
                            Key1: 'User ID',
                            Value1: User_Id,
                            Response: JSON.stringify(result.data)
                        })
                    } catch (error) {
                        await this.schedulerDA.CreateLog({
                            Process_Name: "User Signup SES",
                            Process_Type: "ERROR_LOG",
                            User_Id: User_Id,
                            Error_Message: JSON.stringify(error)
                        })
                    }
                    return res.status(200).send();
                }
            }
            else {
                let firebase_id = await this.GetFirebaseIdByPhoneNumber(phone_number);
                let User_Id = GenerateUUID();
                await this.userDA.InsertUserDetails(req.body, User_Id, firebase_id);
            }

            return res.send('Signed Up');
        } catch (error) {
            console.log(error);
            return res.status(500).send({ error, msg: "Internal Server Error" });
        }
    }

    RefreshToken = async (req: Request, res: Response) => {
        try {
            const { refreshtoken } = req.body;
            const refresh_token_rows = await this.userDA.GetRefreshToken(refreshtoken);
            if (refresh_token_rows.length > 0) {
                const tokenData = await axios.post(`https://securetoken.googleapis.com/v1/token?key=${process.env.FIREBASE_WEB_API_KEY}`,
                    { grant_type: "refresh_token", refresh_token: refreshtoken })
                const { refresh_token, access_token } = tokenData.data;
                if (refresh_token != refreshtoken) {
                    const { Firebase_Id } = refresh_token_rows[0];
                    await this.userDA.UpdateRefreshToken(refresh_token, Firebase_Id as string);
                }
                return res.status(200).send({ access_token })
            }
            return res.status(401).send({ forceLogin: true });
        } catch (error) {
            return res.status(500).send(error);
        }
    }

    Login = async (req: Request, res: Response) => {
        try {
            const { refresh_token, phone_number, access_token } = req.body;

            if (!refresh_token)
                return res.status(403).send([{ message: "Refresh Token is Required" }]);

            const user_rows = await this.userDA.CheckIfUserExists(phone_number);

            if (user_rows.length > 0) {
                const user_status = user_rows[0].Is_Active;
                if (user_status == 'I')
                    return res.status(200).send([{ message: "Please complete your registration" }]);
                let firebase_id = await this.GetFirebaseIdByPhoneNumber(phone_number);
                await this.userDA.Login(refresh_token, firebase_id);
                return res.status(200).send(user_rows);
            }

            return res.status(400).send([{ message: "User doesn't exist" }]);

        } catch (error) {
            console.log(error);
            return res.status(500).send(error);
        }
    }

    private GetFirebaseIdByPhoneNumber = async (phone_number: string) => {
        try {
            phone_number = `+${phone_number}`;
            const userRecord: admin.auth.UserRecord = await admin.auth().getUserByPhoneNumber(phone_number)
            return userRecord.uid;
        } catch (error) {
            throw error;
        }
    }

    RegisterUsingReferalCode = async (req: Request, res: Response) => {
        try {
            const { iden, code } = req.body;
            if (!iden || !code) {
                return res.status(400).send(ErrorMessage.EnterRequiredDetails);
            }
            const resultSet = await this.userDA.RegisterUsingReferalCode(iden, code);
            const { msg } = resultSet[0][0][0];
            if (msg == 1)
                return res.status(200).send();
            else
                return res.status(400).send(msg);
        } catch (error) {
            console.log(error);
            return res.status(500).send(error);
        }
    }

    UpdateMemberDetails = async (req: Request, res: Response) => {
        try {
            const { userid } = req;
            const memberDetails: IMember = req.body;
            [memberDetails.IsOauth] = await this.memberService.HasOauth(userid);
            const file = req.files?.resume;

            if (file) {
                memberDetails.Resume_URL = await (await AwsClient.UploadFileToS3(file)).Location;
            }
            console.log(userid)
            const [[[result]]] = await this.userDA.UpdateMemberDetails(memberDetails, userid);
            console.log(result);
            return res.status(200).send(memberDetails);
        } catch (error) {
            return res.status(500).send(error);
        }
    }
}