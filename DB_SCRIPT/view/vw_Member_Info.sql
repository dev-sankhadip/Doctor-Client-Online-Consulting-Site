-- Converted to SP -> sp_GetMemberInfo.sql

DROP VIEW IF EXISTS vw_Member_Info;
CREATE VIEW vw_Member_Info AS
SELECT tbl_User.Identification,
tbl_Member.Member_Id,
tbl_User.Frst_Name, 
tbl_User.Last_Name, 
tbl_User.Email, 
tbl_User.Firebase_Id,
tbl_User.User_Id,
(SELECT Lookup_Desc FROM tbl_Lookup WHERE Lookup_Cat = 'Prac_Major' AND Lookup_val = tbl_Member.Major AND tbl_Lookup.Is_Active = 'Y') as Major_Desc,
(SELECT Lookup_Desc FROM tbl_Lookup WHERE Lookup_Cat = 'Prac_Spec' AND Lookup_val = tbl_Member.Specification AND tbl_Lookup.Is_Active = 'Y') as Spec_Desc,
tbl_Member.Major, 
tbl_Member.Specification 
FROM tbl_User INNER JOIN tbl_Member
ON tbl_User.User_Id = tbl_Member.Member_Id
AND tbl_User.Is_Active = 'Y'
AND tbl_User.User_Type = 'P'