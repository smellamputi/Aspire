/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       OSS_STITCH_PAYLOAD_STG TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: OSS_STITCH_PAYLOAD_STG

   REM
   REM DESC...: Stage Table for ASP-1877 Account Billing Usage Sync
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Rohit Srivastava     Stage Table to store S3 payload information         03/05/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE "FUSIONINTEGRATION"."OSS_STITCH_PAYLOAD_STG";
/ 

CREATE TABLE "FUSIONINTEGRATION"."OSS_STITCH_PAYLOAD_STG" 
   (            
   record_id        NUMBER,
    run_date_time    TIMESTAMP,
    interface_id     VARCHAR2(10),
    interface_name   VARCHAR2(120),
    instance_id      VARCHAR2(20),
    trackingid       VARCHAR2(240),
    s3downloadlink   VARCHAR2(4000),
    status 	     VARCHAR2(4),
    message 	     VARCHAR2(20000)
   );
/
SHOW ERRORS
/