/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       CIF_JOB_HISTORY_TBL TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: CIF_JOB_HISTORY_TBL

   REM
   REM DESC...: Custom Table for CIF Deployment
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------       ----------
   REM KPMG Tech Team       CIF                                                10/17/2019
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE "FUSIONINTEGRATION"."CIF_JOB_HISTORY_TBL";
/ 

CREATE TABLE "FUSIONINTEGRATION"."CIF_JOB_HISTORY_TBL" 
   ("INSTANCE_ID" NUMBER(30,0), 
	"CALLBACK_ID" NUMBER(30,0), 
	"JOB_ID" NUMBER(30,0), 
	"JOB_NAME" VARCHAR2(400 BYTE), 
	"JOB_STATUS" VARCHAR2(100 BYTE)
   );
/
SHOW ERRORS;
/