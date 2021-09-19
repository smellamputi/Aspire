/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       AR_SFDC_ACCOUNTCONTACT_TBL TABLE SCRIPT
       $VERSION 1.0
   REM ============================================================================
   REM
   REM NAME...: AR_SFDC_ACCOUNTCONTACT_TBL

   REM
   REM DESC...: SOURCE DATA TABLE FOR ASP-1855 AR_SFDC_ACCOUNTCONTACT_TBL
   REM
   REM
   REM FILES..: NONE
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM	                    SOURCE DATA TABLE                                   07/06/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE FUSIONINTEGRATION.AR_SFDC_ACCOUNTCONTACT_TBL;
/ 

CREATE TABLE AR_SFDC_ACCOUNTCONTACT_TBL
   (            
		ACCOUNT_ID VARCHAR2(240),
		CUST_ACCOUNT_ID VARCHAR2(240),
		OWNER_SEGMENT VARCHAR2(240),
		CSE_FIRSTNAME  VARCHAR2(240),
		CSE_LASTNAME VARCHAR2(240),
		CSE_EMAIL VARCHAR2(240),
		OWNER_FIRSTNAME VARCHAR2(240),
		OWNER_LASTNAME  VARCHAR2(240),
		OWNER_EMAIL VARCHAR2(240),
		CSM_FIRSTNAME VARCHAR2(240),
		CSM_LASTNAME VARCHAR2(240),
		CSM_EMAIL  VARCHAR2(240),
		DS_ACCOUNT_TYPE VARCHAR2(240),
		SITE_ID VARCHAR2(240),
		DS_ENVACCOUNT_SUFFIX VARCHAR2(240),
		DS_ACCOUNTID  VARCHAR2(240),
		PARTNER_ACCOUNT_NAME VARCHAR2(240),
		SALES_CHANNEL VARCHAR2(240),
		DS_STATUS VARCHAR2(240),
		ACCOUNT_SUSPENSION_DATE  VARCHAR2(240),
		DS_SUSPENSION_CODE VARCHAR2(240)

   );
/
SHOW ERRORS
/