DROP PROCEDURE IF EXISTS sp_CreateMeeting;
DELIMITER &&  
CREATE PROCEDURE sp_CreateMeeting(IN meetingId varchar(40), IN eventId TEXT, IN startTS datetime, IN endTS datetime, IN userId varchar(40), IN descr varchar(500), IN summary varchar(500), IN platformName varchar(20), IN platformMeetingId varchar(50), IN status varchar(10))
BEGIN
	DECLARE rowCount Int DEFAULT 0;
    
    SELECT COUNT(*) INTO rowCount FROM tbl_Meeting WHERE Event_Id = eventId AND Is_Active = 'Y';
    
    IF rowCount > 0 THEN
    	UPDATE tbl_Meeting SET Start_TS = startTS, End_TS = endTS, Description = descr, Summary = summary, Updated_On = CURRENT_TIMESTAMP, Status = status
        WHERE
        Event_Id = eventId;
    ELSE
    	Insert Into tbl_Meeting(Meeting_Id, Event_Id, Start_TS, End_TS, Member_Id, Description, Summary, Platform, Platform_Meeting_Id, Status) 
        Values(meetingId, eventId, startTS, endTS, userId, descr, summary , platformName, platformMeetingId, status);
    END IF;
    
END &&
DELIMITER ;