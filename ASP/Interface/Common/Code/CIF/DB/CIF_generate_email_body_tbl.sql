/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       CIF_GENERATE_EMAIL_BODY_TBL TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: CIF_GENERATE_EMAIL_BODY_TBL

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
DROP TABLE "FUSIONINTEGRATION"."CIF_GENERATE_EMAIL_BODY_TBL";
/ 
 CREATE TABLE "FUSIONINTEGRATION"."CIF_GENERATE_EMAIL_BODY_TBL" 
   (	"SEQ" NUMBER(30,0), 
	"MSG_TYPE" VARCHAR2(30 BYTE), 
	"STAGE" VARCHAR2(30 BYTE), 
	"EMAIL_SUBJ" VARCHAR2(200 BYTE), 
	"EMAIL_BODY" VARCHAR2(500 BYTE), 
	"ENVIRONMENT" VARCHAR2(30 BYTE), 
	"CREATION_DATE" DATE, 
	 PRIMARY KEY ("SEQ")
   );
/
SHOW ERRORS;
/