/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       AR_REPORT_RESPONSE_ACCOUNTCONTACT TABLE SCRIPT
       $VERSION 1.0
   REM ============================================================================
   REM
   REM NAME...: AR_REPORT_RESPONSE_ACCOUNTCONTACT

   REM
   REM DESC...: DATA TABLE FOR ASP-1855 AR_REPORT_RESPONSE_ACCOUNTCONTACT
   REM
   REM
   REM FILES..: NONE
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM KEERTHANA M          DATA TABLE                                          07/06/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE FUSIONINTEGRATION.AR_REPORT_RESPONSE_ACCOUNTCONTACT;
/ 

CREATE TABLE FUSIONINTEGRATION.AR_REPORT_RESPONSE_ACCOUNTCONTACT
   (            
		ACCOUNT_ID VARCHAR2(240),
		CUST_ACCOUNT_ID VARCHAR2(240)
   );
/
SHOW ERRORS
/