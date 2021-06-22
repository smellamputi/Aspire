/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       DS_COST_CENTER TABLE SCRIPT
       $Version 1.0
   REM ========================================================================================================
   REM
   REM NAME...: DS_COST_CENTER

   REM
   REM DESC...: Stage Table for ASP-1909 ADP To Oracel GL
   REM
   REM
   REM FILES..: cost center.csv
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                               					  WHEN
   REM --------------       ----------------------------------------------      				 ----------
   REM Divyanshu Anand   Stage Table to store crosswalk information from cost center.csv file     20/05/2021
   REM
   REM ==============================================================================================
   REM
   REM ==============================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
DROP TABLE "FUSIONINTEGRATION"."DS_COST_CENTER";
/ 

CREATE TABLE "FUSIONINTEGRATION"."DS_COST_CENTER" 
   (            
    COST_CENTER VARCHAR2(30),
	SOURCESYSTEMID VARCHAR2(30),
	DESCRIPTION VARCHAR2(240)
   );
/
SHOW ERRORS
/