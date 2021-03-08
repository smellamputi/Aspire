/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       AR_CASHSALES_ZUORA_ERROR TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: AR_CASHSALES_ZUORA_ERROR

   REM
   REM DESC...: Error Table for ASP-1852 Zoura Cashsales to Oracle AR
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------       ----------
   REM Satyam Awasthi       Error Table                                                03/07/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE "FUSIONINTEGRATION"."AR_CASHSALES_ZUORA_ERROR";
/ 

CREATE TABLE "FUSIONINTEGRATION"."AR_CASHSALES_ZUORA_ERROR" 
   (            
				 OIC_RUN_ID VARCHAR2(20)
                ,INSTANCE_ID VARCHAR2(20) 
                ,SCOPE_NAME VARCHAR2(50)
                ,RUN_DATE_TIME VARCHAR2(100)
---------------------Status and Error Details Columns--------------------------------------				
                ,STATUS VARCHAR2(20)
                ,ERROR_MESSAGE VARCHAR2(4000) 
                ,ERROR_DETAILS LONG
----------------------------Start of Columns in the Source Extract for Standard Receipts--------------------------------------				
                	
				,CashReceiptId VARCHAR2(150)
				,Comments VARCHAR2(240)
				,ReceiptDate VARCHAR2(40)
				,ConversionDate VARCHAR2(40)
				,AccountingDate VARCHAR2(40)
				,RemittanceBankDepositDate VARCHAR2(40)
				,Amount VARCHAR2(40)
				,Currency VARCHAR2(40)
				,ReceiptNumber VARCHAR2(40)
				,AttributeCategory VARCHAR2(150)
				,Attribute1 VARCHAR2(150)
				,Attribute2 VARCHAR2(150)
				,Attribute3 VARCHAR2(150)
				,Attribute4 VARCHAR2(150)
				,Attribute5 VARCHAR2(150)
				,Attribute6 VARCHAR2(150)
				,Attribute7 VARCHAR2(150)
				,Attribute8 VARCHAR2(150)
				,Attribute9 VARCHAR2(150)
				,Attribute10 VARCHAR2(150)
				,Attribute11 VARCHAR2(150)
-------------------------End of Columns in the Source Extract for Standard Receipts---------------------------------------				
				,ReceiptType VARCHAR2(150)
				,ConversionRate VARCHAR2(150)
				,Source VARCHAR2(150)
				,BusinessUnit VARCHAR2(150)
				,ReceiptMethod VARCHAR2(150)
				,ReceivableActivityName VARCHAR2(150)
-------------------------End of Columns that are constants for Standard Receipts---------------------------------------
				,CREATED_BY VARCHAR2(64)			
				,CREATION_DATE VARCHAR2(100)
				,LAST_UPDATED_BY VARCHAR2(64)
				,LAST_UPDATE_DATE VARCHAR2(100)
				,LAST_UPDATE_LOGIN VARCHAR2(32)
------------------------------------End of WHO Columns-------------------------------------------				
   );
/
SHOW ERRORS;
/