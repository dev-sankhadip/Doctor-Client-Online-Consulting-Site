DROP PROCEDURE IF EXISTS sp_GetPatientList;
DELIMITER &&
CREATE PROCEDURE sp_GetPatientList(memberId varchar(40))
BEGIN
	SELECT DISTINCT tbl_Client.Client_Id,
    MAX(tbl_Client.Client_Iden) AS Email,
    MAX(tbl_Client.Ph) AS Ph,
    MAX(tbl_Client.Member_Id) AS Member_Id,
    MAX(tbl_Client.Name) AS Name,
    -- (SELECT Last_Appoiment FROM vw_Patient_MinInfo WHERE Client_Id = tbl_Client.Client_Id AND Last_Appoiment IS NOT NULL ORDER BY Last_Appoiment DESC LIMIT 1) as Last_Appoiment,
    -- (SELECT Next_Appoiment FROM vw_Patient_MinInfo WHERE Client_Id = tbl_Client.Client_Id AND Next_Appoiment IS NOT NULL ORDER BY Next_Appoiment ASC LIMIT 1) as Next_Appoiment,
    (
        SELECT (SELECT tbl_Meeting.Start_TS FROM tbl_Meeting WHERE tbl_Meeting.Meeting_Id = Client.Meeting_Id AND tbl_Meeting.Start_TS <= now() ORDER BY tbl_Meeting.Start_TS DESC LIMIT 1)
        AS Last_Appoinment
        FROM tbl_Client AS Client
        WHERE 
        Client.Is_Active = 'Y'
        AND Client.Client_Id = tbl_Client.Client_Id
        ORDER BY Last_Appoinment DESC
        LIMIT 1
    )  AS Last_Appoinment,
    (
        SELECT 
        (
            SELECT tbl_Meeting.Start_TS FROM tbl_Meeting 
            WHERE tbl_Meeting.Meeting_Id = Client.Meeting_Id 
            AND tbl_Meeting.Start_TS >= now()
        )
        AS Next_Appoinment
        FROM tbl_Client AS Client
        WHERE 
        Client.Is_Active = 'Y'
        AND Client.Client_Id = tbl_Client.Client_Id
        HAVING Next_Appoinment IS NOT NULL
        ORDER BY Next_Appoinment ASC
        LIMIT 1
    )  AS Next_Appoinment ,
    MIN(Created_On) As Created_On
    FROM tbl_Client 
    WHERE tbl_Client.Member_Id = memberId
    GROUP BY Client_Id;
END &&
DELIMITER ;