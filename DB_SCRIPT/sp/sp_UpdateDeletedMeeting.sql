DROP PROCEDURE IF EXISTS sp_UpdateDeletedMeeting;
DELIMITER &&
CREATE PROCEDURE sp_UpdateDeletedMeeting(dataList TEXT, userType VARCHAR(10), eventId TEXT)
BEGIN
	
    IF userType = 'CLIENT' THEN
    	UPDATE tbl_Client INNER JOIN tbl_Meeting 
        ON tbl_Client.Meeting_Id = tbl_Meeting.Meeting_Id
        AND tbl_Meeting.Event_Id = eventId
        AND tbl_Meeting.Is_Active = 'Y'
       	AND NOT FIND_IN_SET(Client_Iden, dataList)
        SET tbl_Client.Is_Active = 'N', tbl_Client.Updated_On = CURRENT_TIMESTAMP;
    ELSE
        UPDATE tbl_Meeting SET Is_Active = 'N', Updated_On = CURRENT_TIMESTAMP
        WHERE
        NOT FIND_IN_SET(Event_Id, dataList) And Start_TS >= CURRENT_TIMESTAMP;
    
        UPDATE tbl_Client INNER JOIN tbl_Meeting 
        ON tbl_Client.Meeting_Id = tbl_Meeting.Meeting_Id
        AND tbl_Meeting.Start_TS >= CURRENT_TIMESTAMP
        AND NOT FIND_IN_SET(Event_Id, dataList)
        SET tbl_Client.Is_Active = 'N', tbl_Client.Updated_On = CURRENT_TIMESTAMP;
    END IF;
END &&
DELIMITER ;