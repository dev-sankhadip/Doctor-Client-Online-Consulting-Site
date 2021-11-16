-- Merged with SP -> sp_GetPatientList.sql

DROP VIEW IF EXISTS vw_Patient_MinInfo;
CREATE  VIEW vw_Patient_MinInfo  AS  
select tbl_Client.Client_Id AS Client_Id,
(select tbl_Meeting.Start_TS from tbl_Meeting where tbl_Meeting.Meeting_Id = tbl_Client.Meeting_Id and tbl_Meeting.Start_TS >= now() order by tbl_Meeting.Start_TS limit 1) AS Next_Appoiment,
(select tbl_Meeting.Start_TS from tbl_Meeting where tbl_Meeting.Meeting_Id = tbl_Client.Meeting_Id and tbl_Meeting.Start_TS <= now() order by tbl_Meeting.Start_TS desc limit 1) AS Last_Appoiment 
from tbl_Client 
where tbl_Client.Is_Active = 'Y'