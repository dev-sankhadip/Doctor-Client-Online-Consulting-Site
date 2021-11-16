CREATE TABLE tbl_Refer
(
	Refer_Id    VARCHAR(40)     NOT NULL UNIQUE,
    Code        VARCHAR(40)     NOT NULL PRIMARY KEY,
    Refered_By  VARCHAR(40)     NULL,
    Role        VARCHAR(2)      NOT NULL,
    Created_On  DATETIME        DEFAULT CURRENT_TIMESTAMP,
    Is_Active   VARCHAR(1)      DEFAULT 'Y' NOT NULL
)