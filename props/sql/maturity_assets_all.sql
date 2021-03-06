SELECT DISTINCT  
	UATB_MRKTNG_REP4,
	UATB_MRKTNG_REP4_DESC,
	UATB_SC_MRKTNG_REP3,
	UATB_SC_MRKTNG_REP3_DESC,
	UATB_SC_MRKTNG_REP2,
	UATB_SC_MRKTNG_REP2_DESC,
	CONTRACT_NO,
	UATB_JS_IN_EVERGREEN,
	CUST_ID,
	UATB_SC_CUST_NAME,
	LS_MASTER.UATB_SC_ACTIV_DATE,
	UATB_JS_ADJ_TERM,
	UATB_JS_EOT_LTR_TERM_DATE,
	CONTRACT_TERM,
	TERM_DATE,
	UATB_SC_BRANCH,
	UATB_SC_MRKTNG_REP1_DESC,
	UATB_JS_CONTRACT_PUR_OP_DESC,
	UATB_JS_SERVICE_ON_LEASE,
	UATB_SC_PRODUCT_LINE_DESC,
	UATB_SC_PROGRAM_TYPE_DESC,
	AS_MASTER.ID,
	EQUIP_DESC,
	MODEL,
	QUANTITY,
	SERIAL_NUMBER,
	A_ORIG_COST,
	UATB_JS_RESIDUAL_ON_ASSET,
	EQUIP_ADDR1,
	EQUIP_ADDR2,
	EQUIP_CITY,
	EQUIP_STATE,
	EQUIP_ZIP,
	UATB_JS_NONREPORT_PYMT_AMT,
	UATB_JS_TOTAL_EQUIP_PYMT_RATE 
FROM 
	LS_MASTER_RPTS_NF LS_MASTER,  
	LS_BILLING_NF LS_MASTER_1,  
	AS_MASTER_RPTS_NF AS_MASTER,  
	AS_MASTER_RPTS_A_LOCATIONS AS_MASTER_1,  
	AS_LOCATION_NF AS_MASTER_2 
WHERE 
	LS_MASTER.ID = LS_MASTER_1.ID
	AND LS_MASTER.ID = AS_MASTER.CONTRACT_NO
	AND AS_MASTER.ID = AS_MASTER_1.ID
	AND AS_MASTER_1.A_LOCATIONS = AS_MASTER_2.ID
	AND AS_MASTER_2.ID = AS_MASTER.UATB_JS_CURRENT_ASSET_LOCATION
	AND ( ( UATB_SC_NUM_OF_ASSETS > 0
	AND UATB_SC_INVOICE_CODE <> 'N'
	AND CONTRACT_STATUS NOT IN( '03', '04', '08' )
	AND PRODUCT_LINE IN( '0045', '0046', '0065', '0066', '0067', '0070' )
	AND PROGRAM_TYPE <> '0042')
	AND A_DISP_DATE IS NULL
	AND A_INVENT_DATE IS NULL) 
ORDER BY 
	15
