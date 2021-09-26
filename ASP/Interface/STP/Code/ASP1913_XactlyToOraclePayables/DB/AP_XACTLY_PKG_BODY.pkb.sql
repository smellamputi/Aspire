CREATE OR REPLACE PACKAGE BODY AP_XACTLY_MAP_PKG AS

    PROCEDURE AP_INSERT_SRC_SEG (
        P_RECORD IN AP_XACTLY_SRC_REC_TYPE
    ) IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        BEGIN
            FOR I IN P_RECORD.FIRST..P_RECORD.LAST LOOP
                INSERT INTO AP_XACTLY_SRC_TBL VALUES (
                    P_RECORD(I).CODE_IDENTIFIER,
                    P_RECORD(I).INVOICE_ID,
                    P_RECORD(I).BUSINESS_UNIT,
                    P_RECORD(I).INVOICE_NUMBER,
                    P_RECORD(I).INVOICE_AMOUNT,
                    P_RECORD(I).INVOICE_DATE,
                    P_RECORD(I).DESCRIPTION,
                    P_RECORD(I).LEGAL_ENTITY,
                    P_RECORD(I).ACCOUNTING_DATE,
                    XACTLY_SEQ.NEXTVAL,
                    - 1,
                    SYSDATE,
                    - 1,
                    SYSDATE,
                    - 1
                );

            END LOOP;

            COMMIT;
        END;
    END AP_INSERT_SRC_SEG;

    PROCEDURE XACTLY_DATA_DEL (
        P_IN_CODE_IDENTIFIER IN NUMBER
    ) IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        BEGIN
            EXECUTE IMMEDIATE 'DELETE AP_XACTLY_SRC_TBL';
            EXECUTE IMMEDIATE 'DELETE XACTLY_PKG_EXEC_STATUS';
            EXECUTE IMMEDIATE 'ALTER SEQUENCE "FUSIONINTEGRATION"."XACTLY_SEQ" RESTART START WITH 1';
            COMMIT;
        END;
    END XACTLY_DATA_DEL;

    PROCEDURE AP_CONC_COMMIT (
        P_IN_CODE_IDENTIFIER IN NUMBER
    ) IS
    BEGIN
        BEGIN
            COMMIT;
        END;
    END AP_CONC_COMMIT;

END AP_XACTLY_MAP_PKG;
/