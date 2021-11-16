CREATE TABLE tbl_Seeker
(
    Seeker_Id       VARCHAR(40)     NOT NULL PRIMARY KEY,
    Org_Id          VARCHAR(50)     NULL DEFAULT NULL,
    DOB             DATETIME        NULL DEFAULT NULL,
    Gender          VARCHAR(1)      NULL DEFAULT NULL,
    Created_On      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Updated_ON      DATETIME        NULL DEFAULT NULL 
);