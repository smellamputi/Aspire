create or replace PROCEDURE AR_YAYPAY_LAST_UPDATE_PROC (p_last_update IN VARCHAR2, p_le IN VARCHAR2)
AS
BEGIN
    UPDATE  "FUSIONINTEGRATION"."DS_YayPay_LastRun"
    SET last_run = TO_DATE(p_last_update,'DD-MM-RRRR HH24:MI:SS')  --TO_DATE(TO_CHAR(SYSDATE,'DD-MM-RRRR HH24:MI:SS'),'DD-MM-RRRR HH24:MI:SS')
    WHERE 1 = 1
    AND legal_entity = p_le;
    COMMIT;
END;