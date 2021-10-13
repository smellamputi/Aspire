/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       TABLE TYPE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: TABLE TYPE

   REM
   REM DESC...: Table type for ASP-1877 Account Billing Usage Sync
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Rohit Srivastava     Table Type for Usage Data                           03/05/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TYPE "fusionintegration"."usagedata_rec_type" ;
/
CREATE OR REPLACE TYPE "fusionintegration"."usagedata_rec_type" AS OBJECT (
    record_id    NUMBER,
    dsaccountid  VARCHAR2(240),
    uom          VARCHAR2(50),
    uom_source   VARCHAR2(120),
    quantity     NUMBER,
    usagedate    VARCHAR2(16),
    usageid      VARCHAR2(240)
);
/
DROP TYPE "fusionintegration"."usagedata_tbl_type";
/ 
CREATE OR REPLACE TYPE usagedata_tbl_type AS TABLE OF usagedata_rec_type;
/
SHOW ERRORS
/