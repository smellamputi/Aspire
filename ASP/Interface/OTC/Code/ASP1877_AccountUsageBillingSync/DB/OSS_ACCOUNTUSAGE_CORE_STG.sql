/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       OSS_ACCOUNTUSAGE_CORE_STG TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: OSS_ACCOUNTUSAGE_CORE_STG

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
   REM Rohit Srivastava     Stage Table to store Usage Information               03/05/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE "FUSIONINTEGRATION"."OSS_ACCOUNTUSAGE_CORE_STG";
/ 

CREATE TABLE "FUSIONINTEGRATION"."OSS_ACCOUNTUSAGE_CORE_STG" 
   (            
	record_id              NUMBER,
    dsaccountid            VARCHAR2(240),
    uom                    VARCHAR2(50),
	uom_source             VARCHAR2(50),
    quantity               NUMBER,
    usagedate              VARCHAR2(16),
    usageid                VARCHAR2(240),
    run_date_time          VARCHAR2(100),
    interface_id           VARCHAR2(10),
    interface_name         VARCHAR2(120),
    instance_id            VARCHAR2(20),
    schedule_instance_id   VARCHAR2(20),
    process_flag           VARCHAR2(2),
    message                VARCHAR2(4000),
    PRIMARY KEY ( record_id,instance_id )
   );
/
SHOW ERRORS;
/