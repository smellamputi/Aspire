CREATE TABLE FUSIONINTEGRATION.OSS_ProvisionDateSync_SF_ERROR
   (            
                 INSTANCE_ID VARCHAR2(20) 
                ,INTERFACE_ID VARCHAR2(10)
                ,INTERFACE_NAME VARCHAR2(50)
                ,SCOPE_NAME VARCHAR2(50)
                ,RUN_DATETIME VARCHAR2(100)                                
                ,STATUS VARCHAR2(20)
                ,ERROR_MESSAGE VARCHAR2(5000) 
                ,ERROR_DETAILS LONG
				,SUBSCRIPTION_NUMBER VARCHAR2(50)
				,LINE_NUMBER VARCHAR2(20)
                ,ORDER_LINE_ID VARCHAR2(20)
                ,ORDER_ID VARCHAR2(20)
                ,PRODUCT_NAME VARCHAR2(30)
                ,PROVISION_DATE_C VARCHAR2(50)
    );
    