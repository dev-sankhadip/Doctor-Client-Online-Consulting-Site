import { Router } from 'express';
import { Service } from 'typedi';
import SchedulerService from '../service/scheduler.service';



@Service()
export default class SchedulerRouter {

    constructor(private readonly schedulerService: SchedulerService) { }

    SetRouter(router: Router) {
        router.post('/send-reminder', this.schedulerService.SendAppoinmentReminder)
        router.get('/refresh-oauth-token', this.schedulerService.RefreshOauthAccessToken);
    }
}