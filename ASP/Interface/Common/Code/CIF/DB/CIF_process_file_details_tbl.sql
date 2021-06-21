/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       CIF_PROCESS_FILE_DETAILS_TBL TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: CIF_PROCESS_FILE_DETAILS_TBL

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
   REM KPMG Tech Team        CIF                                              10/17/2019
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE "FUSIONINTEGRATION"."CIF_PROCESS_FILE_DETAILS_TBL";
/ 

CREATE TABLE "FUSIONINTEGRATION"."CIF_PROCESS_FILE_DETAILS_TBL" 
   (	"INSTANCE_ID" NUMBER NOT NULL ENABLE, 
	"FILE_NAME" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"FILE_SIZE" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"FILE_ROW_COUNT" NUMBER, 
	"LOAD_ROW_COUNT" NUMBER, 
	"LOAD_DATE_TIME" DATE, 
	"LOAD_STATUS" VARCHAR2(100 BYTE), 
	"VALIDATION_FAILURE_ROW_COUNT" NUMBER, 
	"VALIDATION_STATUS" VARCHAR2(100 BYTE), 
	"VALIDATION_DATE_TIME" DATE, 
	"ATTRIBUTE1" VARCHAR2(500 BYTE), 
	"ATTRIBUTE2" VARCHAR2(500 BYTE), 
	"ATTRIBUTE3" VARCHAR2(500 BYTE), 
	"ATTRIBUTE4" VARCHAR2(500 BYTE), 
	"ATTRIBUTE5" VARCHAR2(500 BYTE), 
	"ATTRIBUTE6" VARCHAR2(500 BYTE), 
	"ATTRIBUTE7" VARCHAR2(500 BYTE), 
	"ATTRIBUTE8" VARCHAR2(500 BYTE), 
	"ATTRIBUTE9" VARCHAR2(500 BYTE), 
	"ATTRIBUTE10" VARCHAR2(500 BYTE), 
	"ATTRIBUTE11" VARCHAR2(500 BYTE), 
	"ATTRIBUTE12" VARCHAR2(500 BYTE), 
	"ATTRIBUTE13" VARCHAR2(500 BYTE), 
	"ATTRIBUTE14" VARCHAR2(500 BYTE), 
	"ATTRIBUTE15" VARCHAR2(500 BYTE)
   );
/
CREATE INDEX "FUSIONINTEGRATION"."CIF_PROCESS_FILE_DET_TBL_N1" ON "FUSIONINTEGRATION"."CIF_PROCESS_FILE_DETAILS_TBL" ("FILE_NAME");
/
SHOW ERRORS;
/
