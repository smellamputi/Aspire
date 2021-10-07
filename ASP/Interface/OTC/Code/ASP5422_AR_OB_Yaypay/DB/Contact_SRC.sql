/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       Contact_SRC TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: Contact_SRC

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
   REM Satarupa Chakraborty     Stage Table to store Contact Information       09/07/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
CREATE TABLE CREATE_CONTACT_SRC_TBL(
CODE_IDENTIFIER               VARCHAR2(5000), 
SEQ                           VARCHAR2(5000), 
BATCH_ID                      VARCHAR2(5000), 
CUSTOMER_INTERNAL_ID          VARCHAR2(5000), 
EMAIL                         VARCHAR2(5000), 
FIRST_NAME                    VARCHAR2(5000), 
LAST_NAME                     VARCHAR2(5000), 
MOBILE_PHONE                  VARCHAR2(5000), 
PHONE                         VARCHAR2(5000), 
PRIMARY                       VARCHAR2(5000), 
TITLE                         VARCHAR2(5000), 
ADDITIONAL_EMAIL              VARCHAR2(5000), 
RESPONSIBILITY_TYPE           VARCHAR2(5000), 
JOB_TITLE_CODE                VARCHAR2(5000), 
INTEGRATION_INTERNAL_ID       VARCHAR2(5000), 
CUSTOMER_ACCOUNT_NUMBER       VARCHAR2(5000), 
CUSTOMER_NAME                 VARCHAR2(5000), 
RUN_DATE                      DATE           
);