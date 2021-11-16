CREATE TABLE tbl_Log
(
    Id              Int             NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Process_Name    VARCHAR(50)     NOT NULL,
    Process_Type    VARCHAR(50)     NOT NULL,
    User_Id         VARCHAR(40)     NULL,
    Job_Id          VARCHAR(40)     NULL,
    Event_Id        VARCHAR(40)     NULL,
    Meeting_Id      VARCHAR(40)     NULL,
    Error_Message   TEXT            NULL,
    Created_On      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Updated_On      DATETIME        NULL DEFAULT NULL
)