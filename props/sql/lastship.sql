SELECT 
	LS_MASTER.ID,
	UATB_SC_CUST_NAME,
	UATB_SC_BRANCH,
	BOOKING_DATE,
	UATB_SC_ACTIV_DATE,
	CONTRACT_TERM,
	TERM_DATE,
	CMU_USER_DATE3,
	UATB_SC_TODAY,
	CMU_USER_DATE3 + 90 AS COLUMN0005,
	CMU_USER_DATE3 + 120 AS COLUMN0001 
FROM 
	LS_MASTER_RPTS_NF LS_MASTER,  
	LS_USER2_NF LS_USER2 
WHERE 
	LS_MASTER.ID = LS_USER2.ID
	AND LS_MASTER.UATB_SC_TODAY <= LS_USER2.CMU_USER_DATE3 + 120 