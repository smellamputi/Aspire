CREATE OR REPLACE package body DS_CONCUR_EXPENSES_PKG as 
procedure DS_Concur_update_status (p_dummy varchar2) as  
begin
update  DS_Concur_PaymentBatch_T
set status = 'Completed'
where attribute1 = 'AP'
and status = 'Inserted';
commit; 
end;
procedure DS_Concur_update_invoice_id (p_dummy varchar2) as 
    l_oic_instance_id varchar2(40) ; 
    l_new_report_id varchar2(40); 
    l_old_report_id varchar2(40); 
    l_invoice_id varchar2(40); 
    l_counter number := 1; 
    l_line_number number := 1; 

    cursor cur_ap_invoices is 
    select a.oic_instance_id , a.report_id  , a.rowid rwid  ,attribute4 , attribute5 , case when report_id = LAG(REPORT_ID, 1, 0) OVER (ORDER BY REPORT_ID) then 1 else 0 end line_id_add from DS_Concur_PaymentBatch_T a 
    where 1=1 -- attribute5 is null 
    and attribute4 is null
    order by report_id 
    ; 
begin
    l_oic_instance_id := null ; 
    l_new_report_id  := '0'; 
    l_old_report_id  := '0'; 
    l_invoice_id   := '0'; 
    l_line_number := 1;
    l_counter  := 1;  
    for rec_ap_invoices in cur_ap_invoices loop 
        l_new_report_id := rec_ap_invoices.report_id; 
        l_oic_instance_id:= rec_ap_invoices.oic_instance_id;

        if (l_new_report_id <> l_old_report_id) then 
        l_counter := l_counter +1 ; 
        l_invoice_id := l_oic_instance_id || trim(to_char(l_counter,'0000'));
        l_line_number := 1;

        update DS_Concur_PaymentBatch_T 
        set attribute5 = l_invoice_id 
        where attribute5 is null 
        and   report_id = rec_ap_invoices.report_id
         ;
commit; 
        update DS_Concur_PaymentBatch_T 
        set attribute4 = '1' 
        where attribute4 is null 
        and   report_id = rec_ap_invoices.report_id
        and   rowid = rec_ap_invoices.rwid
        and   rec_ap_invoices.line_id_add =  0 
         ;
        l_line_number :=  1 ;

        elsif (l_new_report_id = l_old_report_id) then 
        l_old_report_id := rec_ap_invoices.report_id; 
        l_invoice_id := l_oic_instance_id || to_char(l_counter,'0000');
        l_line_number := l_line_number + 1 ;

        update DS_Concur_PaymentBatch_T 
        set attribute5 = l_invoice_id 
        where attribute5 is null 
        and   report_id = rec_ap_invoices.report_id  ;


        end if ;

        update DS_Concur_PaymentBatch_T 
        set attribute4 = (select max(attribute4)+1 from DS_Concur_PaymentBatch_T where report_id = rec_ap_invoices.report_id and attribute4 is not null) 
        where attribute4 is null 
        and   report_id = rec_ap_invoices.report_id
        and   rowid = rec_ap_invoices.rwid
         ;

    commit;
    end loop;

end; 

procedure DS_Concur_update_gl_status (p_oic_instance_id varchar2 , p_status varchar2, p_attribute1 varchar2 ,p_attribute3 varchar2 )
as 
begin
update  DS_Concur_PaymentBatch_T
set status = p_status
where p_attribute1 like '%'||attribute1||'%'
and p_attribute3 like '%'||attribute3||'%' ;
commit; 
end; 

procedure DS_Concur_purge_data (p_oic_instance_id varchar2 , p_status varchar2, p_attribute1 varchar2 )is 
begin
delete 
from DS_Concur_PaymentBatch_T 
where attribute1 = p_attribute1 
and  oic_instance_id = p_oic_instance_id; 

commit; 

exception 
when others then 
null; 
end; 

end DS_CONCUR_EXPENSES_PKG;
/