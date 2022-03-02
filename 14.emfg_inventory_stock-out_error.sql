USE [SIAM_ARISA_P01]
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
CREATE PROCEDURE [dbo].[emfg_inventory_stock-out_error]
@start_date AS VARCHAR(8),
@end_date AS VARCHAR(8),
@doc_num AS VARCHAR(30),
@record_count AS INT
AS

select  ICTTINVTPXMRID, PARTCODE, PARTNUM, FROMKBSERIAL, FROMKBTYPECODE, QTYPACK, QTY, UNIT, COMPCODE, PLANTCODE, STATUS, ENABLE, 
CREATEBY, CREATEDATE, CREATETIME, EDITBY, EDITDATE, EDITTIME, COMMENT5, TEXT1
  from ICTTINVTPXM 
  where STATUS = 'PARK' AND COMMENT5 = '' AND CREATEDATE >= @start_date and CREATEDATE <= @end_date  order by ICTTINVTPXMRID