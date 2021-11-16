import { ICustomObj, IJobInfo } from "../types/interface";

export const Meeting_Desc_Prefix = "Cresline Care"

export const Appoinment_Reminder_Suffix = "REM"


export const Oauth_Scopes = [
    'https://www.googleapis.com/auth/calendar.events',
    'https://www.googleapis.com/auth/calendar',
    'https://www.googleapis.com/auth/userinfo.profile',
    'https://www.googleapis.com/auth/userinfo.email'
];
export const Oauth_Scopes_Desc: ICustomObj = {
    'https://www.googleapis.com/auth/calendar.events': "Please Approve Calendat View And Edit Permission",
    'https://www.googleapis.com/auth/calendar': "Please Approve Calendar Events Share And Permanent Delete Permission",
    'https://www.googleapis.com/auth/userinfo.profile': "Please Approve View Personsl Info Permission",
    'https://www.googleapis.com/auth/userinfo.email': "Please Approve View Email Address Permission"
}



export const Note_Lookup_Type = "Notes_Type";


export const Template_IDs = {
    Signup: "SIGNUP",
    Reminder: "MEETING_REMINDER",
    Alert: "ALERT",
    Note: "NOTE"
}


export const Job_Details: IJobInfo = {
    '0': {
        JobName: "APPOINMENT_REMINDER"
    }
}

export const MAX_YEAR_IN_CALENDAR = 1;

export const EncDecAlgorithm = "aes-256-ecb";