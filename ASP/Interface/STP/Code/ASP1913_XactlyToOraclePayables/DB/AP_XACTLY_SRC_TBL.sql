/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       AP_XACTLY_SRC_TBL TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: AP_XACTLY_SRC_TBL

   REM
   REM DESC...: Source Table for ASP-1913 Xactly To Oracle Payables
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Divyanshu Anand     	Source Table                                     	 09/20/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE AP_XACTLY_SRC_TBL;

CREATE TABLE AP_XACTLY_SRC_TBL(
CODE_IDENTIFIER           VARCHAR2(300), 
INVOICE_ID                VARCHAR2(300), 
BUSINESS_UNIT		      VARCHAR2(300),
INVOICE_NUMBER            VARCHAR2(300), 
INVOICE_AMOUNT            VARCHAR2(300), 
INVOICE_DATE              VARCHAR2(300), 
DESCRIPTION			      VARCHAR2(300),	
LEGAL_ENTITY		      VARCHAR2(300),
ACCOUNTING_DATE			  VARCHAR2(300),
SEQ                       NUMBER       , 
CREATED_BY                NUMBER       , 
CREATION_DATE             DATE         , 
LAST_UPDATED_BY           NUMBER       , 
LAST_UPDATED_DATE         DATE         , 
LAST_UPDATED_LOGIN        NUMBER       
);
/
SHOW ERRORS
/
