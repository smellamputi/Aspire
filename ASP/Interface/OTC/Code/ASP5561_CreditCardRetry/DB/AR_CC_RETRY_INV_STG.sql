/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       ar_cc_retry_inv_stg TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: ar_cc_retry_inv_stg

   REM
   REM DESC...: Staging Table for ASP-5561 AR_IB_CreditCardRetry
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Nidhi Chamoli     	Staging Table                  						21/05/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE FUSIONINTEGRATION.AR_CC_RETRY_INV_STG;
/

CREATE TABLE FUSIONINTEGRATION.AR_CC_RETRY_INV_STG (
RECORD_ID              		  								NUMBER         
,OIC_INSTANCE_ID       		   								NUMBER         
,INVOICE_NUM                    							VARCHAR2(20)   
,CUSTOMER_TRX_ID                							NUMBER         
,INV_RETRY_COUNT                							NUMBER         
,ERROR_CODE                     							VARCHAR2(40)   
,CG_ATTRIBUTE1                  							VARCHAR2(500)  
,CG_ATTRIBUTE2                  							VARCHAR2(500)  
,CG_ATTRIBUTE3                  							VARCHAR2(500)  
,CG_ATTRIBUTE4                  							VARCHAR2(500)  
,CUSTOMER_GROUP_NAME            							VARCHAR2(1000) 
,ERROR_LABEL                    							VARCHAR2(40)   
,RETRY_COUNT                    							NUMBER         
,RETRY_INTERVAL                 							NUMBER         
,ELIGIBLE_FLAG                  							VARCHAR2(3)    
,LAST_UPDATE_DATE               							DATE           
,LAST_UPDATED_BY                							VARCHAR2(64)   
,CREATED_BY                     							VARCHAR2(64)   
,CREATION_DATE                  							DATE           
,CG_ATTR1_VALUE                 							VARCHAR2(500)  
,CG_ATTR2_VALUE                 							VARCHAR2(500)  
,CG_ATTR3_VALUE                 							VARCHAR2(500)  
,CG_ATTR4_VALUE                 							VARCHAR2(500)  
,BU_ID                          							NUMBER         
,CURRENCY                       							VARCHAR2(50)   
,RECEIPT_METHOD_ID              							NUMBER         
,RECEIPT_CLASS_ID               							NUMBER         
,INTERVAL_TYPE                  							VARCHAR2(100)  
,INTERVAL_DIFF                  							NUMBER         
,LAST_PMT_ATTEMPT_DATE          							DATE  
,CONSTRAINT AR_CC_RETRY_INV_STG_RECORD_ID_INSTANCE_ID_PK 	PRIMARY KEY (RECORD_ID,OIC_INSTANCE_ID)
);
/
CREATE INDEX AR_CC_RETRY_INV_STG_CG_ATTR1ATTR2ATTR3ATTR4_IDX ON FUSIONINTEGRATION.AR_CC_RETRY_INV_STG (CG_ATTR1_VALUE,CG_ATTR2_VALUE,CG_ATTR3_VALUE,CG_ATTR4_VALUE ) ;

CREATE INDEX AR_CC_RETRY_INV_STG_INV_RETRY_COUNT_ERROR_LABEL_IDX ON FUSIONINTEGRATION.AR_CC_RETRY_INV_STG (INV_RETRY_COUNT,ERROR_LABEL ) ;
/

SHOW ERRORS
/