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
   REM Nidhi Chamoli     	Attribute Table                          			21/05/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE FUSIONINTEGRATION.AR_CC_RETRY_CG_ATTRIBUTES;
/

CREATE TABLE FUSIONINTEGRATION.AR_CC_RETRY_CG_ATTRIBUTES (
ATTRIBUTE_ID     		 											NUMBER        
,ATTRIBUTE_NAME            											VARCHAR2(500) 
,LAST_UPDATE_DATE          											DATE          
,LAST_UPDATED_BY           											VARCHAR2(64)  
,CREATED_BY                											VARCHAR2(64)  
,CREATION_DATE             											DATE  
,Constraint AR_CC_RETRY_CG_ATTRIBUTES_ATTRIBUTE_ID_PK 				PRIMARY KEY(ATTRIBUTE_ID)
,Constraint AR_CC_RETRY_CG_ATTRIBUTES_ATTRIBUTE_NAME_U 				UNIQUE(ATTRIBUTE_NAME)
);
/
SHOW ERRORS
/