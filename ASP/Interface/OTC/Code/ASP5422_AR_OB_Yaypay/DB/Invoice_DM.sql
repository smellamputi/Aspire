/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       Invoice_DM TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: Invoice_DM

   REM
   REM DESC...: Stage Table for ASP-5422 AR OB YAYPAY
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                     WHAT                                                          WHEN
   REM --------------         ----------------------------------------------                 ----------
   REM Satarupa Chakraborty     Stage Table to store Invoice and Debit Memo Information      09/07/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
CREATE TABLE CREATE_INVOICE_DM_SRC_TBL(
CODE_IDENTIFIER               VARCHAR2(5000),  
SEQ                           VARCHAR2(5000),  
BATCH_ID                      VARCHAR2(5000),  
CLOSE_DATE                    VARCHAR2(5000),  
CONTACT_INTERNAL_ID           VARCHAR2(5000),  
CONTACT_EMAIL                 VARCHAR2(5000),  
CURRENCY                      VARCHAR2(5000),  
PO_NUMBER                     VARCHAR2(5000),  
OPP_ID                        VARCHAR2(5000),  
PAYMENT_METHOD                VARCHAR2(5000),  
CUSTOMER_INTERNAL_ID          VARCHAR2(5000),  
DISTRIBUTION_CHANNEL          VARCHAR2(5000),  
DUE_DATE                      VARCHAR2(5000),  
EXCHANGE_RATE                 VARCHAR2(5000),  
INVOICE_DATE                  VARCHAR2(5000),  
INVOICE_NUMBER                VARCHAR2(5000),  
AMOUNT                        VARCHAR2(32000), 
COLOR                         VARCHAR2(32000), 
DESCRIPTION                   VARCHAR2(32000), 
ITEM_INTERNAL_ID              VARCHAR2(32000), 
NAME                          VARCHAR2(32000), 
QUANTITY                      VARCHAR2(32000), 
RATE                          VARCHAR2(32000), 
NOTES                         VARCHAR2(5000),  
PAID                          VARCHAR2(5000),  
STATUS                        VARCHAR2(5000),  
SUB_TOTAL                     VARCHAR2(5000),  
TAX_AMOUNT                    VARCHAR2(5000),  
TERMS                         VARCHAR2(5000),  
TOTAL                         VARCHAR2(5000),  
INTEGRATION_INTERNAL_ID       VARCHAR2(5000),  
TXN_LINE_NUMBER               VARCHAR2(32000),
CUSTOMER_ACCOUNT_NUMBER       VARCHAR2(5000),  
CUSTOMER_NAME                 VARCHAR2(5000),  
RUN_DATE                      DATE          
);