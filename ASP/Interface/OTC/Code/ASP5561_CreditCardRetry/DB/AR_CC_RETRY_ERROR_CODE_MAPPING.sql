/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       AR_CC_RETRY_ERROR_CODE_MAPPING TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: AR_CC_RETRY_ERROR_CODE_MAPPING

   REM
   REM DESC...: Error Mapping Table for ASP-5561 AR_IB_CreditCardRetry
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Nidhi Chamoli     	Error Mapping Table                  					21/05/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODE_MAPPING;
/

CREATE TABLE FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODE_MAPPING (
ERROR_CODE_ID     															NUMBER       
,ERROR_LABEL_ID   		 													NUMBER       
,ERROR_CODE                													VARCHAR2(60) 
,ERROR_LABEL               													VARCHAR2(60) 
,LAST_UPDATE_DATE          													DATE         
,LAST_UPDATED_BY           													VARCHAR2(64) 
,CREATED_BY                													VARCHAR2(64) 
,CREATION_DATE             													DATE 
,CONSTRAINT AR_CC_RETRY_ERROR_CODE_MAPPING_ERROR_CODEID_ERROR_LABEL_ID_PK 	PRIMARY KEY (ERROR_CODE_ID,ERROR_LABEL_ID)
);
/
CREATE INDEX AR_CC_RETRY_ERROR_CODE_MAPPING_ERROR_CODE_IDX ON FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODE_MAPPING (ERROR_CODE) ;
/

SHOW ERRORS
/