/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       OSS_REPORT_RESPONSE_STG TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: OSS_REPORT_RESPONSE_STG

   REM
   REM DESC...: Report Response Table for ASP-1877 Account Billing Usage Sync
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Rohit Srivastava     Report Response Table                               03/05/2021
   REM Rohit Srivastava     Increase datatype length-UAT Defect#ASP8871         11/11/2021				
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE "FUSIONINTEGRATION"."OSS_REPORT_RESPONSE_STG";
/

CREATE TABLE "FUSIONINTEGRATION"."OSS_REPORT_RESPONSE_STG" (
    dsaccount                  VARCHAR2(100),
    uom                        VARCHAR2(50),
    quantity                   NUMBER,
    usagedate                  VARCHAR2(16),
    subscription_number        VARCHAR2(120),
    party_name                 VARCHAR2(360),
    account_number             VARCHAR2(30),
    product_name               VARCHAR2(300),
    subscription_product_puid  VARCHAR2(120),
    bill_line_puid             VARCHAR2(120),
    usage_start_date           VARCHAR2(10),
    usage_end_date             VARCHAR2(10),
    usage_quantity             NUMBER,
    run_date_time              TIMESTAMP,
    interface_id               VARCHAR2(10),
    interface_name             VARCHAR2(120),
    instance_id                VARCHAR2(20),
    record_id                  NUMBER,
    status                     VARCHAR2(10)
);
/
SHOW ERRORS
/