/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       Customer_SRC TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: Customer_SRC

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
   REM Satarupa Chakraborty     Stage Table to store Customer Information       09/07/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE FUSIONINTEGRATION.CREATE_CUSTOMER_SRC_TBL;
/

CREATE TABLE CREATE_CUSTOMER_SRC_TBL(
CODE_IDENTIFIER                       VARCHAR2(5000), 
SEQ                                   VARCHAR2(5000), 
BATCH_ID                              VARCHAR2(5000), 
BALANCE                               VARCHAR2(5000), 
CREDIT_LIMIT                          VARCHAR2(5000), 
CURRENCY                              VARCHAR2(5000), 
TERMS                                 VARCHAR2(5000), 
SF_ID                                 VARCHAR2(5000), 
DUNS_NUMBER                           VARCHAR2(5000), 
INVOICE_DELIVERY_METHOD               VARCHAR2(5000), 
PARENT_ID                             VARCHAR2(5000), 
ACCOUNT_NUMBER                        VARCHAR2(5000), 
COMPANY_NAME                          VARCHAR2(5000), 
CITY                                  VARCHAR2(5000), 
COUNTRY                               VARCHAR2(5000), 
EMAIL                                 VARCHAR2(5000), 
LINE1                                 VARCHAR2(5000), 
LINE2                                 VARCHAR2(5000), 
MOBILE                                VARCHAR2(5000), 
PHONE                                 VARCHAR2(5000), 
STATE                                 VARCHAR2(5000), 
WWW                                   VARCHAR2(5000), 
ZIP                                   VARCHAR2(5000), 
PARTY_ID                              VARCHAR2(5000), 
CUSTOM_ACCOUNT_NAME                   VARCHAR2(5000), 
CUSTOM_ACCOUNT_NOTE                   VARCHAR2(5000), 
CUSTOM_PARTY_NUMBER                   VARCHAR2(5000), 
ACCOUNT_OWNER_NAME                    VARCHAR2(5000), 
ACCOUNT_OWNER_EMAIL                   VARCHAR2(5000), 
RENEWAL_MANAGER_NAME                  VARCHAR2(5000), 
RENEWAL_MANAGER_EMAIL                 VARCHAR2(5000), 
CUSTOMER_SUCCCESS_MANAGER_NAME        VARCHAR2(5000), 
CUSTOMER_SUCCCESS_MANAGER_EMAIL       VARCHAR2(5000), 
BILL_TO_COUNTRY                       VARCHAR2(5000), 
PARTNER_ACCOUNT                       VARCHAR2(5000), 
SALES_CHANNEL                         VARCHAR2(5000), 
ACCOUNT_STATUS                        VARCHAR2(5000), 
ACCOUNT_SUSPENSION_STATUS             VARCHAR2(5000), 
ACCOUNT_SUSPENSION_DATE               VARCHAR2(5000), 
OWNER_SEGMENT                         VARCHAR2(5000), 
COLLECTION_STATUS                     VARCHAR2(5000), 
GEOGRAPHIC_AREA                       VARCHAR2(5000), 
PAYMENT_METHOD                        VARCHAR2(5000), 
SEGMENT                               VARCHAR2(5000), 
SITE_ID                               VARCHAR2(5000), 
CUSTOM_PARTY_TYPE                     VARCHAR2(5000), 
PAYMENT_TERMS                         VARCHAR2(5000), 
TAX_ID                                VARCHAR2(5000), 
INTEGRATION_INTERNAL_ID               VARCHAR2(5000), 
RUN_DATE                              DATE         
);
/

ALTER TABLE create_customer_src_tbl ADD country_code VARCHAR2(5000);
/