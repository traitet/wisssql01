USE SIAM_EPSDB
GO
/****** Object:  StoredProcedure [dbo].[edrawing_check_password]    Script Date: 02/03/2022 2:27:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =========================================================
-- [eps_interface_sap_pr_outstanding]
-- Created by : Nuttawut
-- Created date : 23-02-2022
-- Updated date : 23-02-2022
-- =========================================================
CREATE PROCEDURE [dbo].[eps_pr_issue_error_report]
@start_date AS VARCHAR(8),
@end_date AS VARCHAR(8),
@doc_num AS VARCHAR(30),
@record_count AS INT
AS

select TOP(@record_count) PRNUM, PRKEYNO, ISSUEDDATE, ISSUEDTIME, APPROVEDDATE, APPROVEDTIME, CURRENTUSER, NEXTUSER, VENDORID, VENDORNAME, SECTIONID, 
BUDGETTYPE, AMOUNT, TAXAMOUNT, TOTALAMOUNT, RELSTATEGY, DESCRIPTION, REMARK, STATUS, CREATEDBY, CREATEDDATE,	
CREATEDTIME, EDITEDBY, EDITEDDATE, EDITEDTIME, ENABLED 
from TT_PRFORM 
where status = '' and CREATEDDATE> @start_date and CREATEDDATE< @end_date
order by CREATEDDATE desc


