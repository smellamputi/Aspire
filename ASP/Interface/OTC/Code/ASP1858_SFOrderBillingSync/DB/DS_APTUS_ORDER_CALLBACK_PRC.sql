create or replace procedure DS_APTUS_ORDER_CALLBACK_PRC 
(P_apptus_order_id varchar2,
 P_status varchar2,
 P_error_code varchar2,
 P_Error_desc varchar2,
 P_oic_instance_id number,
 p_stage varchar2
 )
as 
begin 

if lower(p_stage) = 'start' then 
--insert child record 
begin 
insert into DS_OSS_SFDC_APTTUS_ORD_T (APTTUS_ORDER_ID,STAGE ,STATUS, ERROR_CODE, ERROR_DESCRIPTION,OIC_INSTANCE_ID, CREATED_BY, CREATED_ON)
values(P_apptus_order_id,p_stage,P_status , null, null,P_oic_instance_id, 'OIC', sysdate);
exception 
when others then null; 
end ;
--delete parent entry 
--begin 
--    delete from DS_OSS_SFDC_APTTUS_ORD_T 
--    where APTTUS_ORDER_ID = P_apptus_order_id 
--    and OIC_INSTANCE_ID <> P_oic_instance_id
--    and CREATED_ON >= sysdate - 1/24; 
--exception 
--when others then null; 
--end ;

else 
--update
begin 
update DS_OSS_SFDC_APTTUS_ORD_T
set status = P_status,
ERROR_CODE = P_error_code,
ERROR_DESCRIPTION = P_Error_desc , 
UPDATED_BY = 'OIC',
UPDATED_ON = sysdate,
stage = p_stage ,
SUB_NUM = P_oic_instance_id
where OIC_INSTANCE_ID = P_oic_instance_id
and APTTUS_ORDER_ID = P_apptus_order_id;
exception 
when others then null; 
end ;
end if ; 

--delete parent entry 
begin 
    delete from DS_OSS_SFDC_APTTUS_ORD_T 
    where APTTUS_ORDER_ID = P_apptus_order_id 
    and OIC_INSTANCE_ID <> P_oic_instance_id
    and CREATED_ON >= sysdate - 1/24; 
exception 
when others then null; 
end ;

commit;

end DS_APTUS_ORDER_CALLBACK_PRC; 
