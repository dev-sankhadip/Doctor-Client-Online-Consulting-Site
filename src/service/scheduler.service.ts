import { Service } from 'typedi';
import DbConnection from '../DA/dbConnection';
import { Job_Details, Template_IDs } from '../VO/constants';
import { DecryptData, EncryptData, GenerateRandomBytes, GenerateUUID } from '../lib/commonFunctions';
import SchedulerDA from '../DA/scheduler.da';
import { IJobDetais } from '../types/interface';
import { Request, Response } from 'express'
import MemberDA from '../DA/member.da';
import axios from '../lib/axios';

@Service()
export default class SchedulerService extends DbConnection {
    constructor(
        private readonly schedulerDA: SchedulerDA,
        private readonly memberDA: MemberDA
    ) {
        super();
    }


    SendAppoinmentReminder = async (req: Request, res: Response) => {
        const { JobName } = Job_Details['0'];
        try {
            const { jobObject } = this.GetJobObject(JobName);
            await this.schedulerDA.CreateOrUpdateJob(jobObject);

            try {
                const [appoinments] = await this.memberDA.GetUpcomingAppoinments()
                await appoinments.map(async (item) => {
                    const { Event_Id, Email, Meeting_Id, Member_Id } = item;
                    try {
                        const result = await axios.post(process.env.EMAIL_ENGINE_URL as string + '/users/sendmail', { templateId: Template_IDs.Reminder, email: Email });
                        await this.schedulerDA.CreateLog({
                            Process_Name: JobName,
                            Process_Type: "PROGRAM_LOG",
                            Job_Id: jobObject.Job_Id,
                            Event_Id,
                            Meeting_Id,
                            User_Id: Member_Id
                        });
                        await this.schedulerDA.CreateApiLog({
                            Process_Name: JobName,
                            Key1: 'Event ID', Value1: Event_Id,
                            Response: JSON.stringify(result.data)
                        })
                    } catch (error) {
                        console.log(error);
                        await axios.post(process.env.EMAIL_ENGINE_URL as string + '/users/sendmail',
                            {
                                templateId: Template_IDs.Alert, email: process.env.ADMIN_MAIL_ID, data: JSON.stringify(error)
                            });
                    }
                })
            } catch (error) {
                jobObject.Run_Status = 'I';
            }

            jobObject.IsUpdate = true;
            if (jobObject.Run_Status == 'R')
                jobObject.Run_Status = 'C';
            await this.schedulerDA.CreateOrUpdateJob(jobObject);
            res.status(jobObject.Run_Status === 'I' ? 500 : 200).send();
        } catch (error) {
            res.status(500).send();
        }
    }

    private GetJobObject(JobName: string) {
        const jobId = GenerateUUID();
        const currentDT = new Date();

        const jobObject: IJobDetais = {
            Job_Name: JobName,
            Job_Id: jobId,
            Start_TS: currentDT,
            Run_Status: 'R',
            IsUpdate: false
        }

        return {
            jobObject
        }
    }

    RefreshOauthAccessToken = async (req: Request, res: Response) => {
        try {
            const refresh_token_list = await this.memberDA.GetRefreshTokenList();
            for (let i = 0; i < refresh_token_list.length; i++) {
                const { Member_Id, Refresh_Token, Email } = refresh_token_list[i];

                try {
                    const decRefreshToken = DecryptData(Refresh_Token, Member_Id);
                    const response = await axios.post(`https://oauth2.googleapis.com/token?client_id=${process.env.GOOGLE_CLIENT_ID}&client_secret=${process.env.GOOGLE_CLIENT_SECRET}&refresh_token=${decRefreshToken}&grant_type=refresh_token`, {
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded; charset=utf-8"
                        }
                    });

                    const { access_token } = response.data;

                    const encAccessToken = EncryptData(access_token, Member_Id);
                    const encRefreshToken = EncryptData(Refresh_Token, Member_Id);

                    await this.memberDA.CreateTokenDetails(Member_Id, Email, encAccessToken, encRefreshToken);
                } catch (error) {
                    console.log(error);
                    await this.memberDA.SoftDeleteOauthToken(Member_Id);
                }
            }

            return res.status(200).send();
        } catch (error) {
            console.log(error);
            res.status(500).send(error);
        }
    }

}