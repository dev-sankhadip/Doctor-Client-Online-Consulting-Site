DROP PROCEDURE IF EXISTS sp_GetPatientInfo;
DELIMITER &&  
CREATE PROCEDURE sp_GetPatientInfo(clientId varchar(40), memberId varchar(40))
BEGIN
    -- SELECT distinct Client_Iden, Name, Ph, DOB, Gender, Is_Cres_Client 
    -- FROM tbl_Client 
    -- WHERE Client_Id = clientId 
    -- AND Is_Active = 'Y'
    -- ORDER BY Name DESC;

    SELECT MAX(Client_Iden) As Client_Iden, 
    MAX(Name) As Name, 
    MAX(Ph) As Ph, 
    MAX(DOB) As DOB, 
    MAX(Gender) As Gender, 
    MAX(Is_Cres_Client) As Is_Cres_Client, 
    MIN(Created_On) As Created_On
    FROM tbl_Client 
    WHERE Client_Id = clientId
    AND Is_Active = 'Y'
    GROUP BY Client_Id;
    
    SELECT 
    tbl_Meeting.Meeting_Id, 
    tbl_Meeting.Start_TS, 
    tbl_Meeting.End_TS,
    tbl_Meeting.Platform_Meeting_Id,
    tbl_Meeting.Member_Id,
    -- tbl_Note.Note_Id,
    (Select Note_Id From tbl_Note Where Meeting_Id = tbl_Meeting.Meeting_Id And tbl_Client.Client_Id = clientId And Resource_Type = 'PN') As Patient_Note_Id,
    (Select Note_Id From tbl_Note Where Meeting_Id = tbl_Meeting.Meeting_Id And tbl_Client.Client_Id = clientId And Resource_Type = 'DN') As Doctor_Note_Id
    FROM tbl_Client INNER JOIN tbl_Meeting 
    ON tbl_Client.Meeting_Id = tbl_Meeting.Meeting_Id
    AND tbl_Client.Is_Active = 'Y'
    AND tbl_Meeting.Is_Active = 'Y'
    AND tbl_Client.Client_Id = clientId
    AND tbl_Meeting.Start_TS <= CURRENT_TIMESTAMP
    AND tbl_Meeting.Member_Id = memberId;
    -- LEFT JOIN tbl_Note
    -- ON tbl_Meeting.Meeting_Id = tbl_Note.Meeting_Id
    -- AND tbl_Note.Client_Id = clientId
    -- AND tbl_Note.Resource_Type = 'PN';
    
    
	SELECT 
    tbl_Meeting.Meeting_Id, 
    tbl_Meeting.Start_TS, 
    tbl_Meeting.End_TS,
    tbl_Meeting.Platform_Meeting_Id,
    tbl_Meeting.Member_Id,
    -- tbl_Note.Note_Id
    (Select Note_Id From tbl_Note Where Meeting_Id = tbl_Meeting.Meeting_Id And tbl_Client.Client_Id = clientId And Resource_Type = 'PN') As Patient_Note_Id,
    (Select Note_Id From tbl_Note Where Meeting_Id = tbl_Meeting.Meeting_Id And tbl_Client.Client_Id = clientId And Resource_Type = 'DN') As Doctor_Note_Id
    FROM tbl_Client INNER JOIN tbl_Meeting 
    ON tbl_Client.Meeting_Id = tbl_Meeting.Meeting_Id
    AND tbl_Client.Is_Active = 'Y'
    AND tbl_Meeting.Is_Active = 'Y'
    AND tbl_Client.Client_Id = clientId
    AND tbl_Meeting.Start_TS >= CURRENT_TIMESTAMP
    AND tbl_Meeting.Member_Id = memberId;
    -- LEFT JOIN tbl_Note
    -- ON tbl_Meeting.Meeting_Id = tbl_Note.Meeting_Id
    -- AND tbl_Note.Client_Id = clientId
    -- AND tbl_Note.Resource_Type = 'PN';
    
    
END &&
DELIMITER ;