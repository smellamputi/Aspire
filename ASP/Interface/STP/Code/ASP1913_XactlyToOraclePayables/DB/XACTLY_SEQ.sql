/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       XACTLY_SEQ TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: XACTLY_SEQ

   REM
   REM DESC...: Execution Sequence for ASP-1913 Xactly To Oracle Payables
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Divyanshu Anand     	Execution Sequence                                     09/20/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP SEQUENCE "FUSIONINTEGRATION"."XACTLY_SEQ";

CREATE SEQUENCE "FUSIONINTEGRATION"."XACTLY_SEQ"
    INCREMENT BY 1
    START WITH 1
    MINVALUE 1
    MAXVALUE 1000000
    CYCLE
    CACHE 2;
/
SHOW ERRORS
/