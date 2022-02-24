USE [SIAM_SHIPPINGDB];
GO
/****** Object:  StoredProcedure [dbo].[interface_sap_inv]    Script Date: 23/02/2022 3:39:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =========================================================
-- [emfg_shipping_log_ng]
-- Created by : Nuttawut
-- Created date : 23-02-2022
-- Updated date : 23-02-2022
-- =========================================================
CREATE PROCEDURE [dbo].[emfg_shipping_log_ng]
@start_date AS VARCHAR(8),
@end_date AS VARCHAR(8),
@doc_num AS VARCHAR(8),
@record_count AS INT
AS

SELECT TOP (@record_count )
	[DATE], [TIME], USER_NG, NG_DESCRIPTION, PDS_NUM, NG_ID, UNLOCK_NG 
FROM 
	TM_LOG_OK 
WHERE 
	PDS_NUM = @doc_num AND 
	[DATE] >= @start_date AND 
	[DATE] <= @end_date

-- EXEC emfg_shipping_log_ng '20190101', '20220101','',100