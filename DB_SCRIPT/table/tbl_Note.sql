CREATE TABLE tbl_Note
(
	Note_Id         VARCHAR(40)     NOT NULL UNIQUE,
    Member_Id       VARCHAR(40)     NULL,
    Client_Id       VARCHAR(40)     NULL,
    Meeting_Id      VARCHAR(40)     NULL,
    Resource_Type   VARCHAR(3)      NOT NULL,
    Resource        TEXT            NOT NULL,
    Created_On      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Updated_On      DATETIME        NULL DEFAULT NULL
)