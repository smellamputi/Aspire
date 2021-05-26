/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       AR_CC_RETRY_ERROR_LABELS TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: AR_CC_RETRY_ERROR_LABELS

   REM
   REM DESC...: Error Label Table for ASP-5561 AR_IB_CreditCardRetry
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Nidhi Chamoli     	Error Label Table                  					21/05/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE FUSIONINTEGRATION.AR_CC_RETRY_ERROR_LABELS;
/

CREATE TABLE FUSIONINTEGRATION.AR_CC_RETRY_ERROR_LABELS (
ERROR_LABEL_ID   			 								NUMBER       
,ERROR_LABEL               									VARCHAR2(60) 
,LAST_UPDATE_DATE          									DATE         
,LAST_UPDATED_BY           									VARCHAR2(64) 
,CREATED_BY                									VARCHAR2(64) 
,CREATION_DATE             									DATE 
,Constraint AR_CC_RETRY_ERROR_LABELS_ERROR_LABEL_ID_PK 		Primary key(ERROR_LABEL_ID)
,Constraint AR_CC_RETRY_ERROR_LABELS_ERROR_LABEL_U 		    UNIQUE(ERROR_LABEL)
);
/
SHOW ERRORS
/