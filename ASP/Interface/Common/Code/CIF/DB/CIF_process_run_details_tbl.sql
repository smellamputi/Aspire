/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       CIF_PROCESS_RUN_DETAILS_TBL TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: CIF_PROCESS_RUN_DETAILS_TBL

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
   REM KPMG Tech Team        CIF                                               10/17/2019
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE "FUSIONINTEGRATION"."CIF_PROCESS_RUN_DETAILS_TBL";
/ 
 CREATE TABLE "FUSIONINTEGRATION"."CIF_PROCESS_RUN_DETAILS_TBL" 
   (	"INSTANCE_ID" NUMBER NOT NULL ENABLE, 
	"INTEGRATION_NAME" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"LAST_RUN_DATE" DATE NOT NULL ENABLE, 
	"STATUS" VARCHAR2(100 BYTE)
   );
/
CREATE UNIQUE INDEX "FUSIONINTEGRATION"."CIF_PROCESS_RUN_DETAILS_TBL_N1" ON "FUSIONINTEGRATION"."CIF_PROCESS_RUN_DETAILS_TBL" ("INSTANCE_ID");
/
SHOW ERRORS;
/