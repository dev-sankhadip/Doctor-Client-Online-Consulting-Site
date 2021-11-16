interface IMeetingTS {
    startTime: Date;
    endTime: Date;
}


export interface ILookup {
    Lookup_Cat: string;
    Lookup_Val: string;
    Lookup_Desc: string;
}

export interface IPhoneNumber extends IRefreshToken {
    Identification: string;
    User_Type: string;
    Is_Active: string;
    Email: string;
    Frst_Name: string;
    Last_Name: string;
    User_Id: string;
}

export interface IUserDet {
    phone_number: number;
    frst_name: string;
    last_name: string;
    email: string;
    user_type: string;
    refresh_token: string;
}

export interface IRefreshToken {
    Refresh_Token: string;
    Firebase_Id?: string;
}

export interface IMaxUserId {
    MaxId?: string;
}

export interface IPatientDet {
    name: string;
    ph: number;
    dob: Date;
    gender: string;
    email: string;
}

export interface IToken {
    Access_Token: string;
    Refresh_Token: string;
}



export interface IClient extends IMeetingTS {
    Client_Id: string;
    Name: string;
    Client_Iden: string;
}


export interface IMemberInfo {
    identification: number;
    frst_name: string;
    last_name: string;
    major_desc: string;
    spec_desc: string;
    email?: string;
}


export interface IMeeting {
    Member_Id: string;
    Meeting_Id: string;
    Start_TS: Date;
    End_TS: Date;
    Description: string;
    Summary: string;
    Platform_Meeting_Id: string;
    Client_Iden: string;
    Client_Id: string;
    Is_Cres_Client: string;
}

export interface ICustomObj {
    [key: string]: any
}

interface Job {
    JobName: string;
}

export interface IJobInfo {
    [key: string]: Job
}

export interface IJobDetais {
    Job_Name: string;
    Job_Id: string;
    Start_TS: Date;
    End_TS?: Date;
    Run_Status: string;
    Scheduled_TS?: Date;
    IsUpdate: boolean;
}

export interface ILog {
    Process_Name: string;
    Process_Type?: string;
    User_Id?: string;
    Job_Id?: string;
    Event_Id?: string;
    Meeting_Id?: string;
    Error_Message?: string;
    Key1?: string;
    Value1?: string;
    Response?: string;
}

export interface IMember extends IMemberInfo {
    Total_Patient: number;
    Created_On: Date;
    Photo_URL: string;
    Resume_URL: string;
    Addr: string;
    Reminder_Time: string;
    Major: string;
    Specification: string;
    Experience: string;
    IsOauth: boolean;
}



export interface IMeetingDetails extends IMeetingTS {
    memberId: string;
    meetingId: string;
    sessionInfo?: string;
    summary?: string;
    platformMeetingId?: string;
    patientDetails: IClientDetails[];
}

export interface IClientDetails {
    meetingId: string,
    Client_Iden: string,
    clientId: string;
    isCresClient: string
    name: string;
}


export interface INote {
    Resource: string;
    Resource_Type: string;
    Created_On: Date;
}