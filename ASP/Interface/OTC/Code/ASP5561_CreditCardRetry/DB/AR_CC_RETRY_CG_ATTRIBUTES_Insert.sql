/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       AR_CC_RETRY_CG_ATTRIBUTES TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: AR_CC_RETRY_CG_ATTRIBUTES

   REM
   REM DESC...: Attribute Table for ASP-5561 AR_IB_CreditCardRetry
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Gowthami Pola     		Attribute Table                                08/07/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */

INSERT ALL into FUSIONINTEGRATION.AR_CC_RETRY_CG_ATTRIBUTES (ATTRIBUTE_ID,ATTRIBUTE_NAME,USER_ATTRIBUTE_NAME)values(1,'CURRENCY','Currency')
INTO FUSIONINTEGRATION.AR_CC_RETRY_CG_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_NAME,USER_ATTRIBUTE_NAME)VALUES (2,'COUNTRY','Country')
INTO FUSIONINTEGRATION.AR_CC_RETRY_CG_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_NAME,USER_ATTRIBUTE_NAME)VALUES (3,'CUSTOMER_PROFILE','Customer Profile')
INTO FUSIONINTEGRATION.AR_CC_RETRY_CG_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_NAME,USER_ATTRIBUTE_NAME)VALUES (4,'LEGAL_ENTITY','Legal Entity')
SELECT * FROM DUAL;
/
COMMIT;
/
SHOW ERRORS
/