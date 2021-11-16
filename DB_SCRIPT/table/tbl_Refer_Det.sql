CREATE TABLE tbl_Refer_Det
(
	Refer_Id        VARCHAR(40)     NOT NULL,
    Refered_To      VARCHAR(50)     NOT NULL,
    User_Id         VARCHAR(40)     NULL,
    Refered_On      DATETIME        DEFAULT CURRENT_TIMESTAMP,
    Requested_By    VARCHAR(3)      NOT NULL,
    PRIMARY KEY(Refer_Id, Refered_To)
)