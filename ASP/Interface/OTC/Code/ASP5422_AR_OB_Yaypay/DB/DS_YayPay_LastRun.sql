/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       DS_YayPay_LastRun TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: DS_YayPay_LastRun

   REM
   REM DESC...: Stage Table for ASP-5422 AR OB YAYPAY
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Soumyadeep Banerjee     Stage Table to store Legal Entity Information       12/05/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
CREATE TABLE "FUSIONINTEGRATION"."DS_YayPay_LastRun" 
   (	"LEGAL_ENTITY" VARCHAR2(2000 BYTE) COLLATE "USING_NLS_COMP", 
	"LAST_RUN" DATE, 
	"INT_NAME" VARCHAR2(30 BYTE) COLLATE "USING_NLS_COMP", 
	"INT_ID" VARCHAR2(30 BYTE) COLLATE "USING_NLS_COMP", 
	"PREVIOUS_RUN" DATE
   );
   
INSERT ALL
INTO "FUSIONINTEGRATION"."DS_YayPay_LastRun" (LEGAL_ENTITY,LAST_RUN,INT_NAME,INT_ID,PREVIOUS_RUN) VALUES ('DocuSign France SAS',ADD_MONTHS(SYSDATE,-1,825),'AR_OB_YayPay_BillingData','ASP5422',ADD_MONTHS(SYSDATE,-1,825))
INTO "FUSIONINTEGRATION"."DS_YayPay_LastRun" (LEGAL_ENTITY,LAST_RUN,INT_NAME,INT_ID,PREVIOUS_RUN) VALUES ('DocuSign International (EMEA) Limited',ADD_MONTHS(SYSDATE,-1,825),'AR_OB_YayPay_BillingData','ASP5422',ADD_MONTHS(SYSDATE,-1,825))
INTO "FUSIONINTEGRATION"."DS_YayPay_LastRun" (LEGAL_ENTITY,LAST_RUN,INT_NAME,INT_ID,PREVIOUS_RUN) VALUES ('DocuSign, Inc.',ADD_MONTHS(SYSDATE,-1,825),'AR_OB_YayPay_BillingData','ASP5422',ADD_MONTHS(SYSDATE,-1,825))
INTO "FUSIONINTEGRATION"."DS_YayPay_LastRun" (LEGAL_ENTITY,LAST_RUN,INT_NAME,INT_ID,PREVIOUS_RUN) VALUES ('Liveoak Technologies, Inc.',ADD_MONTHS(SYSDATE,-1,825),'AR_OB_YayPay_BillingData','ASP5422',ADD_MONTHS(SYSDATE,-1,825))
INTO "FUSIONINTEGRATION"."DS_YayPay_LastRun" (LEGAL_ENTITY,LAST_RUN,INT_NAME,INT_ID,PREVIOUS_RUN) VALUES ('SpringCM Inc.',ADD_MONTHS(SYSDATE,-1,825),'AR_OB_YayPay_BillingData','ASP5422',ADD_MONTHS(SYSDATE,-1,825))
SELECT * FROM DUAL;