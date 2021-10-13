/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       OSS_ACCOUNTUSAGE_CORE_ERROR TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: OSS_ACCOUNTUSAGE_CORE_ERROR

   REM
   REM DESC...: Error Table for ASP-1877 Account Billing Usage Sync
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Rohit Srivastava     Error Table                                          03/05/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE "FUSIONINTEGRATION"."OSS_ACCOUNTUSAGE_CORE_ERROR";
/ 

CREATE TABLE "FUSIONINTEGRATION"."OSS_ACCOUNTUSAGE_CORE_ERROR" 
   (            
		RECORD_ID   NUMBER,      
		RUN_DATE_TIME   TIMESTAMP,
		INTERFACE_ID     VARCHAR2(10), 
		INTERFACE_NAME   VARCHAR2(120),
		INSTANCE_ID     VARCHAR2(20),
		S3TRACKINGID    VARCHAR2(240),
		S3USAGEID       VARCHAR2(240),
		STATUS         VARCHAR2(20) ,
		ERROR_CODE VARCHAR2(100),
		ERROR_MESSAGE VARCHAR2(20000),         
		ERROR_DETAILS VARCHAR2(20000)		
   );
/
SHOW ERRORS
/