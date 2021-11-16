import { Service } from "typedi";
import { BoolToYnN } from "../lib/commonFunctions";
import { IMaxUserId, IMember, IPhoneNumber, IRefreshToken, IUserDet } from "../types/interface";
import { DBqueries, DBsp } from "../VO/dBQueries";
import DbConnection from "./dbConnection";



@Service()
export default class UserDA extends DbConnection {
    constructor() {
        super();
    }


    async CheckIfUserExists(phone_number: any): Promise<IPhoneNumber[]> {
        try {
            return await this.ReadDB<IPhoneNumber[]>(DBqueries.CheckIfUserExists, [phone_number])
        } catch (error) {
            throw error;
        }
    }

    async CheckIfUserExistsByUserId(user_id: string): Promise<IPhoneNumber[]> {
        try {
            return await this.ReadDB<IPhoneNumber[]>(DBqueries.CheckIfUserExistsByUserId, [user_id])
        } catch (error) {
            throw error;
        }
    }

    async InsertUserDetails({ phone_number, frst_name, last_name, email, refresh_token, user_type }: IUserDet, user_id: string, firebase_id: string): Promise<void> {
        try {
            let queryList = [];
            let paramsList = [];

            queryList.push(DBqueries.InsertUser);
            paramsList.push([firebase_id, phone_number, user_id, user_type, frst_name, last_name, email, refresh_token, user_type == 'P' ? 'P' : 'Y'])

            queryList.push(user_type == 'P' ? DBqueries.InsertPracDetails : DBqueries.InsertSeekerDetails);
            paramsList.push([user_id]);

            await this.InsertOrUpdateDB(queryList, paramsList);

        } catch (error) {
            throw error;
        }
    }

    async GenerateUserId(): Promise<IMaxUserId[]> {
        try {
            return await this.ReadDB<IMaxUserId[]>(DBqueries.GetMaxUserId);
        } catch (error) {
            throw error;
        }
    }

    async UpdatePracDetails(major: string, spec: string, experience: string, firebase_id: string): Promise<void> {
        try {
            let queryList = [];
            let paramsList = [];

            queryList.push(DBqueries.UpdatePracDetails);
            paramsList.push([firebase_id, major, spec, experience]);

            queryList.push(DBqueries.UpdateUserStatus);
            paramsList.push(['Y', firebase_id, 'P']);

            await this.InsertOrUpdateDB(queryList, paramsList);
        } catch (error) {
            throw error;
        }
    }

    async UpdateUserDetails(frst_name: string, last_name: string, email: string, refresh_token: string, phone_number: number, ActiveFlag: string) {
        try {
            await this.InsertOrUpdateDB([DBqueries.UpdateUserDetails], [[frst_name, last_name, email, refresh_token, phone_number, ActiveFlag]])
        } catch (error) {
            throw error;
        }
    }

    async GetRefreshToken(refresh_token: string): Promise<IRefreshToken[]> {
        try {
            return await this.ReadDB<IRefreshToken[]>(DBqueries.CheckRefreshToken, [refresh_token])
        } catch (error) {
            throw error;
        }
    }

    async UpdateRefreshToken(refresh_token: string, firebase_id: string): Promise<void> {
        try {
            await this.InsertOrUpdateDB([DBqueries.UpdateRefreshToken], [[refresh_token, firebase_id]])
        } catch (error) {
            throw error;
        }
    }

    async Login(refresh_token: string, firebase_id: string): Promise<void> {
        try {
            await this.InsertOrUpdateDB([DBqueries.UpdateRefreshToken], [[refresh_token, firebase_id]])
        } catch (error) {
            throw error;
        }
    }

    async RegisterUsingReferalCode(iden: string, code: string) {
        try {
            return await this.InsertOrUpdateDB([DBsp.ReferUser], [[iden, code]]);
        } catch (error) {
            throw error;
        }
    }

    async UpdateUserEmailId(email: string, user_id: string) {
        try {
            await this.InsertOrUpdateDB([DBqueries.UpdateUserEmailId], [[email, user_id, 'Y']])
        } catch (error) {
            throw error;
        }
    }

    async UpdateMemberDetails(memberDetails: IMember, userid: string) {
        try {
            const { frst_name, last_name, email, Major, Specification, Experience, Photo_URL, Addr, Reminder_Time, Resume_URL, IsOauth } = memberDetails;
            return await this.InsertOrUpdateDB([DBsp.UpdateMember], [[frst_name, last_name, email, Major, Specification, Experience, Photo_URL, Resume_URL, Addr, Reminder_Time, BoolToYnN(IsOauth), userid]])
        } catch (error) {
            throw error;
        }
    }

    async GetUserIdByExternalUserId(exId: any) {
        try {
            return await this.ReadDB<any[]>(DBqueries.GetUserIdByExternalId, [exId, 'Y']);
        } catch (error) {
            throw error;
        }
    }

    async CheckIfEmailAlreadyExists(emailId: string): Promise<IPhoneNumber[]> {
        try {
            return await this.ReadDB<IPhoneNumber[]>(DBqueries.CheckIfEmailAlreadyExists, [emailId])
        } catch (error) {
            throw error;
        }
    }
}