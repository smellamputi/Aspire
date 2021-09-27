/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       AP_XACTLY_SRC_TYPE TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: AP_XACTLY_SRC_TYPE

   REM
   REM DESC...: Source Type Table for ASP-1913 Xactly To Oracle Payables
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Divyanshu Anand     	Insertion Source Type Object                         09/20/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
   
DROP TYPE AP_XACTLY_SRC_REC_TYPE;

DROP TYPE AP_XACTLY_SRC_TYPE;

CREATE OR REPLACE TYPE AP_XACTLY_SRC_TYPE AS OBJECT (
    CODE_IDENTIFIER  VARCHAR2(300),
    INVOICE_ID       VARCHAR2(300),
    BUSINESS_UNIT    VARCHAR2(300),
    INVOICE_NUMBER   VARCHAR2(300),
    INVOICE_AMOUNT   VARCHAR2(300),
    INVOICE_DATE     VARCHAR2(300),
    DESCRIPTION      VARCHAR2(300),
    LEGAL_ENTITY     VARCHAR2(300),
    ACCOUNTING_DATE  VARCHAR2(300),
    SEQ              NUMBER
);
/
SHOW ERRORS
/