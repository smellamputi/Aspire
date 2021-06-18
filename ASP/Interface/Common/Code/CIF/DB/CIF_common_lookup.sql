/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       CIF_COMMON_LOOKUP TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: CIF_COMMON_LOOKUP

   REM
   REM DESC...: Custom Table for Common Lookup
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------       ----------
   REM KPMG Tech Team      CIF, Initial Development                           10/17/2019
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE "FUSIONINTEGRATION"."CIF_COMMON_LOOKUP";
/ 
 CREATE TABLE "FUSIONINTEGRATION"."CIF_COMMON_LOOKUP" 
   (	"SOURCE" VARCHAR2(100 BYTE), 
	"LOOKUP_TYPE" VARCHAR2(100 BYTE), 
	"LEGACY_VALUE" VARCHAR2(100 BYTE), 
	"FUSION_VALUE" VARCHAR2(100 BYTE), 
	"ATTRIBUTE1" VARCHAR2(100 BYTE), 
	"ATTRIBUTE2" VARCHAR2(100 BYTE), 
	"ATTRIBUTE3" VARCHAR2(100 BYTE), 
	"ATTRIBUTE4" VARCHAR2(100 BYTE), 
	"ATTRIBUTE5" VARCHAR2(100 BYTE), 
	"ATTRIBUTE6" VARCHAR2(100 BYTE), 
	"ATTRIBUTE7" VARCHAR2(100 BYTE), 
	"ATTRIBUTE8" VARCHAR2(100 BYTE), 
	"ATTRIBUTE9" VARCHAR2(100 BYTE), 
	"ATTRIBUTE10" VARCHAR2(100 BYTE)
   );
/
CREATE INDEX "FUSIONINTEGRATION"."CIF_COMMON_LOOKUP_N1" ON "FUSIONINTEGRATION"."CIF_COMMON_LOOKUP" ("LOOKUP_TYPE", "LEGACY_VALUE");
/
SHOW ERRORS;
/