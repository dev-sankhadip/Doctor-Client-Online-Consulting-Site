DROP PROCEDURE IF EXISTS sp_CreateClient;
DELIMITER &&  
CREATE PROCEDURE sp_CreateClient(IN clientId varchar(40), IN meetingId varchar(40), IN seekerIden varchar(100), IN seekerName varchar(40), IN seekerPh varchar(12), IN seekerDOB datetime, IN seekerGender varchar(1), IN memberId varchar(40), IN eventId TEXT, IN isUpdate varchar(1))
BEGIN
	DECLARE rowCount INT DEFAULT 0;
    DECLARE isCresClientFlag VARCHAR(1) DEFAULT 'N';
    DECLARE seekerId VARCHAR(40) DEFAULT NULL;
    
    Select User_Id INTO seekerId From tbl_User Where Email = seekerIden And Is_Active = 'Y';
    -- Checks If Client Is Of Creslin Or Not
    IF seekerId <> NULL THEN
    	SET isCresClientFlag = 'Y';
    END IF;

    SELECT COUNT(*) INTO rowCount FROM tbl_Client INNER JOIN tbl_Meeting
    ON tbl_Client.Meeting_Id = tbl_Meeting.Meeting_Id
    AND tbl_Meeting.Event_Id = eventId
    AND tbl_Client.Client_Iden = seekerIden 
    AND tbl_Client.Is_Active = 'Y'
	AND tbl_Meeting.Is_Active = 'Y';
    
	IF isUpdate = 'Y' AND rowCount > 0 THEN
        UPDATE tbl_Client INNER JOIN tbl_Meeting 
        ON tbl_Client.Meeting_Id = tbl_Meeting.Meeting_Id
        AND tbl_Meeting.Event_Id = eventId
        AND tbl_Meeting.Is_Active = 'Y'
       	AND tbl_Client.Client_Iden = seekerIden
        SET tbl_Client.Name = seekerName,
        tbl_Client.Ph = seekerPh,
        tbl_Client.DOB = seekerDOB,
        tbl_Client.Gender = seekerGender,
        tbl_Client.Updated_On = CURRENT_TIMESTAMP;
	END IF;
    -- Create New Client If Client doesn't exist in our system
    IF rowCount = 0 THEN
  	    Insert Into tbl_Client(Client_Id, Meeting_Id, Seeker_Id, Client_Iden, Name, Ph, DOB, Gender, Member_Id, Is_Cres_Client) Select IF(COUNT(Client_Id)= 0, clientId, MAX(Client_Id)) , meetingId, seekerId, seekerIden, seekerName, seekerPh, seekerDOB, seekerGender, memberId, isCresClientFlag From tbl_Client Where Client_Iden = seekerIden And Is_Active = 'Y';
    END IF;
            
END &&
DELIMITER ;