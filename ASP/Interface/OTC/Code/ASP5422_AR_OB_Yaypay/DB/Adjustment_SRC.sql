/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       Adjustment_SRC TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: Adjustment_SRC

   REM
   REM DESC...: Stage Table for ASP-5422 AR OB YAYPAY
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Satarupa Chakraborty     Stage Table to store Adjustment Information       09/07/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE FUSIONINTEGRATION.CREATE_ADJUSTMENT_SRC_TBL;
/

CREATE TABLE CREATE_ADJUSTMENT_SRC_TBL(
CODE_IDENTIFIER                    VARCHAR2(5000), 
SEQ                                VARCHAR2(5000), 
BATCH_ID                           VARCHAR2(5000), 
ADJUSTMENT_DATE                    VARCHAR2(5000), 
ADJUSTMENT_INVOICE_ITEM_DATE       VARCHAR2(5000), 
AMOUNT                             VARCHAR2(5000), 
INVOICE_INTERNAL_ID                VARCHAR2(5000), 
ADJUSTMENT_NUMBER                  VARCHAR2(5000), 
ADJUSTMENT_TYPE                    VARCHAR2(5000), 
APPLIED_AMOUNT                     VARCHAR2(5000), 
CURRENCY                           VARCHAR2(5000), 
CUSTOMER_INTERNAL_ID               VARCHAR2(5000), 
EXCHANGE_RATE                      VARCHAR2(5000), 
TOTAL                              VARCHAR2(5000), 
INTEGRATION_INTERNAL_ID            VARCHAR2(5000), 
CUSTOMER_ACCOUNT_NUMBER            VARCHAR2(5000), 
CUSTOMER_NAME                      VARCHAR2(5000), 
RUN_DATE                           DATE           

);