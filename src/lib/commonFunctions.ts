import { v4 as UUIDv4 } from 'uuid';
import crypto from 'crypto';
import { EncDecAlgorithm, MAX_YEAR_IN_CALENDAR } from '../VO/constants';


export const FormatDate = (tempDate: Date): string => {
    const month = (tempDate.getMonth() + 1) >= 10 ? tempDate.getMonth() + 1 : "0" + (tempDate.getMonth() + 1)
    const day = tempDate.getDate() >= 10 ? tempDate.getDate() : "0" + tempDate.getDate()
    return tempDate.getFullYear() + "-" + month + "-" + day
}

export const GenerateUUID = (): string => {
    return UUIDv4();
}


export const ConvertUndefinedToNull = (array: any[]): any[] => {
    const newArr = array.map((item) => item ?? null)
    return newArr;
}

export const IsEmail = (email: string): boolean => {
    const emailRegex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    if (emailRegex.test(email)) {
        return true;
    }
    return false;
}

export const BoolToYnN = (value: boolean) => {
    return value ? 'Y' : 'N';
}

export const GetCalendarMaxdate = (): Date => {
    let todaydate = new Date();
    return new Date(todaydate.getFullYear() + MAX_YEAR_IN_CALENDAR, todaydate.getMonth(), todaydate.getDay());
}


export const GenerateRandomBytes = () => {
    return crypto.randomBytes(16);
}


const GetEmptyBuffer = () => {
    return Buffer.from("");
}

export const EncryptData = (data: any, key: string, iv?: any): string => {
    try {
        const cipher = crypto.createCipheriv(EncDecAlgorithm, key.substr(0, 32), iv ?? null);

        let encryptedData = cipher.update(data, "utf-8", "hex");

        encryptedData += cipher.final("hex");

        return encryptedData;
    } catch (error) {
        throw error;
    }
}


export const DecryptData = (data: any, key: string, iv?: any): string => {
    try {
        const decipher = crypto.createDecipheriv(EncDecAlgorithm, key.substr(0, 32), iv ?? null);

        let decryptedData = decipher.update(data, "hex", "utf-8");

        decryptedData += decipher.final("utf8");

        return decryptedData;
    } catch (error) {
        throw error;
    }
}