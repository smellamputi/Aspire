/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       CreditM_SRC TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: CreditM_SRC

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
   REM Satarupa Chakraborty     Stage Table to store Credit Memo Information       09/07/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE FUSIONINTEGRATION.CREATE_CREDITMEMO_SRC_TBL;
/
   
CREATE TABLE CREATE_CREDITMEMO_SRC_TBL(
CODE_IDENTIFIER                       VARCHAR2(5000), 
SEQ                                   VARCHAR2(5000), 
BATCH_ID                              VARCHAR2(5000), 
AMOUNT                                VARCHAR2(5000), 
APPLIED_AMOUNT                        VARCHAR2(5000), 
APPY_INVOICE_LIST_AMOUNT              VARCHAR2(5000), 
APPLY_ENTITY_INTERNAL_ID              VARCHAR2(5000), 
APPLY_INVOICE_LIST_PAYMENT_DATE       VARCHAR2(5000), 
CURRENCY                              VARCHAR2(5000), 
CUSTOMER_INTERNAL_ID                  VARCHAR2(5000), 
EXCHANGE_RATE                         VARCHAR2(5000), 
PAYMENT_DATE                          VARCHAR2(5000), 
REFERENCE_NUMBER                      VARCHAR2(5000), 
INTEGRATION_INTERNAL_ID               VARCHAR2(5000), 
CUSTOMER_ACCOUNT_NUMBER               VARCHAR2(5000), 
CUSTOMER_NAME                         VARCHAR2(5000), 
RUN_DATE                              DATE      
);