SELECT DISTINCT  
                CASE 
                                WHEN ( APP_DECISION_CODE IN ( 0, 1, 4 ) ) THEN 'Not Approved' 
                                ELSE 
                                CASE 
                                                WHEN ( APP_DECISION_CODE = 5 ) THEN 'Cancelled' 
                                                ELSE 
                                                CASE 
                                                                WHEN ( APP_DECISION_CODE = 6 ) THEN 'Rejected' 
                                                                ELSE 'Approved' 
                                                END 
                                END 
                END AS USER_DESC,
                CASE 
                                WHEN APP_CONTRACT_NUMBER IS NULL THEN CO_UD_CO_CONTRACT_ID 
                                ELSE APP_CONTRACT_NUMBER 
                END AS COLUMN0049,
                APP_FKEY AS ACT_KEY,
                CO_custName,
                MAX( CO_accountingOwnerCode ) AS MaxCo_accountingownercode,
                CO_purchaseOption_TBDESC,
                CO_programType_TBDESC,
                CO_UD_CO_ADVANCE_ARREARS,
                CO_branch_TBDESC,
                MAX( REP1 ) AS MaxRep1,
                CO_paymentAmount AS CO_UD_CO_ORIG_PYMT_AMT,
                CO_residualAmount,
                CO_productLine_TBDESC,
                MIN( CO_termDuration ) AS MinCo_termduration,
                CO_equipmentCost,
                SUM( AS_listPrice ) AS SumAs_listprice,
                MAX ( CASE 
                                WHEN ( CO_ROI_NOMPT IS NULL ) THEN AS_PRICING_TARGET_YIELD_AS 
                                ELSE CO_ROI_NOMPT 
                END ) AS CO_PRICING_TARGET_YIELD,
                SCD_CODE AS MaxScd_code,
                LOCAL_SIC_CODE,
                MAX( REP2 ) AS MaxRep2,
                MAX( REP3 ) AS MaxRep3,
                CO_promotion_TBDESC AS COLUMN0051,
                CASE 
                                WHEN APP_NEW_CUST_YN = 1 THEN 'New' 
                                ELSE 'Existing' 
                END AS COLUMN0067,
                CASE 
                                WHEN CO_productLine = 0070 THEN 'Yes' 
                                ELSE 'No' 
                END AS COLUMN0068,
                CO_UD_CO_COMP_CONVERSION_TBDESC AS CO_UD_CO_COMP_CONVERSION_TBDES 
FROM 
                Rapport.dbo.RPT_ASSET RPT_ASSET
                INNER JOIN Rapport.dbo.RPT_CO RPT_CO
                ON 
                                RPT_ASSET.CO_FKEY = RPT_CO.CO_KEY
                INNER JOIN Rapport.dbo.APPLICATION APPLICATIO
                ON 
                                RPT_CO.APP_FKEY = APPLICATIO.APP_KEY
                INNER JOIN Rapport.dbo.Marketing_Reps MARKETING
                ON 
                                RPT_ASSET.CO_FKEY = MARKETING.CO_FKEY
                LEFT OUTER JOIN Rapport.dbo.RPT_CUST_DATA RPT_CUST_D
                ON 
                                APPLICATIO.CUST_FKEY = RPT_CUST_D.ENT_FKEY
                LEFT OUTER JOIN Rapport.dbo.DECISION_CODES DECISION_C
                ON 
                                APPLICATIO.APP_DECISION_CODE = DECISION_C.DECISION_CODE_KEY
                LEFT OUTER JOIN Rapport.dbo.RPT_SIC_CODE RPT_SIC_CO
                ON 
                                RPT_CUST_D.CUST_DATA_KEY = RPT_SIC_CO.CUST_DATA_FKEY
                LEFT OUTER JOIN Rapport.dbo.CONTRACT_SETUP CONTRACT_S
                ON 
                                RPT_CO.APP_FKEY = CONTRACT_S.CTS_APP_FKEY
                
WHERE 
                ( ( APP_DECISION_CODE NOT IN( 0, 1, 4, 5, 6 )
                AND CO_equipmentCost <> 0))
                AND CO_bookingDate BETWEEN ? AND ?
                AND SCD_CODE <> '9999' 

GROUP BY 
                CASE 
                WHEN ( APP_DECISION_CODE IN ( 0, 1, 4 ) ) THEN 'Not Approved' 
                ELSE 
                CASE 
                                WHEN ( APP_DECISION_CODE = 5 ) THEN 'Cancelled' 
                                ELSE 
                                CASE 
                                                WHEN ( APP_DECISION_CODE = 6 ) THEN 'Rejected' 
                                                ELSE 'Approved' 
                                END 
                END 
END,
                CASE 
                WHEN APP_CONTRACT_NUMBER IS NULL THEN CO_UD_CO_CONTRACT_ID 
                ELSE APP_CONTRACT_NUMBER 
END,
                APP_FKEY,
                CO_custName,
                CO_purchaseOption_TBDESC,
                CO_programType_TBDESC,
                CO_UD_CO_ADVANCE_ARREARS,
                CO_branch_TBDESC,
                CO_paymentAmount,
                CO_residualAmount,
                CO_productLine_TBDESC,
                CO_equipmentCost,
                SCD_CODE,
                LOCAL_SIC_CODE,
                CO_promotion_TBDESC,
                CASE 
                WHEN APP_NEW_CUST_YN = 1 THEN 'New' 
                ELSE 'Existing' 
END,
                CASE 
                WHEN CO_productLine = 0070 THEN 'Yes' 
                ELSE 'No' 
END,
                CO_UD_CO_COMP_CONVERSION_TBDESC 
HAVING 
                MAX( REP1 ) <> '' 
ORDER BY 
                3
