-- Converted to SP -> sp_GetMeetingDetails.sql

DROP VIEW IF EXISTS vw_Meeting_Det;
CREATE VIEW vw_Meeting_Det AS
SELECT tbl_Meeting.Member_Id, 
tbl_Meeting.Meeting_Id,
tbl_Meeting.Start_TS, 
tbl_Meeting.End_TS, 
tbl_Meeting.Description, 
tbl_Meeting.Summary, 
tbl_Meeting.Platform_Meeting_Id,
tbl_Client.Client_Iden,
tbl_Client.Client_Id,
tbl_Client.Is_Cres_Client,
tbl_User.Firebase_Id,
tbl_User.User_Type,
tbl_User.User_Id
FROM tbl_Meeting LEFT JOIN tbl_Client
ON tbl_Meeting.Meeting_Id = tbl_Client.Meeting_Id
AND tbl_Client.Is_Active = 'Y'
INNER JOIN tbl_User
ON tbl_User.User_Id = tbl_Meeting.Member_Id
AND tbl_User.Is_Active = 'Y'
WHERE
tbl_Meeting.Is_Active = 'Y'
Order By tbl_Meeting.Start_TS Desc