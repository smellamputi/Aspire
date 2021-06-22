/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       ADP_PKG_EXEC_STATUS TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: ADP_PKG_EXEC_STATUS

   REM
   REM DESC...: Execution Status Table for ASP-1909 ADP To Oracel GL
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Divyanshu Anand     	Execution Status Table                               06/05/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE ADP_PKG_EXEC_STATUS;
/
CREATE TABLE ADP_PKG_EXEC_STATUS(
IDENTIFIER VARCHAR2(100),
EXEC_STATUS VARCHAR2(1)
);
/
SHOW ERRORS
/