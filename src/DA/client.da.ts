import { Service } from "typedi";
import { GenerateUUID } from "../lib/commonFunctions";
import { INote } from "../types/interface";
import { DBqueries, DBsp } from "../VO/dBQueries";
import DbConnection from "./dbConnection";

@Service()
export default class ClientDA extends DbConnection {
    constructor() {
        super();
    }

    async GetPatientInfo(clientId: string, userId: string) {
        try {
            return this.ReadDB<any[]>(DBsp.GetPatientInfo, [clientId, userId]);
        } catch (error) {
            throw error;
        }
    }

    async GetPatientList(memberId?: string) {
        try {
            return this.ReadDB<any[]>(DBsp.GetPatientListBymemberId, [memberId ?? null])
        } catch (error) {
            throw error;
        }
    }

    async SaveNotes(notesId: string, memberId: string, meetingId: any, clientId: any, notes: string, resourceType: string, IsNewNote: boolean) {
        try {
            let queryList = [];
            let paramsList = [];

            if (IsNewNote) {
                queryList.push(DBqueries.SaveNotes);
                paramsList.push([memberId, notesId, clientId, meetingId, resourceType, notes])
            }
            else {
                queryList.push(DBqueries.UpdateNotes);
                paramsList.push([notes, notesId])
            }

            await this.InsertOrUpdateDB(queryList, paramsList);

        } catch (error) {
            throw error;
        }
    }

    async ValidateMeetingId(meetingId: string) {
        return this.ReadDB<any[]>(DBqueries.CheckIfMeetingExists, [meetingId, 'Y'])
    }

    async ValidateClientId(clientId: string) {
        return this.ReadDB<any[]>(DBqueries.CheckIfClientExists, [clientId, 'Y'])
    }

    async ValidateNoteId(noteId: string, resourceType: string) {
        return this.ReadDB<any[]>(DBqueries.CheckIfNotesExists, [noteId, resourceType])
    }

    async ValidateNoteForMeeting(clientId: string, meetingId: string, resourceType: string) {
        return this.ReadDB<any[]>(DBqueries.CheckIfNotesForMeetingExists, [clientId, meetingId, resourceType])
    }

    async SaveFile(clientId: string, memberId: string, filePath: string, meetingId?: string) {
        await this.InsertOrUpdateDB([DBqueries.SaveFile], [[GenerateUUID(), clientId, memberId, meetingId, filePath]]);
    }

    async GetFiles(clientId: string) {
        return this.ReadDB<any[]>(DBqueries.GetFiles, [clientId, 'Y']);
    }

    async GetNotes(noteId: string) {
        return this.ReadDB<INote[]>(DBqueries.GetNote, [noteId]);
    }

    async DeleteFile(fileId: string, activeFlag: string) {
        await this.InsertOrUpdateDB([DBqueries.DeleteFile], [[activeFlag, fileId]]);
    }

    async FindClientDetails(clientIden: string) {
        return this.ReadDB<any[]>(DBqueries.FindClientDetails, [clientIden]);
    }
}