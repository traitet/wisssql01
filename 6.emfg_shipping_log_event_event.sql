USE [SIAM_SHIPPINGDB];
GO
/****** Object:  StoredProcedure [dbo].[interface_sap_inv]    Script Date: 23/02/2022 3:39:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =========================================================
-- [emfg_shipping_log_event]
-- Created by : Nuttawut
-- Created date : 23-02-2022
-- Updated date : 23-02-2022
-- =========================================================
CREATE PROCEDURE [dbo].[emfg_shipping_log_event]
@start_date AS VARCHAR(8),
@end_date AS VARCHAR(8),
@doc_num AS VARCHAR(8),
@record_count AS INT
AS

SELECT TOP (@record_count )
ROWID, FUNCTION_NAME, [DESCRIPTION], PDSNUM, CUSTPARTNUM, CREATEBY, CREATEDATE, CREATETIME 
from TT_EVENT_LOG 
where PDSNUM = @doc_num AND
CREATEDATE > = @start_date AND
CREATEDATE <= @end_date


-- EXEC emfg_shipping_log_event '20190101', '20220101','',100