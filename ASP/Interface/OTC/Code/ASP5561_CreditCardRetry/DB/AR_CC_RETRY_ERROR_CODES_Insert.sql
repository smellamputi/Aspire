/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       AR_CC_RETRY_ERROR_CODES TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: AR_CC_RETRY_ERROR_CODES

   REM
   REM DESC...: Error Code Table for ASP-5561 AR_IB_CreditCardRetry
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Nidhi Chamoli     		Error Code Table                                03/05/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */

INSERT ALL into FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES (ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)values(1,100,'Transaction was successful.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (2,101,'Request is missing one or more required fields')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (3,102,'One or more fields in the request contain invalid data.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (4,104,'Merchant reference code for this authorization request matches the
merchant reference code for another authorization request that you
sent within the past 15 minutes.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (5,105,'Merchant transaction identifier (MTI) sent with this request has
already been used in the past 60 days.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (6,110,'Only a partial amount was approved.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (7,150,'System error')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (8,151,'Request was received but a server timeout occurred.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (9,152,'Request was received, but a service did not finish running in time.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (10,153,'Your account is not enabled for the OCT service.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (11,200,'Authorization request was approved by the issuing bank but declined
because the address verification system (AVS) could not verify it.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (12,201,'Issuing bank has questions about the request.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (13,202,'Card is expired.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (14,203,'Card was declined. No other information was provided by the issuing
bank.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (15,204,'Account does not contain sufficient funds.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (16,205,'Card is lost or stolen. ')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (17,207,'Issuing bank is unavailable.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (18,208,'Card is inactive or not authorized for
card-not-present transaction.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (19,209,'CVN did not match.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (20,210,'Account reached the credit limit, or the transaction amount exceeds
the approved limit.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (21,211,'CVN is invalid.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (22,212,'EMV transaction was rejected.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (23,213,'Account is in fraud watch status.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (24,221,'Customers name matched an entry on the processor’s negative file.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (25,230,'Authorization request was approved by the issuing bank but declined
because CVN could not be verified. ')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (26,231,'Account number is invalid.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (27,232,'Payment processor does not accept the card type. ')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (28,233,'Processor declined the card. ')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (29,234,'Information in your account is incorrect. ')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (33,235,'The requested capture amount exceeds the authorized
amount.')

INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (34,236,'Processor failed. ')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (35,237,'Transaction was already captured.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (36,238,'Transaction was already reversed.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (37,239,'Requested transaction amount does not match the previous
transaction amount.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (38,240,'Card type is invalid or does not correlate with the payment card
number. ')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (39,241,'Processor declined the card. For more information about
the decline, search for the transaction in the Business Center and view
the transaction details.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (40,242,' You requested a capture, but there is no corresponding,
unused authorization. ')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (41,243,'Transaction is already settled or reversed.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (42,244,'Account number did not pass a verification check.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (43,246,'One of the following:
• Capture or credit cannot be voided because the capture or credit
information has already been submitted to your processor.
• You requested a void for a type of transaction that cannot be
voided.
')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (44,247,'You requested a credit for a capture that was previously voided.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (45,250,'Request was received, but a timeout occurred at the payment
processor.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (46,251,'Customer has exceeded the debit cards limit on frequency of use,
number of PIN entry tries, or maximum amount for the day')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (47,254,'Stand-alone credits are not allowed. Submit a follow-on credit by
including a request ID in the credit request.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (48,256,'Credit amount exceeds the maximum allowed for your account. ')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (49,257,'Gift card account or prepaid card account is already active.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (50,259,'Reload limit for the gift card or prepaid card was exceeded.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (51,260,'Requested amount conflicts with the minimum or maximum amount
allowed on the gift card or prepaid card.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (52,262,'Request is still in progress. Wait for a response from Cybersource.
')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (53,263,'Mass transit transaction (MTT) was declined.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (54,428,'Your request for a strong customer authentication (SCA) exemption
was declined. ')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (55,478,'Strong customer authentication (SCA) is required for this transaction.
')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (56,490,'Your aggregator or acquirer is not accepting transactions from you at
this time.
')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (57,491,'Your aggregator or acquirer did not accept this transaction.')
INTO FUSIONINTEGRATION.AR_CC_RETRY_ERROR_CODES(ERROR_CODE_ID,ERROR_CODE,ERROR_DESCRIPTION)VALUES (58,520,'Authorization request was approved by the issuing bank
but declined based on your Smart Authorization settings. ')
SELECT * FROM DUAL;
/
COMMIT;
/
SHOW ERRORS
/