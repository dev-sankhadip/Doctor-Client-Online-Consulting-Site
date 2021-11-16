import { calendar_v3 } from "googleapis";
import { Service } from "typedi";
import { GenerateUUID } from "../lib/commonFunctions";
import { IClient, IClientDetails, IMeetingDetails, IMember, IPatientDet, IToken } from "../types/interface";
import { DBqueries, DBsp } from "../VO/dBQueries";
import DbConnection from "./dbConnection";


@Service()
export default class MemberDA extends DbConnection {
    constructor() {
        super();
    }


    async CreateMeetingDetails(
        eventId: string,
        platformMeetingId: string,
        platformName: string,
        sdateTime: string,
        edateTime: string,
        user_id: string,
        requestBody: any,
        status: string,
        IsUpdate: boolean = false,
        meetingId?: string
    ) {
        try {
            let queryList = [];
            let paramsList = [];

            const { summary, sessionInfo, patientDetails } = requestBody;
            meetingId = IsUpdate ? meetingId : GenerateUUID();

            // queryList.push(DBqueries.CreateMeetingDetails);
            // paramsList.push([meetingId, eventId, new Date(sdateTime), new Date(edateTime), user_id, sessionInfo, summary, platformName, platformMeetingId, status]);

            queryList.push(DBsp.CreateMeetingDetails);
            paramsList.push([meetingId, eventId, new Date(sdateTime), new Date(edateTime), user_id, sessionInfo, summary, platformName, platformMeetingId, status]);

            let attendeeListFromGoogle = "";
            await patientDetails.map(async (details: IPatientDet) => {
                const { email, ph, name, dob, gender } = details;
                console.log(email);
                attendeeListFromGoogle += `,${email}`;

                queryList.push(DBsp.CreateClientDetails);
                paramsList.push([GenerateUUID(), meetingId, email, name, ph, dob, gender, user_id, eventId, IsUpdate ? 'Y' : 'N']);
            })
            queryList.push(DBsp.UpdateDeletedMeetings);
            paramsList.push([attendeeListFromGoogle.replace(/(^,)|(,$)/g, ""), 'CLIENT', eventId]);

            await this.InsertOrUpdateDB(queryList, paramsList);
        } catch (error) {
            throw error;
        }
    }

    async SaveMeetingDetailsFromGoogleCalendar(events: calendar_v3.Schema$Event[], user_id: string) {
        try {

            let queryList: string[] = [];
            let paramsList: (string | number | null)[][] = [];
            let eventListFromGoogle = "";
            let eventList: any[] = [];

            if (events.length > 0) {

                await events.map(async (event: any) => {
                    const {
                        id,
                        conferenceData,
                        start: { dateTime: sdateTime },
                        end: { dateTime: edateTime },
                        attendees,
                        summary,
                        description,
                        status
                    } = event;
                    eventList.push(id);

                    const meetingId = GenerateUUID();
                    let platformName = null;
                    let platformMeetingId = null;

                    eventListFromGoogle += `,${id}`;
                    if (conferenceData) {
                        const { conferenceSolution: { name }, entryPoints: [{ uri }] } = conferenceData;
                        platformName = name;
                        platformMeetingId = uri;
                    }
                    queryList.push(DBsp.CreateMeetingDetails);
                    paramsList.push([meetingId, id, new Date(sdateTime), new Date(edateTime), user_id, description ?? null, summary ?? null, platformName, platformMeetingId, status]);

                    if (attendees) {
                        let attendeeListFromGoogle = "";
                        await attendees.map(async (details: any) => {
                            const { email, self } = details;
                            if (!self) {
                                let client_Id = GenerateUUID();

                                queryList.push(DBsp.CreateClientDetails);
                                paramsList.push([client_Id, meetingId, email, null, null, null, null, user_id, id, 'N']);

                                attendeeListFromGoogle += `,${email}`;
                            }
                        })
                        queryList.push(DBsp.UpdateDeletedMeetings);
                        paramsList.push([attendeeListFromGoogle.replace(/(^,)|(,$)/g, ""), 'CLIENT', id]);
                    }
                })
                queryList.push(DBsp.UpdateDeletedMeetings);
                paramsList.push([eventListFromGoogle.replace(/(^,)|(,$)/g, ""), 'MEETING', null]);
            }
            await this.InsertOrUpdateDB(queryList, paramsList);
        } catch (error) {
            throw error;
        }
    }

    async CreateTokenDetails(user_id: string, email: string, Access_Token: string, Refresh_Token: string) {
        try {
            let queryList: string[] = [];
            let paramsList: (string | number | null)[][] = [];

            queryList.push(DBqueries.SoftDeleteToken);
            paramsList.push(["N", user_id]);

            queryList.push(DBqueries.CreateTokenDetails);
            paramsList.push([user_id, email, Access_Token, Refresh_Token]);

            await this.InsertOrUpdateDB(queryList, paramsList);
        } catch (error) {
            throw error;
        }
    }

    async GetTokenDetails(user_id: string) {
        try {
            return await this.ReadDB<IToken[]>(DBqueries.GetTokenDetails, [user_id]);
        } catch (error) {
            throw error;
        }
    }

    async GetMemberInfo(user_id: string) {
        try {
            return this.ReadDB<IMember[][]>(DBsp.GetMemberInfo, [user_id])
        } catch (error) {
            throw error;
        }
    }

    async GetMeetings(user_id: string, meetingId?: string) {
        try {
            return this.ReadDB<[IMeetingDetails[], IClientDetails[]]>(DBsp.GetUpcomingMeetings, [user_id, meetingId ?? null])
        } catch (error) {
            throw error;
        }
    }

    async GetPatientInfo(user_id: string) {
        try {
            return this.ReadDB<IClient[]>(DBqueries.GetPatientInfo, [user_id]);
        } catch (error) {
            throw error;
        }
    }

    async SaveHolidays(holidayList: Array<any>) {
        try {
            if (holidayList.length > 0) {
                let queryList: string[] = [];
                let paramsList: (string | number | null)[][] = [];

                await holidayList.map((item) => {
                    const meetingId = GenerateUUID();
                    queryList.push(DBqueries.SaveHolidayList);
                    paramsList.push([meetingId, item.id, item.description, item.status, item.summary, item.start.date, item.end.date])

                })
                await this.InsertOrUpdateDB(queryList, paramsList);
            }
        } catch (error) {
            throw error;
        }
    }

    async GetHolidayList() {
        try {
            return this.ReadDB<IMeetingDetails[]>(DBqueries.GetHolidayList);
        } catch (error) {
            throw error;
        }
    }

    async GetUpcomingAppoinments() {
        try {
            return await this.ReadDB<any[][]>(DBsp.GetUpcomingAppoinment);
        } catch (error) {
            throw error;
        }
    }

    async GetMemberProfiledata(userid: string) {
        try {
            return this.ReadDB<any>(DBsp.GetMemberInfo, [userid]);
        } catch (error) {
            throw error;
        }
    }

    async ValidateMeetingIdWithUserId(meetingId: string, userid: string) {
        try {
            return this.ReadDB<any[]>(DBqueries.ValidateMeetingIdWithUserId, [meetingId, userid, 'Y'])
        } catch (error) {
            throw error;
        }
    }

    async FindMeetingDetails(eventId: string) {
        return this.ReadDB<any[]>(DBqueries.FindMeetingDetails, [eventId]);
    }

    async GetRefreshTokenList() {
        return this.ReadDB<any[]>(DBqueries.GetAllRefreshToken);
    }

    async SoftDeleteOauthToken(user_id: string) {
        this.InsertOrUpdateDB([DBqueries.SoftDeleteToken], [['N', user_id]])
    }
}