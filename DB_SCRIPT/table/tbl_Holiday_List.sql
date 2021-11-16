CREATE TABLE tbl_Holiday_List
(
    Id                  INT             NOT NULL AUTO_INCREMENT UNIQUE,
    Meeting_Id          VARCHAR(40)     NOT NULL,
    Event_Id            TEXT            NOT NULL,
    Start_TS            DATETIME        NOT NULL,
    End_TS              DATETIME        NOT NULL,
    Description         VARCHAR(500)    NULL,
    Summary             VARCHAR(500)    NULL,
    Status              VARCHAR(50)     NULL,
    Created_On          DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP
)