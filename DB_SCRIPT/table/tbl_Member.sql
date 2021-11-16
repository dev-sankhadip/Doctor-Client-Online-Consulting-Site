CREATE TABLE tbl_Member
(
    Member_Id       VARCHAR(40)     NOT NULL PRIMARY KEY,
    Pay_Cat         VARCHAR(50)     NULL DEFAULT NULL,
    Reg_Num         VARCHAR(50)     NULL DEFAULT NULL,
    Backgrnd_Ver    VARCHAR(1)      NULL DEFAULT NULL,
    Doc_Flag        VARCHAR(1)      NULL DEFAULT NULL,
    Major           VARCHAR(5)      NULL DEFAULT NULL,
    Specification   VARCHAR(5)      NULL DEFAULT NULL,
    Experience      VARCHAR(100)    NULL DEFAULT NULL,
    Description     VARCHAR(100)    NULL DEFAULT NULL,
    Photo_URL       VARCHAR(500)    NULL DEFAULT NULL,
    Resume_URL      VARCHAR(500)    NULL DEFAULT NULL,
    Pricing         VARCHAR(10)     NULL DEFAULT NULL,
    SlotId          VARCHAR(10)     NULL DEFAULT NULL,
    Addr            VARCHAR(50)     NULL DEFAULT NULL,
    Reminder_Time   Int             NOT NULL DEFAULT 1 CHECK   (Reminder_Time>=1),
    Is_Cres_Member  VARCHAR(1)      NOT NULL DEFAULT 'Y',
    Created_On      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Updated_ON      DATETIME        NULL DEFAULT NULL
);