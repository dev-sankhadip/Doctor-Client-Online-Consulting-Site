Alter Table tbl_Token Drop Primary Key, Add Primary Key(Member_Id, Access_Token, Is_Active);

Alter Table tbl_Token Modify Access_Token Varchar(500);
Alter Table tbl_Token Modify Refresh_Token Varchar(500);