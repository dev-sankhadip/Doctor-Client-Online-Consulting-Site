CREATE TABLE tbl_Job
(
    Job_Name	    VARCHAR(50)     NOT NULL,
    Job_Id          VARCHAR(40)     NOT NULL,
    Start_TS		DATETIME	    NOT NULL,
    End_TS			DATETIME	    NULL DEFAULT NULL,
    Run_Status		VARCHAR(1)	    NOT NULL,
    Scheduled_TS	DATETIME	    NULL,
    Created_On      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Updated_On      DATETIME        NULL DEFAULT NULL,
    PRIMARY KEY(Job_Name, Start_TS)
)