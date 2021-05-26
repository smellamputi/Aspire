/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       AR_CC_RETRY_CG_RETRY_RULES TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: AR_CC_RETRY_CG_RETRY_RULES

   REM
   REM DESC...: Retry Rules Table for ASP-5561 AR_IB_CreditCardRetry
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Nidhi Chamoli     	Retry Rules Table                  					21/05/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE FUSIONINTEGRATION.AR_CC_RETRY_CG_RETRY_RULES;
/

CREATE TABLE FUSIONINTEGRATION.AR_CC_RETRY_CG_RETRY_RULES (
CG_RETRY_ID          		  																		NUMBER         
,CUSTOMER_GROUP_NAME          																		VARCHAR2(1000) 
,ERROR_LABEL_ID       		  																		NUMBER         
,ERROR_LABEL                  																		VARCHAR2(60)   
,LAST_UPDATE_DATE             																		DATE           
,LAST_UPDATED_BY              																		VARCHAR2(64)   
,CREATED_BY                   																		VARCHAR2(64)   
,CREATION_DATE                																		DATE           
,INTERVAL_TYPE                																		VARCHAR2(100)  
,RETRY_INTERVAL               																		NUMBER         
,ATTEMPT_ID          		  																		NUMBER         
,ATTEMPT_NAME                 																		VARCHAR2(50)
,CONSTRAINT AR_CC_RETRY_CG_RETRY_RULES_CG_RETRY_ID_ERROR_LABEL_ID_ATTEMPT_ID_PK 					PRIMARY KEY (CG_RETRY_ID,ERROR_LABEL_ID,ATTEMPT_ID)
);
/
SHOW ERRORS
/