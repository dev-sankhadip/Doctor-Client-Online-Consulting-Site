CREATE TABLE tbl_User
(
    Firebase_Id         VARCHAR(50)     NOT NULL UNIQUE,
    Identification      VARCHAR(100)    NOT NULL UNIQUE,
    User_Id             VARCHAR(40)     NOT NULL PRIMARY KEY,
    User_Type           VARCHAR(1)      NOT NULL,
    Frst_Name           VARCHAR(30)     NOT NULL,
    Last_Name           VARCHAR(30)     NOT NULL,
    Email               VARCHAR(100)    NOT NULL UNIQUE,
    Refresh_Token       VARCHAR(300)    NULL,
    Created_On          DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Updated_ON          DATETIME        NULL DEFAULT NULL ,
    Is_Active           VARCHAR(1)      NOT NULL DEFAULT 'Y'
);