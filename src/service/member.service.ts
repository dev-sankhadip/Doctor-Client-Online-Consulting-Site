import { Request, Response } from 'express'
import { Service } from 'typedi';
import { DecryptData, EncryptData, FormatDate, GetCalendarMaxdate, IsEmail } from '../lib/commonFunctions';
import MemberDA from '../DA/member.da';
import { IClientDetails, IMeetingDetails, IPatientDet } from '../types/interface';
import GoogleAPIClient from '../lib/googleApiClient';
import { Oauth_Scopes, Oauth_Scopes_Desc } from '../VO/constants';
import UserDA from '../DA/user.da';
import shortid from 'shortid';
import axios from 'axios';
import { ErrorMessage, SuccessMessage } from '../VO/messages';
import ClientDA from '../DA/client.da';


@Service()
export default class MemberService {
    private googleAPI;

    constructor(private readonly memberDA: MemberDA,
        private readonly userDA: UserDA,
        private readonly clientDA: ClientDA
    ) {
        this.googleAPI = GoogleAPIClient.GoogleAuth2Client;
    }

    GetUserCalender = async (req: Request, res: Response) => {
        try {
            const { userid } = req;

            const [Access_Token, Refresh_Token] = await this.GetDecryptedToken(userid);

            const holiday_info = await this.memberDA.GetHolidayList();

            if (Access_Token.length > 0) {
                const events = await GoogleAPIClient.ListCalenderEvent(Access_Token, Refresh_Token, new Date().toISOString(), GetCalendarMaxdate().toISOString());

                if (events) {
                    await this.memberDA.SaveMeetingDetailsFromGoogleCalendar(events, userid);
                }
                let [meeting_details, client_details] = await this.memberDA.GetMeetings(userid);
                let event_info = this.FormatEventDetails(meeting_details, client_details);

                return res.status(200).send({ event_info, holiday_info });
            }
            else {
                return res.status(200).send({ holiday_info });
            }
        } catch (error) {
            console.log(error);
            res.status(500).send(error);
        }
    }

    CreateAppoiment = async (req: Request, res: Response) => {
        try {

            const { userid } = req;

            const eventDetails = this.CreateCalenderEventObject(req.body);

            const [Access_Token, Refresh_Token] = await this.GetDecryptedToken(userid);

            const event = await GoogleAPIClient.CreateCalenderEvent(Access_Token, Refresh_Token, eventDetails) as any;

            const {
                id,
                conferenceData: { conferenceSolution: { name }, entryPoints: [{ uri }] },
                start: { dateTime: sdateTime },
                end: { dateTime: edateTime },
                status
            } = event.data;

            await this.memberDA.CreateMeetingDetails(id, uri, name, sdateTime, edateTime, userid, req.body, status);
            return res.status(200).send();


        } catch (error) {
            console.log(error);
            res.status(500).send(error);
        }
    }

    CreateCalenderEventObject = (body: any) => {
        const { summary, sessionInfo, startTime, endTime, date, patientDetails } = body;

        const formattedDate = FormatDate(new Date(date));
        const event = {
            summary: `${summary}`,
            description: sessionInfo,
            start: {
                'dateTime': `${new Date(formattedDate + ' ' + startTime).toISOString()}`,
                'timeZone': 'IST',
            },
            end: {
                'dateTime': `${new Date(formattedDate + ' ' + endTime).toISOString()}`,
                'timeZone': 'IST',
            },
            attendees: this.CreateAttendes(patientDetails),
            conferenceData: {
                createRequest: { requestId: shortid.generate() },
            },
            guestsCanInviteOthers: false,
            guestsCanModify: false
        };
        return event;
    }

    private CreateAttendes = (patientDetails: IPatientDet[]) => {
        const formattedEmails = patientDetails.map((item: any) => {
            return {
                email: item['email']
            }
        })

        return formattedEmails;
    }

    GetUserOauth2Data = async (req: Request, res: Response) => {
        try {
            const user_id = req.userid;
            const { code } = req.body;
            if (code) {
                const { tokens: { id_token, access_token, refresh_token } } = await this.googleAPI.getToken(code as string);
                const ticket = await this.googleAPI.verifyIdToken({
                    idToken: id_token as string
                })
                const tokenInfo = await GoogleAPIClient.GetTokenInfo(access_token as string);

                let missedScopesDescs: string[] = [];
                Oauth_Scopes.map((scope: string) => {
                    if (!tokenInfo.scopes.includes(scope)) {
                        missedScopesDescs.push(Oauth_Scopes_Desc[scope]);
                    }
                });
                if (missedScopesDescs.length > 0) {
                    return res.status(400).send({
                        status: ErrorMessage.Failed,
                        msg: missedScopesDescs
                    })
                }

                const user_rows = await this.userDA.CheckIfUserExistsByUserId(user_id);
                const user_email = user_rows[0].Email as string;
                const signed_email = ticket.getPayload()?.email;


                if (signed_email) {
                    if (user_email !== signed_email) {
                        return res.status(200).send([{ message: "Please use correct email" }]);
                    }
                    const date = new Date();
                    date.setMonth(new Date().getMonth() - 1);
                    await this.memberDA.CreateTokenDetails(user_id, signed_email, EncryptData(access_token, user_id), EncryptData(refresh_token, user_id));
                    const events = await GoogleAPIClient.ListCalenderEvent(<string>access_token, <string>refresh_token, date.toISOString(), GetCalendarMaxdate().toISOString());

                    if (events) {
                        this.memberDA.SaveMeetingDetailsFromGoogleCalendar(events, user_id);
                    }
                    return res.status(200).send("Authorized");
                }
                return res.status(500).send();
            }
        } catch (error) {
            console.log(error);
            res.status(500).send()
        }
    }

    CreateAuthURL = async (req: Request, res: Response) => {
        try {
            let { userid, body: { email } } = req;
            if (IsEmail(email)) {

                const user_rows = await this.userDA.CheckIfUserExistsByUserId(userid);
                const [IsOauthVerified] = await this.HasOauth(userid);
                const userEmail = user_rows[0].Email;
                if (email !== userEmail) {
                    const email_rows = await this.userDA.CheckIfEmailAlreadyExists(email);

                    if (email_rows.length > 0) {
                        return res.status(400).send(ErrorMessage.EmailAlreadyExists);
                    }
                    if (!IsOauthVerified)
                        await this.userDA.UpdateUserEmailId(email, userid);
                    else
                        email = userEmail
                }

                const url = await GoogleAPIClient.GenerateAuthURL(Oauth_Scopes, email as string);

                return res.status(200).send(url);
            }
            return res.status(400).send();
        } catch (error) {
            console.log(error);
            res.status(500).send(error);
        }
    }

    GetMemberInfo = async (req: Request, res: Response) => {
        try {
            const user_id = req.userid;

            const [IsOauthVerified, accessToken, refreshToken] = await this.HasOauth(user_id);

            let appoinments = await this.GetNextAndUpcomingAppoinment(accessToken, refreshToken, IsOauthVerified);
            let [[{ Addr, Resume_URL, Photo_URL, Reminder_Time, Created_On, ...member_info }], [{ Total_Patient }]] = await this.memberDA.GetMemberInfo(user_id);

            member_info = { ...member_info, Total_Patient }

            res.status(200).send({ member_info, IsOauthVerified, appoinments });

        } catch (error) {
            res.status(500).send(error);
        }
    }

    GetNextAndUpcomingAppoinment = (access_token: string | null, refresh_token: string | null, IsOauthVerified: boolean) => {
        return new Promise(async (resolve, reject) => {
            let appoinments: any[] = [];
            if (IsOauthVerified) {
                try {
                    let events = await GoogleAPIClient.ListCalenderEvent(access_token as string, refresh_token as string, new Date().toISOString(), GetCalendarMaxdate().toISOString());
                    if (events && events.length > 0) {
                        events = events.slice(0, 2);

                        for (let j = 0; j < events.length; j++) {
                            const event: any = events[j];
                            const appoinmentObj: any = {}
                            let meetingId = null;
                            let Platform_Meeting_Id = null;
                            const { id, attendees, start: { dateTime: Start_TS }, end: { dateTime: End_TS }, conferenceData } = event;
                            if (conferenceData) {
                                const { entryPoints: [{ uri }] } = conferenceData;
                                Platform_Meeting_Id = uri;
                            }
                            const meeting_rows = await this.memberDA.FindMeetingDetails(id);
                            if (meeting_rows.length > 0) {
                                meetingId = meeting_rows[0].Meeting_Id;
                            }

                            appoinmentObj.Start_TS = Start_TS;
                            appoinmentObj.End_TS = End_TS;
                            appoinmentObj.Platform_Meeting_Id = Platform_Meeting_Id;
                            appoinmentObj.Client_Info = [];
                            appoinmentObj.Meeting_Id = meetingId;

                            if (attendees) {
                                for (let i = 0; i < attendees.length; i++) {
                                    const details = attendees[i];
                                    const { email, self } = details;
                                    if (!self) {
                                        let Name = null;
                                        const client_rows = await this.clientDA.FindClientDetails(email);
                                        if (client_rows.length > 0) {
                                            Name = client_rows[0].Name;
                                        }
                                        appoinmentObj.Client_Info.push({
                                            Name,
                                            Client_Iden: email
                                        })
                                    }
                                }
                                appoinments.push(appoinmentObj);
                            }
                            else
                                appoinments.push(appoinmentObj);
                        }
                        return resolve(appoinments);
                    }
                    else {
                        return resolve(appoinments);
                    }
                } catch (error) {
                    return reject(error);
                }
            }
            else {
                return resolve(appoinments);
            }
        })
    }

    GetHolidayListAndSave = async (req: Request, res: Response) => {
        try {
            const holidayList = await axios.get(`https://www.googleapis.com/calendar/v3/calendars/en.indian%23holiday%40group.v.calendar.google.com/events?key=${process.env.GOOGLE_API_KEY}`)

            console.log(holidayList.data.items);

            this.memberDA.SaveHolidays(holidayList.data.items);

            return res.status(200).send();
        } catch (error) {
            res.status(500).send(error);
        }
    }

    private FormatEventDetails(meetingDetails: IMeetingDetails[], clientDetils: IClientDetails[]) {
        for (let i = 0; i < meetingDetails.length; i++) {
            const meetingId = meetingDetails[i].meetingId;
            let tempClientDetails = []
            for (let j = 0; j < clientDetils.length; j++) {
                if (clientDetils[j].meetingId === meetingId) {
                    tempClientDetails.push(clientDetils[j]);
                }
            }
            meetingDetails[i].patientDetails = [...tempClientDetails]
        }
        return meetingDetails;
    }

    async HasOauth(userid: string): Promise<[boolean, string | null, string | null]> {
        const [Access_Token, Refresh_Token] = await this.GetDecryptedToken(userid);
        return Access_Token.length > 0 ? [true, Access_Token, Refresh_Token] : [false, null, null];
    }

    GetMemberProfile = async (req: Request, res: Response) => {
        try {
            const { userid } = req;
            let [IsOauthVerified] = await this.HasOauth(userid);

            const [[member_info], [{ Total_Patient }]] = await this.memberDA.GetMemberProfiledata(userid);

            return res.status(200).send({
                ...member_info, IsOauthVerified,
                Total_Patient
            })
        } catch (error) {
            return res.status(500).send(error);
        }
    }

    UpdateAppoinment = async (req: Request, res: Response) => {
        try {
            const { userid, body: { meetingId } } = req;

            const meeting_rows = await this.memberDA.ValidateMeetingIdWithUserId(meetingId, userid);
            if (meeting_rows.length > 0) {
                const { Event_Id } = meeting_rows[0];
                const eventDetails = this.CreateCalenderEventObject(req.body);

                const [Access_Token, Refresh_Token] = await this.GetDecryptedToken(userid);

                const event = await GoogleAPIClient.UpdateCalendarEvent(Access_Token, Refresh_Token, Event_Id, eventDetails) as any;

                try {
                    const {
                        id,
                        conferenceData: { conferenceSolution: { name }, entryPoints: [{ uri }] },
                        start: { dateTime: sdateTime },
                        end: { dateTime: edateTime },
                        status
                    } = event.data;

                    await this.memberDA.CreateMeetingDetails(id, uri, name, sdateTime, edateTime, userid, req.body, status, true, meetingId);
                    return res.status(200).send({ msg: SuccessMessage.MeetingUpdated, status: SuccessMessage.Success });
                } catch (error) {
                    throw error;
                }
            }
            else {
                return res.status(400).send({ msg: ErrorMessage.MeetingNotExist, status: ErrorMessage.Failed });
            }
        } catch (error) {
            return res.status(500).send({ msg: error, status: ErrorMessage.Failed });
        }
    }

    GetMeetingDetails = async (req: Request, res: Response) => {
        try {
            const { userid, query: { meetingId } } = req;

            let [meeting_details, client_details] = await this.memberDA.GetMeetings(userid, meetingId as string);
            let event_info = this.FormatEventDetails(meeting_details, client_details);
            return res.status(200).send({
                status: SuccessMessage.Success,
                event_info
            })
        } catch (error) {
            return res.status(500).send({
                msg: error,
                status: ErrorMessage.Failed
            })
        }
    }

    GetDecryptedToken = async (userid: string) => {
        try {
            const token_rows = await this.memberDA.GetTokenDetails(userid);
            if (token_rows.length > 0) {
                const { Access_Token, Refresh_Token } = token_rows[0];
                return [DecryptData(Access_Token, userid), DecryptData(Refresh_Token, userid)];
            }
            return ["", ""];
        } catch (error) {
            throw error;
        }
    }
}