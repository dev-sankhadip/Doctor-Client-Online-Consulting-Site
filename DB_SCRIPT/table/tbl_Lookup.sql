CREATE TABLE tbl_Lookup
(
	Lookup_Cat  VARCHAR(10) NOT NULL,
    Lookup_Val  VARCHAR(10) NOT NULL,
    Lookup_Desc VARCHAR(50) NOT NULL,
    Is_Active   VARCHAR(1) DEFAULT 'Y' NOT NULL,
    PRIMARY KEY(Lookup_Cat, Lookup_Val)
)