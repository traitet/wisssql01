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
CREATE PROCEDURE [dbo].[eps_pr_productionid_error_report]
@start_date AS VARCHAR(8),
@end_date AS VARCHAR(8),
@doc_num AS VARCHAR(30),
@record_count AS INT
AS

select PRNUM, ITEMNO, MATDESC, BUDGETTYPE, EXPENSEID, INVESTMENTID, PRODUCTID, PRODUCTLINEID, PRODUCTLINEDESC, MACHINEID, 
MACHINEDESC, REQUIREDDATE, SHIPTO, QTY, PRICE, UNIT, PONUM, STATUS, ENABLED, TEXT1, TEXT2 
from TT_PRITEM_LINE where PONUM = @doc_num and REQUIREDDATE >= @start_date and REQUIREDDATE <= @end_date order by PRNUM