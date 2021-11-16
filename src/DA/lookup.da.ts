import { Service } from "typedi";
import { DBqueries } from "../VO/dBQueries";
import DbConnection from "./dbConnection";



@Service()
export default class LookupDA extends DbConnection {
    constructor() {
        super();
    }

    async GetLookupValues<T>() {
        const result = await this.ReadDB<T>(DBqueries.GetLookupValues);
        return result as T;
    }

    async ValidateLookup(Lookup_Cat: string, Lookup_Val: string) {
        return await this.ReadDB<any[]>(DBqueries.ValidateLookup, [Lookup_Cat, Lookup_Val])
    }
}