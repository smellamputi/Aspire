
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "FUSIONINTEGRATION"."DS_CONCUR_PAYMENTBATCH_V" ("INVOICE_ID", "COMPANY_CODE", "BU_CODE", "INV_SOURCE", "SEGMENT3", "INV_NUMBER", "INV_AMT", "INV_DATE", "SUPP_NAME", "N1", "SUPP_SITE_CODE", "INV_CURR", "PAY_CURR", "INV_DESC", "INV_TYPE", "LEGAL_ENTITY", "N2", "N3", "N4", "N5", "PAY_TERM", "N6", "N7", "N8", "ACCT_DATE", "END") DEFAULT COLLATION "USING_NLS_COMP"  AS 
  select  invoice_header."INVOICE_ID",invoice_header."COMPANY_CODE",invoice_header."BU_CODE",invoice_header."INV_SOURCE",invoice_header."SEGMENT3",invoice_header."INV_NUMBER",invoice_header."INV_AMT",invoice_header."INV_DATE",invoice_header."SUPP_NAME",invoice_header."N1",invoice_header."SUPP_SITE_CODE",invoice_header."INV_CURR",invoice_header."PAY_CURR",invoice_header."INV_DESC",invoice_header."INV_TYPE",invoice_header."LEGAL_ENTITY",invoice_header."N2",invoice_header."N3",invoice_header."N4",invoice_header."N5",invoice_header."PAY_TERM",invoice_header."N6",invoice_header."N7",invoice_header."N8",invoice_header."ACCT_DATE",invoice_header."END" from 
(select distinct 
attribute5 invoice_id ,
attribute3 company_code ,       
attribute3 bu_code,             --400 -- IE BU EUR
--'DS - CONCUR' inv_source,
'CONCUR' inv_source,
null segment3, -- oracle gl account 
REPORT_ID inv_number,
(select sum(JOURNAL_AMT) from DS_Concur_PaymentBatch_T D2 where D2.REPORT_ID = D1.REPORT_ID)  inv_amt,
to_char(to_date(REPORT_SUBMIT_DATE,'yyyy-mm-dd'),'yyyy/mm/dd') inv_date,
(select SUPPLIER_NUMBER from DS_AP_SUPPLIER_DATA_STG where D1.EMPLOYEE_ID = LEGACY_EMPLOYEE_NUMBER and rownum < 2 ) supp_name, --DNU 
cast(NULL as varchar2(255)) n1,
(select SUPPLIER_SITE_CODE from DS_AP_SUPPLIER_DATA_STG where D1.EMPLOYEE_ID = LEGACY_EMPLOYEE_NUMBER and rownum < 2 ) supp_site_code,
EMPLOYEE_DCURACODE inv_curr,
EMPLOYEE_DCURACODE pay_curr,
report_name inv_Desc,
'STANDARD' inv_type,
attribute3 legal_entity,      --ERP_Legal_Entity
cast(NULL as varchar2(255)) n2,
cast(NULL as varchar2(255)) n3,
cast(NULL as varchar2(255)) n4,
cast(NULL as varchar2(255)) n5,
'Immediate' pay_term,
cast(NULL as varchar2(255)) n6,
cast(NULL as varchar2(255)) n7,
cast(NULL as varchar2(255)) n8,
to_char(to_date(REPORT_SUBMIT_DATE,'yyyy-mm-dd'),'yyyy/mm/dd') acct_date,
'END' END
from
DS_Concur_PaymentBatch_T D1
where attribute1 = 'AP'
and status <> 'Completed'
) invoice_header;
