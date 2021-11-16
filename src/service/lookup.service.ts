import { Request, Response } from 'express'
import { Service } from 'typedi';
import LookupDA from '../DA/lookup.da';
import { ILookup } from '../types/interface';



@Service()
export default class LookupService {
    constructor(private readonly lookupDA: LookupDA) { }

    GetLookupValues = async (req: Request, res: Response) => {
        const result = await this.lookupDA.GetLookupValues<Array<ILookup>>();
        return res.send(result);
    }
}