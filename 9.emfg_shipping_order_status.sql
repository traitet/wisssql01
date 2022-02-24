USE [SIAM_SHIPPINGDB];
GO
/****** Object:  StoredProcedure [dbo].[interface_sap_inv]    Script Date: 23/02/2022 3:39:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =========================================================
-- [emfg_shipping_order_status]
-- Created by : Nuttawut
-- Created date : 23-02-2022
-- Updated date : 23-02-2022
-- =========================================================
CREATE PROCEDURE [dbo].[emfg_shipping_order_status]
@start_date AS VARCHAR(8),
@end_date AS VARCHAR(8),
@doc_num AS VARCHAR(8),
@record_count AS INT
AS
    SELECT top (@record_count )
        [PLANT], ROWID, PKLNUM, PKLROWID, CUSTID, RECSTORE, SHIPOPER, DELIDATE, SHIPDATE, SHIPTIME, 
        CUSTNAME, SUPNAME, SAPARTNUM, CUSTPARTNUM, QPACK, QUANTITY, 
        BOXQTY, PDSNUM, PARTNAME, ISSUEDATE, ISSUETIME, PACKED,
    CASE
        WHEN STATUS = 'OK' THEN 'ALREADY SHOPPING'
        WHEN STATUS = 'PENDING' THEN 'NO SHOPPING'
        ELSE 'N/A'
    END AS STATUS
    FROM 
    (
    SELECT 
        'TMT' as [PLANT], ROWID, PKLNUM, PKLROWID, CUSTID, RECSTORE, SHIPOPER, DELIDATE, SHIPDATE, SHIPTIME, CUSTNAME, SUPNAME, SAPARTNUM, CUSTPARTNUM, QPACK, QUANTITY, BOXQTY, PDSNUM, PARTNAME, ISSUEDATE, ISSUETIME, PACKED, STATUS  from TM_PLAN_TMT
    UNION ALL
    SELECT 'NON TMT' as [PLANT], ROWID, PKLNUM, PKLROWID, CUSTID, RECSTORE, SHIPOPER, DELIDATE, SHIPDATE, SHIPTIME, CUSTNAME, SUPNAME, SAPARTNUM, CUSTPARTNUM, QPACK, QUANTITY, BOXQTY, PDSNUM, PARTNAME, ISSUEDATE, ISSUETIME, PACKED, STATUS from TM_PLAN_OTHER
    ) x
    WHERE x.PDSNUM LIKE '%' + @doc_num +'%' and 
    ISSUEDATE >= @start_date AND
    ISSUEDATE <= @start_date

-- EXEC emfg_shipping_order_status '20170914', '20220101','',100 (MAYBE REPORT INCORRECT. NO DATA)