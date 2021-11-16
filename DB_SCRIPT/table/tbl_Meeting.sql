CREATE TABLE tbl_Meeting
(
    Meeting_Id          VARCHAR(100)    NOT NULL PRIMARY KEY,
    Event_Id            TEXT            NOT NULL,
    Start_TS            DATETIME        NOT NULL,
    End_TS              DATETIME        NOT NULL,
    Member_Id           VARCHAR(40)     NOT NULL,
    Description         VARCHAR(500)    NULL,
    Summary             VARCHAR(500)    NULL,
    Status              VARCHAR(50)     NULL,
    Platform            VARCHAR(20)     NULL,
    Platform_Meeting_Id VARCHAR(50)     NULL,
    Reminder_Count      INT             NOT NULL DEFAULT 0,
    Created_On          DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Updated_On          DATETIME        NULL DEFAULT NULL,
    Is_Active           VARCHAR(1)      NOT NULL DEFAULT 'Y'
)