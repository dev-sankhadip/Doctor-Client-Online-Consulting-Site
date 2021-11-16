import { Router } from 'express';
import { Service } from 'typedi';
import { VerifyUser } from '../middleware/verifyUser';
import { ValidateCreateAppoiment, ValidateUpdateAppoiment } from '../schema/createAndUpdateMeeting';
import MemberService from '../service/member.service';


@Service()
export default class DashboardRouter {
    constructor(private readonly memberService: MemberService) { }

    SetRouter(router: Router) {
        router.get('/calender', VerifyUser, this.memberService.GetUserCalender);
        router.post('/create-meeting', VerifyUser, ValidateCreateAppoiment, this.memberService.CreateAppoiment);
        router.post('/oauth', VerifyUser, this.memberService.GetUserOauth2Data);
        router.post('/generate-oauth-url', VerifyUser, this.memberService.CreateAuthURL);
        router.get('/member-info', VerifyUser, this.memberService.GetMemberInfo);
        router.get('/holiday-list', VerifyUser, this.memberService.GetHolidayListAndSave);
        router.get('/member-profile', VerifyUser, this.memberService.GetMemberProfile);
        router.put('/meeting', VerifyUser, ValidateUpdateAppoiment, this.memberService.UpdateAppoinment);
        router.get('/meeting', VerifyUser, this.memberService.GetMeetingDetails);
    }
}