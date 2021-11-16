import { Router } from 'express';
import { Service } from 'typedi';
import { VerifyUser } from '../middleware/verifyUser';
import LookupService from '../service/lookup.service';



@Service()
export default class LookupRouter {
    
    constructor(private readonly lookupService: LookupService) { }

    SetRouter(router: Router) {
        router.get('/lookup', VerifyUser, this.lookupService.GetLookupValues)
    }
}