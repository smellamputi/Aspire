/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       AR_CC_RETRY_ERROR_CODES TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: AR_CC_RETRY_ERROR_CODES

   REM
   REM DESC...: Error Code Table for ASP-5561 AR_IB_CreditCardRetry
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Nidhi Chamoli     	Error Code Table                  					21/05/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES;
/

CREATE TABLE FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES (
ERROR_CODE_ID    										NUMBER         
,ERROR_CODE                 							VARCHAR2(60)   
,ERROR_DESCRIPTION          							VARCHAR2(2000) 
,LAST_UPDATE_DATE           							DATE           
,LAST_UPDATED_BY            							VARCHAR2(64)   
,CREATED_BY                 							VARCHAR2(64)   
,CREATION_DATE              							DATE 
,Constraint AR_CC_RETRY_ERROR_CODES_ERROR_CODE_ID_PK 	Primary key(ERROR_CODE_ID)
,Constraint AR_CC_RETRY_ERROR_CODES_ERROR_CODE_U 	UNIQUE(ERROR_CODE)

);
/
SHOW ERRORS
/