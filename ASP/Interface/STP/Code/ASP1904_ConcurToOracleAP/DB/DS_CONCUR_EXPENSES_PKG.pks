CREATE OR REPLACE package DS_CONCUR_EXPENSES_PKG as 
procedure DS_Concur_update_status (p_dummy varchar2); 
procedure DS_Concur_update_invoice_id (p_dummy varchar2); 
procedure DS_Concur_update_gl_status (p_oic_instance_id varchar2 , p_status varchar2, p_attribute1 varchar2 ,p_attribute3 varchar2 ); 
procedure DS_Concur_purge_data (p_oic_instance_id varchar2 , p_status varchar2, p_attribute1 varchar2 ); 
end DS_CONCUR_EXPENSES_PKG;
/