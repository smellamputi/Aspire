CREATE TABLE FUSIONINTEGRATION.OSS_PARTNERRESELLAR_SF_ARCHIVE
   (            
				OIC_RUN_ID VARCHAR2(20)
                ,INSTANCE_ID VARCHAR2(20) 
                ,RUN_DATE_TIME VARCHAR2(100)
---------------------Status and Error Details Columns--------------------------------------				
                ,STATUS VARCHAR2(20)
                ,ERROR_MESSAGE VARCHAR2(4000) 
                ,ERROR_DETAILS LONG
-----------------------------------Start of Columns in the Report Extract--------------------------------------				
                ,CreatedByModule VARCHAR2(40)
				,OrganizationName VARCHAR2(40)
				,OrigSystem VARCHAR2(40)
				,OrigSystemReference VARCHAR2(40)
				,PartySiteName VARCHAR2(2000)
---------------------CreateCustomer Columns--------------------------------------					
				
				
				,PersonFirstName VARCHAR2(40)
				,PersonLastName VARCHAR2(40)
				,ObjectId VARCHAR2(40)
				
				,ContactNumber VARCHAR2(40)
---------------------CreatePerson Columns--------------------------------------				
				
				
				,PartyId VARCHAR2(40)
				,AccountName VARCHAR2(40)
				,PartySiteId VARCHAR2(40)
				,SetId VARCHAR2(40)
---------------------CreateAccount Columns--------------------------------------				
				
				,SubscriptionNumber VARCHAR2(40)
				,PrimaryPartyId VARCHAR2(40)
				,BillToAccountId VARCHAR2(40)
				,SubscriptionProfileId VARCHAR2(40)
				
---------------------Subscription Columns--------------------------------------
---------------------------------------------End of Columns in the Report Extract---------------------------------------				
				,CREATED_BY VARCHAR2(64)			
				,CREATION_DATE VARCHAR2(100)
				,LAST_UPDATED_BY VARCHAR2(64)
				,LAST_UPDATE_DATE VARCHAR2(100)
				,LAST_UPDATE_LOGIN VARCHAR2(32)
------------------------------------End of WHO Columns-------------------------------------------				
   );
