/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       XACTLY_PKG_EXEC_STATUS TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: XACTLY_PKG_EXEC_STATUS

   REM
   REM DESC...: Execution Status Table for ASP-1913 Xactly To Oracle Payables
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Divyanshu Anand     	Execution Status Table                               09/20/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE XACTLY_PKG_EXEC_STATUS;

CREATE TABLE XACTLY_PKG_EXEC_STATUS(
IDENTIFIER VARCHAR2(100),
EXEC_STATUS VARCHAR2(1)
);
/
SHOW ERRORS
/