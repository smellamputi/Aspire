/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       CIF_LOG_MESSAGES_TBL TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: CIF_LOG_MESSAGES_TBL

   REM
   REM DESC...: Custom Table for CIF Deployment
   REM
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
DROP TABLE "FUSIONINTEGRATION"."CIF_LOG_MESSAGES_TBL";
/

CREATE TABLE "FUSIONINTEGRATION"."CIF_LOG_MESSAGES_TBL" (
    "INSTANCE_ID"         NUMBER NOT NULL,
    "INTERFACE_NAME"      VARCHAR2(60),
    "INTERFACE_ID"        VARCHAR2(10),
    "SEQUENCE_NUMBER"     NUMBER NOT NULL,
    "RUN_DATE"            DATE,
	"MESSAGE_SEVERITY"    VARCHAR2(50),
    "SCOPE_NAME"          VARCHAR2(60),
    "STATUS"              VARCHAR2(15),
    "ERROR_CODE"          VARCHAR2(60),
    "ERROR_MESSAGE"       VARCHAR2(4000),
    "ERROR_DETAILS"       VARCHAR2(4000),
    "ATTRIBUTE1"          VARCHAR2(500),
    "ATTRIBUTE2"          VARCHAR2(500),
    "ATTRIBUTE3"          VARCHAR2(500),
    "ATTRIBUTE4"          VARCHAR2(500),
    "ATTRIBUTE5"          VARCHAR2(500),
    "ATTRIBUTE6"          VARCHAR2(500),
    "ATTRIBUTE7"          VARCHAR2(500),
    "ATTRIBUTE8"          VARCHAR2(500),
    "ATTRIBUTE9"          VARCHAR2(500),
    "ATTRIBUTE10"         VARCHAR2(500),
    "ATTRIBUTE11"         VARCHAR2(500),
    "ATTRIBUTE12"         VARCHAR2(500),
    "ATTRIBUTE13"         VARCHAR2(500),
    "ATTRIBUTE14"         VARCHAR2(500),
    "ATTRIBUTE15"         VARCHAR2(500),
    "ATTRIBUTE16"         VARCHAR2(500),
    "ATTRIBUTE17"         VARCHAR2(500),
    "ATTRIBUTE18"         VARCHAR2(500),
    "ATTRIBUTE19"         VARCHAR2(500),
    "ATTRIBUTE20"         VARCHAR2(500),
    "ATTRIBUTE21"         VARCHAR2(500),
    "ATTRIBUTE22"         VARCHAR2(500),
    "ATTRIBUTE23"         VARCHAR2(500),
    "ATTRIBUTE24"         VARCHAR2(500),
    "ATTRIBUTE25"         VARCHAR2(500),
    "ATTRIBUTE26"         VARCHAR2(500),
    "ATTRIBUTE27"         VARCHAR2(500),
    "ATTRIBUTE28"         VARCHAR2(500),
    "ATTRIBUTE29"         VARCHAR2(500),
    "ATTRIBUTE30"         VARCHAR2(500),
    "LAST_UPDATED_DATE"   DATE,
    "LAST_UPDATE_BY"      NUMBER,
    "LAST_LOGIN_BY"       NUMBER,
    "CREATED_BY"          NUMBER,
    "CREATED_DATE"        DATE
);
/

show errors;

/