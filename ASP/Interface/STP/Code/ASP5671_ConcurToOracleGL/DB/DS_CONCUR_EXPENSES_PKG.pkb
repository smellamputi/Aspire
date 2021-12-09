create or replace PACKAGE BODY ds_concur_expenses_pkg AS

    PROCEDURE ds_concur_update_status (
        p_dummy VARCHAR2
    ) AS
    BEGIN
        UPDATE ds_concur_paymentbatch_t
        SET
            status = 'Completed'
        WHERE
            attribute1 = 'AP'
            AND status = 'Inserted';

        COMMIT;
    exception
        when others then 
              null;
    end;

    PROCEDURE ds_concur_update_invoice_id (
        p_dummy VARCHAR2
    ) AS

        l_oic_instance_id   VARCHAR2(40);
        l_new_report_id     VARCHAR2(40);
        l_old_report_id     VARCHAR2(40);
        l_invoice_id        VARCHAR2(40);
        l_counter           NUMBER := 1;
        l_line_number       NUMBER := 1;
        CURSOR cur_ap_invoices IS
        SELECT
            a.oic_instance_id,
            a.report_id,
            a.rowid rwid,
            attribute4,
            attribute5,
            CASE
                WHEN report_id = LAG(report_id, 1, 0) OVER(
                    ORDER BY
                        report_id
                ) THEN
                    1
                ELSE
                    0
            END line_id_add
        FROM
            ds_concur_paymentbatch_t a
        WHERE
            1 = 1 -- attribute5 is null 
            AND attribute4 IS NULL
        ORDER BY
            report_id;

    BEGIN
        l_oic_instance_id := NULL;
        l_new_report_id := '0';
        l_old_report_id := '0';
        l_invoice_id := '0';
        l_line_number := 1;
        l_counter := 1;
        FOR rec_ap_invoices IN cur_ap_invoices LOOP
            l_new_report_id := rec_ap_invoices.report_id;
            l_oic_instance_id := rec_ap_invoices.oic_instance_id;
            IF ( l_new_report_id <> l_old_report_id ) THEN
                l_counter := l_counter + 1;
                l_invoice_id := l_oic_instance_id
                                || trim(to_char(l_counter, '0000'));
                l_line_number := 1;
                BEGIN
                    UPDATE ds_concur_paymentbatch_t
                    SET
                        attribute5 = l_invoice_id
                    WHERE
                        attribute5 IS NULL
                        AND report_id = rec_ap_invoices.report_id;

                EXCEPTION
                    WHEN OTHERS THEN
                        NULL;
                END;

                COMMIT;
                BEGIN
                    UPDATE ds_concur_paymentbatch_t
                    SET
                        attribute4 = '1'
                    WHERE
                        attribute4 IS NULL
                        AND report_id = rec_ap_invoices.report_id
                        AND ROWID = rec_ap_invoices.rwid
                        AND rec_ap_invoices.line_id_add = 0;

                EXCEPTION
                    WHEN OTHERS THEN
                        NULL;
                END;

                l_line_number := 1;
            ELSIF ( l_new_report_id = l_old_report_id ) THEN
                l_old_report_id := rec_ap_invoices.report_id;
                l_invoice_id := l_oic_instance_id || to_char(l_counter, '0000');
                l_line_number := l_line_number + 1;
                BEGIN
                    UPDATE ds_concur_paymentbatch_t
                    SET
                        attribute5 = l_invoice_id
                    WHERE
                        attribute5 IS NULL
                        AND report_id = rec_ap_invoices.report_id;

                EXCEPTION
                    WHEN OTHERS THEN
                        NULL;
                END;

            END IF;

            BEGIN
                UPDATE ds_concur_paymentbatch_t
                SET
                    attribute4 = (
                        SELECT
                            MAX(attribute4) + 1
                        FROM
                            ds_concur_paymentbatch_t
                        WHERE
                            report_id = rec_ap_invoices.report_id
                            AND attribute4 IS NOT NULL
                    )
                WHERE
                    attribute4 IS NULL
                    AND report_id = rec_ap_invoices.report_id
                    AND ROWID = rec_ap_invoices.rwid;

            EXCEPTION
                WHEN OTHERS THEN
                    NULL;
            END;

            COMMIT;
        END LOOP;

    END;

    PROCEDURE ds_concur_update_gl_status (
        p_oic_instance_id   VARCHAR2,
        p_status            VARCHAR2,
        p_attribute1        VARCHAR2,
        p_attribute3        VARCHAR2
    ) AS
    BEGIN
        UPDATE ds_concur_paymentbatch_t
        SET
            status = p_status
        WHERE
            p_attribute1 LIKE '%'
                              || attribute1
                              || '%'
            AND p_attribute3 LIKE '%'
                                  || attribute3
                                  || '%';

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    PROCEDURE ds_concur_purge_data (
        p_oic_instance_id   VARCHAR2,
        p_status            VARCHAR2,
        p_attribute1        VARCHAR2
    ) IS
    BEGIN
        DELETE FROM ds_concur_paymentbatch_t
        WHERE
            attribute1 = p_attribute1 
and  oic_instance_id = p_oic_instance_id
            ;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

END ds_concur_expenses_pkg;
/