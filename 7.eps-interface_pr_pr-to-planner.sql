USE [SIAM_EPSDB];
GO
/****** Object:  StoredProcedure [dbo].[interface_sap_inv]    Script Date: 23/02/2022 3:39:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =========================================================
-- [eps_interface_pr_po_to_planner]
-- Created by : Nuttawut
-- Created date : 23-02-2022
-- Updated date : 23-02-2022
-- =========================================================
CREATE PROCEDURE [dbo].[eps_interface_pr_po_to_planner]
@start_date AS VARCHAR(8),
@end_date AS VARCHAR(8),
@doc_num AS VARCHAR(8),
@record_count AS INT
AS
    SELECT top (@record_count )
        PRF.PRNUM, PRFL.ITEMNO, PRFL.MATID AS PRFMATID, PRFL.MATDESC AS PRFMATDESC,POFL.MACHINEID,POFL.PRODUCTLINEID AS LINE_NO,PRFL.DESCRIPTION AS [BRAND] , PRF.BUDGETTYPE, 
        CASE PRF.BUDGETTYPE  WHEN 'EXPENSE'    THEN  CASE WHEN 
        LEN(PRFL.EXPENSEID) > 10 THEN  SUBSTRING (PRFL.EXPENSEID, 
        8, LEN (PRFL.EXPENSEID) - 7) ELSE PRFL.EXPENSEID END  WHEN 'INVESTMENT' THEN PRFL.INVESTMENTID 
        END AS PRFACCOUNTID,PRFL.GOODSTYPE, PRF.SECTIONID, 
        dbo.fn_set_date_txt(PRFL.REQUIREDDATE),dbo.fn_set_date_txt(PRFL.CREATEDDATE),dbo.fn_set_date_txt(POF.PODATE), PRFL.QTY AS PRFQTY, PRFL.PRICE AS PRFPRICE, PRFL.AMOUNT AS PRFAMOUNT,  
        PRFL.STATUS AS PRFSTATUS, PRFL.CREATEDBY AS PRCREATED, PRIL.VENDORNAME,  
        PRIL.BUYER, PRIL.MATID AS PRIMATID, 
        CASE PRIL.BUDGETTYPE WHEN 'EXPENSE'  THEN  CASE WHEN LEN(PRIL.EXPENSEID) > 10 
        THEN  SUBSTRING (PRIL.EXPENSEID, 8, LEN (PRIL.EXPENSEID) - 7) 
        ELSE PRIL.EXPENSEID  END  WHEN 'INVESTMENT' THEN PRIL.INVESTMENTID 
        END AS PRIACCOUNTID,NULLIF(CAST(PRFL.SERVICEDURATION AS INT),0) AS DURATIONTIME,dbo.fn_set_date_txt(PRFL.SERVICESTARTDATE) AS STARTSERVICE,dbo.fn_set_date_txt(PRIL.REQUIREDDATE), PRIL.QTY AS PRIQTY, PRIL.PRICE AS PRIPRICE, 
        PRIL.AMOUNT AS PRIAMOUNT, PRIL.VAT, (PRIL.AMOUNT + PRIL.VAT) AS PRILINEAMOUNT, 
        PRIL.STATUS AS PRISTATUS, PRIL.BUYERCOMMENT, PRIL.SENIORBUYERCOMMENT, 
        CASE PRIL.BUDGETTYPE 
        WHEN 'EXPENSE' THEN PRIL.CPACCCOMMENT 
        WHEN 'INVESTMENT' THEN PRIL.CPINVCOMMENT 
        END AS CPCOMMENT, PRIL.COSTCOMMENT, PRIL.PONUM, PRIL.PURCHASETYPE, 
        POF.STATUS AS POFSTATUS, POF.CURRENTUSER, POF.CURRENTROLE,POFL.POLINE_ROWID,  PRIL.PRITEM_LINE_ROWID
        FROM 
        TT_PRFORM PRF INNER JOIN TT_PRFORM_LINE PRFL 
        ON PRF.PRNUM = PRFL.PRNUM 
        LEFT JOIN TT_PRITEM_LINE PRIL 
        ON PRIL.PRFORM_LINE_ROWID = PRFL.PRFORM_LINE_ROWID 
        LEFT JOIN TT_POFORM_LINE POFL 
        ON POFL.PRITEMLINE_ROWID = PRIL.PRITEM_LINE_ROWID 
        LEFT JOIN TT_POFORM POF 
        ON POFL.PONUM = POF.PONUM 
        INNER JOIN TM_SECTION SEC 
        ON PRF.SECTIONID = SEC.SECTIONID 
            WHERE (POFL.STATUS <> 'CANCEL' OR POFL.STATUS IS NULL) 
    AND PRFL.EXPENSEID = '55400-H100' 
    --AND PRFL.INVESTMENTID = ''
    AND CAST(PRF.CREATEDDATE As Int) >= @start_date
    AND CAST(PRF.CREATEDDATE As Int) <= @end_date
    ORDER BY PRF.PRNUM ASC, PRFL.ITEMNO ASC 

-- EXEC eps_interface_pr_po_to_planner '20190101', '20220101','',100