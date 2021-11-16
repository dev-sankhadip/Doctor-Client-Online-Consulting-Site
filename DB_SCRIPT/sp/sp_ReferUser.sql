DROP PROCEDURE IF EXISTS sp_ReferUser;
DELIMITER &&  
CREATE PROCEDURE sp_ReferUser(IN iden varchar(100), IN code varchar(40))
BEGIN
	DECLARE rowCount    INT DEFAULT 0;
    DECLARE referId     VARCHAR(40) DEFAULT '';
    DECLARE referedBy   VARCHAR(40) DEFAULT NULL;
    DECLARE codeRole       VARCHAR(40) DEFAULT NULL;
    DECLARE userId      VARCHAR(40) DEFAULT '';
    
    SELECT U.User_Id INTO userId FROM tbl_User U WHERE Identification = iden AND U.Is_Active = 'NR';
    
    IF userId <> '' THEN

		Select R.Refer_Id, R.Refered_By, R.Role INTO referId, referedBy, codeRole From tbl_Refer R Where R.Code = code And R.Is_Active = 'Y';
        
        IF referId <> '' AND codeRole = 'AU' THEN

            SELECT COUNT(*) INTO rowCount FROM tbl_Refer_Det WHERE Refer_Id = referId AND Refered_To = iden;
            IF rowCount = 0 THEN
                SELECT 'You are not refered' as msg;
            ELSE
            	UPDATE tbl_User SET Is_Active = 'Y' WHERE User_Id = userId AND Is_Active = 'NR';
                UPDATE tbl_Refer_Det SET User_Id = userId WHERE Refer_Id = referId AND Refered_To = iden;
            END IF;
         	SELECT 1 as msg;

		ELSEIF referId <> '' AND codeRole = 'SU' THEN

            SELECT COUNT(*) INTO rowCount FROM tbl_Refer_Det WHERE Refer_Id = referId AND Refered_To = iden;
            IF rowCount = 0 THEN
				INSERT INTO tbl_Refer_Det(Refer_Id, Refered_To, User_Id, Refered_On, Requested_By) VALUES(referId, iden, userId, CURRENT_TIMESTAMP, 'UI');
            ELSE
                UPDATE tbl_Refer_Det SET User_Id = userId WHERE Refer_Id = referId AND Refered_To = iden;
            END IF;
            UPDATE tbl_User SET Is_Active = 'Y' WHERE User_Id = userId AND Is_Active = 'NR';
           	SELECT 1 as msg;
        ELSE
        	SELECT 'Invalid Referal Code' as msg;
        END IF;
    ELSE
    	SELECT 'Already Registered' as msg;
    END IF;
END &&
DELIMITER ;