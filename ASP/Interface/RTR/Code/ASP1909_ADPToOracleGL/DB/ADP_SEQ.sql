/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       ADP_SEQ TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: ADP_SEQ

   REM
   REM DESC...: Execution Sequence for ASP-1909 ADP To Oracel GL
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Divyanshu Anand     	Execution Sequence                                     06/05/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP SEQUENCE "FUSIONINTEGRATION"."ADP_SEQ";
/
CREATE SEQUENCE "FUSIONINTEGRATION"."ADP_SEQ"
    INCREMENT BY 1
    START WITH 1
    MINVALUE 1
    MAXVALUE 1000000
    CYCLE
    CACHE 2;
/
SHOW ERRORS
/