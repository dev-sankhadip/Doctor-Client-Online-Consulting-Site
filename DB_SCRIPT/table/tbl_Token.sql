CREATE TABLE tbl_Token
(
    Member_Id       VARCHAR(40)     NOT NULL,
    Email           VARCHAR(100)    NOT NULL,
    Access_Token    VARCHAR(300)    NOT NULL,
    Refresh_Token   VARCHAR(300)    NOT NULL,
    Created_On      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Updated_On      DATETIME        NULL DEFAULT NULL,
    Is_Active     VARCHAR(1)      NOT NULL DEFAULT 'Y',
    PRIMARY KEY(Member_Id, Is_Active)
)