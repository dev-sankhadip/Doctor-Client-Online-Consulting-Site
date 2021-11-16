import { Service } from "typedi";
import { IJobDetais, ILog } from "../types/interface";
import { DBqueries } from "../VO/dBQueries";
import DbConnection from "./dbConnection";


@Service()
export default class SchedulerDA extends DbConnection {
    constructor() {
        super();
    }

    async CreateOrUpdateJob(jobDetails: IJobDetais) {
        try {
            const { Job_Id, Job_Name, Start_TS, Run_Status, Scheduled_TS, IsUpdate } = jobDetails;
            if (!IsUpdate)
                await this.InsertOrUpdateDB([DBqueries.CreateJob], [[Job_Name, Job_Id, Start_TS, Run_Status, Scheduled_TS]]);
            else if (IsUpdate) {
                await this.InsertOrUpdateDB([DBqueries.UpdateJob], [[Run_Status, Job_Id]])
            }
        } catch (error) {
            throw error;
        }
    }

    async CreateLog(logDetails: ILog) {
        try {
            const { Process_Name, Process_Type, User_Id, Job_Id, Event_Id, Meeting_Id, Error_Message } = logDetails;
            await this.InsertOrUpdateDB([DBqueries.CreateLog], [[Process_Name, Process_Type, User_Id, Job_Id, Event_Id, Meeting_Id, Error_Message]])
        } catch (error) {
            throw error;
        }
    }

    async CreateApiLog(logDetails: ILog) {
        try {
            const { Process_Name, Key1, Value1, Response } = logDetails;
            await this.InsertOrUpdateDB([DBqueries.CreateApiLogs], [[Process_Name, Key1, Value1, Response]]);
        } catch (error) {
            throw error;
        }
    }
}