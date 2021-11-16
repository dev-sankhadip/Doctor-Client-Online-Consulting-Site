CREATE TABLE tbl_Client
(
    Client_Id       VARCHAR(40)     NOT NULL,
    Meeting_Id      VARCHAR(100)    NOT NULL,
    Member_Id       VARCHAR(40)     NOT NULL,   -- Insert Practitioner ID
    Seeker_Id       VARCHAR(40)     NULL,       -- Insert NULL if Seeker is not of Creslin or Fetch User_Id from tbl_User using Client_Iden
    Client_Iden     VARCHAR(100)    NOT NULL,   -- Insert Identification like Email or Phone Number
    Name            VARCHAR(50)     NULL,
    Ph              VARCHAR(12)     NULL,
    DOB             DATE            NULL,
    Gender          VARCHAR(1)      NULL,
    Is_Cres_Client  VARCHAR(1)      NOT NULL DEFAULT 'N',   -- Insert 'Y' if Seeker is of Cresline else 'N'
    Created_On      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Updated_On      DATETIME        NULL DEFAULT NULL,
    Is_Active       VARCHAR(1)      NOT NULL DEFAULT 'Y'
)