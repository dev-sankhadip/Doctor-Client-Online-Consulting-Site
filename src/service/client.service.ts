import { Service } from 'typedi';
import ClientDA from '../DA/client.da';
import { Request, Response } from 'express'
import { GenerateUUID } from '../lib/commonFunctions';
import { ErrorMessage, SuccessMessage } from '../VO/messages';
import AwsClient from '../lib/awsClient';
import LookupDA from '../DA/lookup.da';
import { Note_Lookup_Type, Template_IDs } from '../VO/constants';
import SchedulerDA from '../DA/scheduler.da';
import axios from '../lib/axios';
import * as dotenv from 'dotenv';
dotenv.config();


@Service()
export default class ClientService {
    constructor(private readonly clientDA: ClientDA,
        private readonly lookupDA: LookupDA,
        private readonly schedulerDA: SchedulerDA
    ) { }

    GetPatientInfo = async (req: Request, res: Response) => {
        try {
            const { query: { client_Id }, userid } = req;

            const [[patient_info], last_appoinment, next_appoinment] = await this.clientDA.GetPatientInfo(client_Id as string, userid);
            const files = await this.clientDA.GetFiles(client_Id as string);


            res.status(200).send({
                patient_info,
                last_appoinment,
                next_appoinment,
                files
            });
        } catch (error) {
            console.log(error);
            res.status(500).send(error);
        }
    }

    GetPatientList = async (req: Request, res: Response) => {
        try {
            const { userid } = req;
            const [patient_list] = await this.clientDA.GetPatientList(userid as any);

            res.status(200).send(patient_list);
        } catch (error) {
            console.log(error);
            res.status(500).send(error);
        }
    }

    SavePatintNote = async (req: Request, res: Response) => {
        try {
            let { noteId, clientId, meetingId, resource, resourceType } = req.body;

            let err_msg = []
            let IsNewNote: boolean = true;
            let user_id = req.userid;

            let notes_rows = null;

            const lookup_rows = await this.lookupDA.ValidateLookup(Note_Lookup_Type, resourceType);
            if (lookup_rows.length > 0) {
                if (!noteId) {
                    notes_rows = await this.clientDA.ValidateNoteForMeeting(clientId, meetingId, resourceType);
                    if (notes_rows.length > 0)
                        err_msg.push(ErrorMessage.NoteExistForMeeting);
                    else
                        noteId = GenerateUUID();
                }
                else {
                    notes_rows = await this.clientDA.ValidateNoteId(noteId, resourceType);
                    if (notes_rows.length == 0) {
                        err_msg.push(ErrorMessage.NoteNotExist);
                    }
                    else {
                        IsNewNote = false;
                    }
                }
                if (err_msg.length == 0) {
                    const client_rows = await this.clientDA.ValidateClientId(clientId);
                    if (client_rows.length > 0) {
                        const meeting_rows = await this.clientDA.ValidateMeetingId(meetingId);
                        if (meeting_rows.length > 0) {
                            if (resourceType == 'PN') {
                                const clientIden = client_rows[0].Client_Iden;
                                let notes = [];
                                if (!IsNewNote) {
                                    notes = JSON.parse(notes_rows[0].Resource).Notes;
                                }
                                const resources = {
                                    'Notes': [
                                        ...notes,
                                        {
                                            'note': resource, 'ts': new Date()
                                        }
                                    ]
                                }

                                try {
                                    const result = await axios.post(process.env.EMAIL_ENGINE_URL as string + '/users/sendmail', { templateId: Template_IDs.Note, email: clientIden, data: resources });
                                    await this.schedulerDA.CreateApiLog({
                                        Process_Name: 'Save Patient Note SES',
                                        Key1: 'Note ID', Value1: noteId,
                                        Response: JSON.stringify(result.data)
                                    })
                                } catch (error) {
                                    await this.schedulerDA.CreateLog({
                                        Process_Name: "Save Patient Note SES",
                                        Process_Type: "ERROR_LOG",
                                        User_Id: noteId,
                                        Error_Message: JSON.stringify(error)
                                    })
                                }
                                await this.clientDA.SaveNotes(noteId, user_id, meetingId, clientId, JSON.stringify(resources), resourceType, IsNewNote);
                                return res.status(200).send({
                                    noteId,
                                    status: SuccessMessage.Success
                                });
                            }
                            await this.clientDA.SaveNotes(noteId, user_id, meetingId, clientId, resource, resourceType, IsNewNote);
                            return res.status(200).send({
                                noteId,
                                status: SuccessMessage.Success
                            });
                        }
                        else {
                            err_msg.push(ErrorMessage.MeetingNotExist);
                        }
                    }
                    else {
                        err_msg.push(ErrorMessage.ClientNotExist);
                    }
                }
            }
            else
                err_msg.push(ErrorMessage.InvalidLookupValue)
            return res.status(403).send([err_msg]);
        } catch (error) {
            console.log(error);
            res.status(500).send(error);
        }
    }

    UploadPatientMeetingFile = async (req: Request, res: Response) => {
        try {
            // const awsdata = await AwsClient.CreateBucket(process.env.AWS_BUCKET_NAME as string);
            // console.log(awsdata);

            // return res.status(200).send(awsdata);

            const { userid, body: { clientId, meetingId } } = req;

            const file = req.files?.file;

            if (!file) {
                return res.status(400).send({ status: ErrorMessage.Failed, msg: ErrorMessage.FileNotAttached });
            }

            if (meetingId) {
                const meeting_rows = await this.clientDA.ValidateMeetingId(meetingId);
                if (meeting_rows.length === 0) {
                    return res.status(400).send({ status: ErrorMessage.Failed, msg: ErrorMessage.MeetingNotExist });
                }
            }

            const client_rows = await this.clientDA.ValidateClientId(clientId);
            if (client_rows.length > 0) {

                const { Location } = await AwsClient.UploadFileToS3(file);

                await this.clientDA.SaveFile(clientId, userid, Location, meetingId);

                return res.status(200).send({ status: SuccessMessage.Success, Location });
            }
            return res.status(400).send({
                status: ErrorMessage.Failed,
                msg: ErrorMessage.InvalidClientId
            });
        } catch (error) {
            res.status(500).send({ status: ErrorMessage.Failed, msg: error });
        }
    }

    GetNote = async (req: Request, res: Response) => {
        try {
            const { noteId } = req.query;

            let notes = await this.clientDA.GetNotes(noteId as string);

            if (notes.length > 0) {
                notes.map((note, index) => {
                    notes[index].Resource = notes[index].Resource_Type == 'PN' ?
                        JSON.parse(notes[index].Resource).Notes : notes[index].Resource;
                })
                return res.status(200).send(notes);
            }
            return res.status(204).send();

        } catch (error) {
            res.status(500).send(error);
        }
    }

    DeleteFile = async (req: Request, res: Response) => {
        try {
            const { query: { fileId } } = req;

            await this.clientDA.DeleteFile(fileId as string, 'N');
            return res.status(200).send({
                status: SuccessMessage.Success,
                msg: SuccessMessage.FileDeleted
            })
        } catch (error) {
            res.status(500).send({
                status: ErrorMessage.Failed,
                msg: error
            })
        }
    }
}