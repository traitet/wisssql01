USE [AGS_J614_614]
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
ALTER PROCEDURE [dbo].[edrawing_check_password]
@start_date AS VARCHAR(8),
@end_date AS VARCHAR(8),
@doc_num AS VARCHAR(30),
@record_count AS INT
AS

 SELECT TOP (@record_count)
 CHR_COD_UserID
 , CHR_COD_Password
 , CHR_NGP_LastLoginDate 
 FROM dbo.TM_AGS_DRAWING_CTL_USER 
 WHERE CHR_COD_UserID like @doc_num + '%'


