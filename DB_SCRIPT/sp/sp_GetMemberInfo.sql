DROP PROCEDURE IF EXISTS sp_GetMemberInfo;
DELIMITER &&  
CREATE PROCEDURE sp_GetMemberInfo(userId Varchar(40))
BEGIN
    Select tbl_User.Frst_Name, 
    tbl_User.Last_Name, 
    tbl_User.Email, 
    tbl_User.Identification,
    tbl_Member.Major, 
    tbl_Member.Specification, 
    tbl_Member.Experience, 
    tbl_Member.Photo_URL, 
    tbl_Member.Addr, 
    tbl_Member.Resume_URL, 
    tbl_Member.Reminder_Time,
    tbl_User.Created_On,
    (SELECT Lookup_Desc FROM tbl_Lookup WHERE Lookup_Cat = 'Prac_Major' AND Lookup_val = tbl_Member.Major AND tbl_Lookup.Is_Active = 'Y') as Major_Desc,
    (SELECT Lookup_Desc FROM tbl_Lookup WHERE Lookup_Cat = 'Prac_Spec' AND Lookup_val = tbl_Member.Specification AND tbl_Lookup.Is_Active = 'Y') as Spec_Desc
    From tbl_User Inner Join tbl_Member
    On tbl_User.User_Id = tbl_Member.Member_Id
    And tbl_User.Is_Active = 'Y'
    And tbl_User.User_Id = userId;

    Select Count(DISTINCT Client_Id) As Total_Patient From tbl_Client
    Where Member_Id = userId
    And Is_Active = 'Y';
END &&
DELIMITER ;