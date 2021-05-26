/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       AR_CC_RETRY_PKG PACKAGE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: AR_CC_RETRY_PKG

   REM
   REM DESC...: Package to identify eligible invoices for ASP-5561 Credit Card Retry Interface
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Gowthami Pola        Package to identify eligible invoices                05/24/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
CREATE OR REPLACE PACKAGE fusionintegration.ar_cc_retry_pkg
AS
   PROCEDURE ar_cc_retry_cg_inv_prc (p_customer_group   IN     VARCHAR2,
                                     p_user_name        IN     VARCHAR2,
                                     p_instance_id      IN     NUMBER,
                                     p_status              OUT VARCHAR2,
                                     p_message             OUT VARCHAR2);
END ar_cc_retry_pkg;