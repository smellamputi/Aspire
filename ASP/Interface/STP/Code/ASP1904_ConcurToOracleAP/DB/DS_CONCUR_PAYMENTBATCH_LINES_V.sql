
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "FUSIONINTEGRATION"."DS_CONCUR_PAYMENTBATCH_LINES_V" ("INVOICE_ID", "LINE_NUMBER", "LINETYPE", "LINEAMOUNT", "DESCRIPTION", "FINALMATCH", "GLCODE", "END") DEFAULT COLLATION "USING_NLS_COMP"  AS 
  select 
attribute5 invoice_id , 
attribute4 line_number,
'MISCELLANEOUS' LineType,
JOURNAL_AMT  lineAmount,
REPORT_ENTRY_EXPTYPENAME||' | '||attribute2 Description,
'N' FinalMatch,
attribute3||'.'||department||'.'||journal_acccode||'.000.0000.000000' GlCode,
'END' END
from
DS_Concur_PaymentBatch_T 
where attribute1 = 'AP' 
and status <> 'Completed'
order by report_id;
