DROP PROCEDURE IF EXISTS sp_GetMeetingDetails;
DELIMITER &&  
CREATE PROCEDURE sp_GetMeetingDetails(IN prmUserId varchar(40), IN prmMeetingId varchar(40))
BEGIN
    SELECT tbl_Meeting.Member_Id AS memberId, 
    tbl_Meeting.Meeting_Id AS meetingId,
    tbl_Meeting.Start_TS AS startTime, 
    tbl_Meeting.End_TS AS endTime, 
    tbl_Meeting.Description AS sessionInfo, 
    tbl_Meeting.Summary AS summary, 
    tbl_Meeting.Platform_Meeting_Id AS platformMeetingId,
    tbl_Meeting.Event_Id AS eventId
    FROM tbl_Meeting INNER JOIN tbl_User
    ON tbl_User.User_Id = tbl_Meeting.Member_Id
    AND tbl_User.Is_Active = 'Y'
    AND tbl_Meeting.Is_Active = 'Y'
    AND tbl_User.User_Id = prmUserId
    AND (tbl_Meeting.Meeting_Id = prmMeetingId OR prmMeetingId IS NULL)
    -- AND CAST(tbl_Meeting.Start_TS AS DATE) >= CURDATE()
    Order By tbl_Meeting.Start_TS Asc;

    SELECT
    tbl_Meeting.Meeting_Id AS meetingId,
    tbl_Client.Client_Iden AS clientIden,
    tbl_Client.Client_Id AS clientId,
    tbl_Client.Is_Cres_Client AS isCresClient,
    tbl_Client.Name AS name,
    tbl_Client.Gender AS gender,
    tbl_Client.Ph AS ph,
    tbl_Client.DOB AS dob
    FROM tbl_Meeting INNER JOIN tbl_Client
    ON tbl_Meeting.Meeting_Id = tbl_Client.Meeting_Id
    AND tbl_Client.Is_Active = 'Y'
    AND tbl_Meeting.Is_Active = 'Y'
    AND tbl_Meeting.Member_Id = prmUserId
    AND (tbl_Meeting.Meeting_Id = prmMeetingId OR prmMeetingId IS NULL);
    -- AND CAST(tbl_Meeting.Start_TS AS DATE) >= CURDATE();
END &&
DELIMITER ;
