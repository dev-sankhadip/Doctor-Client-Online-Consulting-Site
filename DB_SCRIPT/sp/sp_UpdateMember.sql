DROP PROCEDURE IF EXISTS sp_UpdateMember;
DELIMITER &&  
CREATE PROCEDURE sp_UpdateMember(Frst_Name Varchar(30), Last_Name Varchar(30), Email Varchar(100), Major Varchar(5), Specification Varchar(2), 
Experience Varchar(100), Photo_URL Varchar(500), Resume_URL Varchar(500), Addr Varchar(50), Reminder_Time Int, IsOauth Varchar(1), userId Varchar(40))
BEGIN
    Update tbl_Member Inner Join tbl_User
    On tbl_Member.Member_Id = tbl_User.User_Id
    And tbl_User.User_Id = userId
    And tbl_User.Is_Active = 'Y'
    SET Frst_Name = Frst_Name,
    Last_Name = Last_Name,
    Email = IF(IsOauth = 'Y', tbl_User.Email, Email),
    Major = Major,
    Specification = Specification,
    Experience = Experience,
    Photo_URL = Photo_URL,
    Addr = Addr,
    Resume_URL = Resume_URL,
    Reminder_Time = Reminder_Time,
    tbl_Member.Updated_ON = CURRENT_TIMESTAMP,
    tbl_User.Updated_ON = CURRENT_TIMESTAMP;

    Select tbl_User.Frst_Name, 
    tbl_User.Last_Name, 
    tbl_User.Email, 
    tbl_Member.Major, 
    tbl_Member.Specification, 
    tbl_Member.Experience, 
    tbl_Member.Photo_URL, 
    tbl_Member.Addr, 
    tbl_Member.Resume_URL, 
    tbl_Member.Reminder_Time 
    From tbl_User Inner Join tbl_Member
    On tbl_User.User_Id = tbl_Member.Member_Id
    And tbl_User.Is_Active = 'Y'
    And tbl_User.User_Id = userId;

END &&
DELIMITER ;