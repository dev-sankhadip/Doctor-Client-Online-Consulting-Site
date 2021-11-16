import { Router } from 'express';
import { Service } from 'typedi';
import { VerifyUser } from '../middleware/verifyUser';
import ClientService from '../service/client.service';

@Service()
export default class ClientRouter {
    constructor(private readonly clientService: ClientService) { }

    SetRouter(router: Router) {
        router.get('/patient', VerifyUser, this.clientService.GetPatientInfo);
        router.get('/patient-list', VerifyUser, this.clientService.GetPatientList);
        router.post('/create-note', VerifyUser, this.clientService.SavePatintNote);
        router.post('/patient-file-upload', VerifyUser, this.clientService.UploadPatientMeetingFile);
        router.get('/note', VerifyUser, this.clientService.GetNote);
        router.delete('/delete-file', VerifyUser, this.clientService.DeleteFile);
    }
}