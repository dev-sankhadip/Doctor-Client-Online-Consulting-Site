CREATE TABLE tbl_Api_Log
(
    Id                  Int             NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Process_Name        VARCHAR(50)     NOT NULL,
    Process_Type_Id     VARCHAR(50)     NOT NULL,
    Process_Type_Value  VARCHAR(100)    NULL,
    Response            TEXT            NULL,
    Created_On          DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Updated_On          DATETIME        NULL DEFAULT NULL
)