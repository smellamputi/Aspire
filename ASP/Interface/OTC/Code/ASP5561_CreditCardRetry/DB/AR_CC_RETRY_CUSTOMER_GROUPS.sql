/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       AR_CC_RETRY_CUSTOMER_GROUPS TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: AR_CC_RETRY_CUSTOMER_GROUPS

   REM
   REM DESC...: Customer Group Table for ASP-5561 AR_IB_CreditCardRetry
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Nidhi Chamoli     	Customer Group Table                          		21/05/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE FUSIONINTEGRATION.AR_CC_RETRY_CUSTOMER_GROUPS;
/

CREATE TABLE FUSIONINTEGRATION.AR_CC_RETRY_CUSTOMER_GROUPS (
CUSTOMER_GROUP_ID   		  												NUMBER         
,CUSTOMER_GROUP_NAME          												VARCHAR2(1000) 
,ACTIVE_FLAG                  												VARCHAR2(10)   
,CG_CONFIG_ID                 												NUMBER         
,CG_RETRY_ID                  												NUMBER         
,LAST_UPDATE_DATE             												DATE           
,LAST_UPDATED_BY              												VARCHAR2(64)   
,CREATED_BY                   												VARCHAR2(64)   
,CREATION_DATE                												DATE 
,CONSTRAINT AR_CC_RETRY_CUSTOMER_GROUPS_CUSTOMER_GROUP_ID_PK				PRIMARY KEY(CUSTOMER_GROUP_ID,CG_CONFIG_ID,CG_RETRY_ID)
,CONSTRAINT AR_CC_RETRY_CG_CONFIG_RULES_CONFIG_ID_CUSTOMER_GROUP_NAME_U 	UNIQUE (CUSTOMER_GROUP_NAME)
);
/

SHOW ERRORS
/