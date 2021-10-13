create or replace PACKAGE BODY GL_ADP_COA_MAP_PKG
AS
PROCEDURE JL_INSERT_SRC_SEG(P_RECORD IN GL_ADP_SRC_REC_TYPE) 
IS  
PRAGMA AUTONOMOUS_TRANSACTION; 
BEGIN
  BEGIN
	FOR I IN P_RECORD.FIRST .. P_RECORD.LAST 
    LOOP
	INSERT INTO GL_ADP_SRC_TBL VALUES (  
                         P_RECORD (I).CODE_IDENTIFIER, 
                         P_RECORD (I).STATUS_CODE,
                         P_RECORD (I).LEDGER_ID   ,    
                         P_RECORD (I).JOURNAL_SOURCE , 
                         P_RECORD (I).JOURNAL_CATEGORY,
                         P_RECORD (I).ACCOUNTING_DATE	,
                         P_RECORD (I).CURRENCY_CODE	,
                         P_RECORD (I).DATE_CREATED 	,
                         P_RECORD (I).SEGMENT1		,
                         P_RECORD (I).SEGMENT2 		,
                         P_RECORD (I).SEGMENT3 		,
                         P_RECORD (I).ENTERED_DR 	,	
                         P_RECORD (I).ENTERED_CR 	,
						 P_RECORD (I).REFERENCE4 	,
						 P_RECORD (I).REFERENCE5 	,
						 P_RECORD (I).REFERENCE10 	, 
                         ADP_SEQ.NEXTVAL,            
						 NULL,
                         -1,
                         SYSDATE,
                         -1,
                         SYSDATE,
                         -1						        
                        );
    END LOOP;
    COMMIT;
  END;

END JL_INSERT_SRC_SEG;


PROCEDURE JL_CONC_SEG_TRANS(P_IN_CODE_IDENTIFIER IN NUMBER)
IS 
PRAGMA AUTONOMOUS_TRANSACTION; 
v_temp varchar2(1);
BEGIN

BEGIN
    select EXEC_STATUS
    into v_temp
    from ADP_PKG_EXEC_STATUS
    where IDENTIFIER = P_IN_CODE_IDENTIFIER
    AND rownum = 1;
EXCEPTION WHEN NO_DATA_FOUND THEN
    INSERT INTO ADP_PKG_EXEC_STATUS VALUES(P_IN_CODE_IDENTIFIER, 'Y'); 
    COMMIT;
WHEN OTHERS THEN 
NULL;
END;

--SEGMENT2:
UPDATE FUSIONINTEGRATION.GL_ADP_SRC_TBL SET ORA_SEGMENT2 = (SELECT DISTINCT COST_CENTER
														    FROM FUSIONINTEGRATION.DS_COST_CENTER
															WHERE 1 = 1
															AND SOURCESYSTEMID = SEGMENT2
													        UNION ALL
                                                            SELECT 'NOVALUE' COST_CENTER
                                                            FROM DUAL WHERE
                                                            NOT EXISTS(SELECT '1'
                                                            FROM FUSIONINTEGRATION.DS_COST_CENTER
                                                            WHERE 1 = 1
                                                            AND SOURCESYSTEMID = SEGMENT2)
) WHERE ORA_SEGMENT2 IS NULL;

COMMIT;



UPDATE ADP_PKG_EXEC_STATUS SET EXEC_STATUS = 'N' WHERE IDENTIFIER = P_IN_CODE_IDENTIFIER; 
COMMIT;

END JL_CONC_SEG_TRANS;

PROCEDURE JL_CONC_DATA_DEL(P_IN_CODE_IDENTIFIER IN NUMBER)
IS 
PRAGMA AUTONOMOUS_TRANSACTION; 
BEGIN 
BEGIN
    EXECUTE IMMEDIATE 'DELETE GL_ADP_SRC_TBL'; 
    EXECUTE IMMEDIATE 'DELETE ADP_PKG_EXEC_STATUS'; 
    EXECUTE IMMEDIATE 'ALTER SEQUENCE "FUSIONINTEGRATION"."ADP_SEQ" RESTART START WITH 1';
    COMMIT;
    
END;

END JL_CONC_DATA_DEL;
PROCEDURE JL_CONC_COMMIT(P_IN_CODE_IDENTIFIER IN NUMBER)
IS 

BEGIN 
BEGIN
   COMMIT;
END;

END JL_CONC_COMMIT;

END GL_ADP_COA_MAP_PKG;

/