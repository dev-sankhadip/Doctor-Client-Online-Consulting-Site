CREATE TABLE tbl_File
(
	File_Id         VARCHAR(40)     NOT NULL PRIMARY KEY,
    Client_Id       VARCHAR(40)     NOT NULL,
    Member_Id       VARCHAR(40)     NOT NULL,
    Meeting_Id      VARCHAR(40)     NULL,
    File_Path       VARCHAR(500)    NOT NULL,
    Created_On      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Updated_On      DATETIME        NULL DEFAULT NULL,
    Is_Active       VARCHAR(1)      NOT NULL DEFAULT 'Y'
)