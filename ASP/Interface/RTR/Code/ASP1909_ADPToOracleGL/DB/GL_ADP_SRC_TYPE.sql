/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       GL_ADP_SRC_TYPE TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: GL_ADP_SRC_TYPE

   REM
   REM DESC...: Source Type Table for ASP-1909 ADP To Oracel GL
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Divyanshu Anand     	Insertion Source Type Object                         06/05/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TYPE GL_ADP_SRC_REC_TYPE;
/
DROP TYPE GL_ADP_SRC_TYPE;
/
CREATE OR REPLACE TYPE GL_ADP_SRC_TYPE AS OBJECT (
CODE_IDENTIFIER           VARCHAR2(300), 
STATUS_CODE               VARCHAR2(300), 
LEDGER_ID                 VARCHAR2(300), 
JOURNAL_SOURCE            VARCHAR2(300), 
JOURNAL_CATEGORY          VARCHAR2(300), 
ACCOUNTING_DATE			  VARCHAR2(300),
CURRENCY_CODE		      VARCHAR2(300),
DATE_CREATED 			  VARCHAR2(300),
SEGMENT1				  VARCHAR2(300),
SEGMENT2 				  VARCHAR2(300),
SEGMENT3 				  VARCHAR2(300),
ENTERED_DR 				  VARCHAR2(300),
ENTERED_CR 				  VARCHAR2(300),
REFERENCE4				  VARCHAR2(300),
REFERENCE5				  VARCHAR2(300),
REFERENCE10				  VARCHAR2(300),
SEQ                       NUMBER       , 
ORA_SEGMENT2              VARCHAR2(150)
);
/
SHOW ERRORS
/