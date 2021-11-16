-- Converted to SP -> sp_GetUpcomingMeeting.sql

DROP VIEW IF EXISTS vw_Upcoming_Appoinment;
CREATE VIEW vw_Upcoming_Appoinment AS
SELECT 
tbl_User.Frst_Name,
tbl_User.Last_Name,
tbl_User.Email,
tbl_Member.Reminder_Time, 
tbl_Member.Member_Id,
tbl_Meeting.Start_TS,
tbl_Meeting.End_TS,
tbl_Meeting.Summary,
tbl_Meeting.Event_Id,
tbl_Meeting.Meeting_Id
FROM tbl_User INNER JOIN tbl_Member 
ON tbl_User.User_Id = tbl_Member.Member_Id 
AND tbl_User.Is_Active = 'Y' 
INNER JOIN tbl_Meeting 
ON tbl_Meeting.Member_Id = tbl_User.User_Id 
AND tbl_Meeting.Is_Active = 'Y' 
AND CAST(tbl_Meeting.Start_TS AS DATE) = DATE_ADD(CURRENT_DATE, INTERVAL tbl_Member.Reminder_Time DAY)
