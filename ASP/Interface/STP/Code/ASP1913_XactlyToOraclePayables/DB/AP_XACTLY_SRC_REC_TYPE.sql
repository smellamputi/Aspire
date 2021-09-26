/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       AP_XACTLY_SRC_REC_TYPE TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: AP_XACTLY_SRC_REC_TYPE

   REM
   REM DESC...: Insertion Rec Type for ASP-1913 Xactly To Oracle Payables
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Divyanshu Anand     	Insertion Rec Type                                  09/20/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
CREATE OR REPLACE TYPE AP_XACTLY_SRC_REC_TYPE AS
    TABLE OF AP_XACTLY_SRC_TYPE;
/
SHOW ERRORS
/