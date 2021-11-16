import { Router } from 'express';
import { Service } from 'typedi';
import { VerifyUser } from '../middleware/verifyUser';
import { ValidateSignup } from '../schema/signup';
import { ValidateUpdateMember } from '../schema/updateMember';
import UserService from '../service/user.service';


@Service()
export default class UserRouter {

    constructor(private readonly userService: UserService) { }

    SetRouter(router: Router) {
        router.get('/check-user', this.userService.CheckUserExistByNumber);
        router.post('/signup', ValidateSignup, this.userService.Signup);
        router.post('/refresh-token', this.userService.RefreshToken);
        router.post('/login', this.userService.Login);
        router.post('/register-refered-user', this.userService.RegisterUsingReferalCode);
        router.put('/member', VerifyUser, ValidateUpdateMember, this.userService.UpdateMemberDetails);
    }
}