DROP TABLE FUSIONINTEGRATION.DS_AP_SUPPLIER_DATA_STG
/

CREATE TABLE "FUSIONINTEGRATION"."DS_AP_SUPPLIER_DATA_STG" 
(	"SUPPLIER_NUMBER" VARCHAR2(40 BYTE) COLLATE "USING_NLS_COMP", 
"SUPPLIER_SITE_CODE" VARCHAR2(100 BYTE) COLLATE "USING_NLS_COMP", 
"LEGACY_EMPLOYEE_NUMBER" VARCHAR2(40 BYTE) COLLATE "USING_NLS_COMP", 
 PRIMARY KEY ("SUPPLIER_NUMBER")
USING INDEX PCTFREE 10 INITRANS 20 MAXTRANS 255 COMPUTE STATISTICS 
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
TABLESPACE "DATA"  ENABLE
)
/