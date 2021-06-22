/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       GL_ADP_SRC_REC_TYPE TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: GL_ADP_SRC_REC_TYPE

   REM
   REM DESC...: Insertion Rec Type for ASP-1909 ADP To Oracel GL
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Divyanshu Anand     	Insertion Rec Type                                  06/05/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
CREATE OR REPLACE TYPE GL_ADP_SRC_REC_TYPE AS
    TABLE OF GL_ADP_SRC_TYPE;
/
SHOW ERRORS
/