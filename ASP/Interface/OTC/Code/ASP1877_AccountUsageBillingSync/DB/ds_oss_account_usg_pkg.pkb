CREATE OR REPLACE PACKAGE BODY ds_oss_account_usg_pkg AS

    errcode  NUMBER := sqlcode;
    errmsg   VARCHAR2(32000) := sqlerrm;

    PROCEDURE insert_tracking_id (
        p_stitch_data_rec  IN   stitch_rec_type,
        p_insert_status    OUT  VARCHAR2
    ) IS
        l_trackingcount NUMBER;
    BEGIN
        BEGIN
            SELECT
                COUNT(*)
            INTO l_trackingcount
            FROM
                fusionintegration.oss_stitch_payload_stg
            WHERE
                    trackingid = p_stitch_data_rec.trackingid
                AND status IN ( 'N', 'P' );
              --  AND message IS NULL;

        EXCEPTION
            WHEN OTHERS THEN
                l_trackingcount := 0;
        END;

        IF ( l_trackingcount = 0 ) THEN
            BEGIN
                INSERT INTO fusionintegration.oss_stitch_payload_stg (
                    record_id,
                    run_date_time,
                    interface_id,
                    interface_name,
                    instance_id,
                    trackingid,
                    s3downloadlink,
                    status,
                    message
                ) VALUES (
                    p_stitch_data_rec.record_id,
                    p_stitch_data_rec.run_date_time,
                    p_stitch_data_rec.interface_id,
                    p_stitch_data_rec.interface_name,
                    p_stitch_data_rec.instance_id,
                    p_stitch_data_rec.trackingid,
                    p_stitch_data_rec.s3downloadlink,
                    'N',
                    NULL
                );

            END;

            p_insert_status := 'S';
        ELSE
            BEGIN
                INSERT INTO fusionintegration.oss_accountusage_core_error (
                    record_id,
                    run_date_time,
                    interface_id,
                    interface_name,
                    instance_id,
                    s3trackingid,
                    status,
                    error_code,
                    error_message,
                    error_details
                ) VALUES (
                    p_stitch_data_rec.record_id,
                    p_stitch_data_rec.run_date_time,
                    p_stitch_data_rec.interface_id,
                    p_stitch_data_rec.interface_name,
                    p_stitch_data_rec.instance_id,
                    p_stitch_data_rec.trackingid,
                    'E',
                    errcode,
                    errmsg,
                    'Duplicate values exists in FUSIONINTEGRATION.OSS_STITCH_PAYLOAD_STG table for trackingid ' || p_stitch_data_rec.
                    trackingid
                );

                p_insert_status := 'E';
            END;
        END IF;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            BEGIN
                errcode := sqlcode;
                errmsg := sqlerrm;
                dbms_output.put_line('PLSQL exception while inserting stitch payload in FUSIONINTEGRATION.OSS_STITCH_PAYLOAD_STG Table : '
                                     || errcode
                                     || ' - '
                                     || errmsg);
                INSERT INTO fusionintegration.cif_log_messages_tbl (
                    instance_id,
                    interface_name,
                    interface_id,
                    sequence_number,
                    run_date,
                    scope_name,
                    status,
                    error_code,
                    error_message,
                    error_details,
                    attribute1,
                    attribute2,
                    attribute3,
                    attribute4,
                    attribute5,
                    attribute6,
                    attribute7,
                    attribute8,
                    attribute9,
                    attribute10,
                    attribute11,
                    attribute12,
                    attribute13,
                    attribute14,
                    attribute15,
                    attribute16,
                    attribute17,
                    attribute18,
                    attribute19,
                    attribute20,
                    attribute21,
                    attribute22,
                    attribute23,
                    attribute24,
                    attribute25,
                    attribute26,
                    attribute27,
                    attribute28,
                    attribute29,
                    attribute30,
                    last_updated_date,
                    last_update_by,
                    last_login_by,
                    created_by,
                    created_date
                ) VALUES (
                    p_stitch_data_rec.instance_id,
                    p_stitch_data_rec.interface_name,
                    p_stitch_data_rec.interface_id,
                    p_stitch_data_rec.record_id,
                    p_stitch_data_rec.run_date_time,
                    NULL,
                    'E',
                    errcode,
                    errmsg,
                    'PLSQL exception while inserting stitch payload in FUSIONINTEGRATION.OSS_STITCH_PAYLOAD_STG Table',
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    p_stitch_data_rec.run_date_time,
                    NULL,
                    NULL,
                    NULL,
                    p_stitch_data_rec.run_date_time
                );

                COMMIT;
                p_insert_status := 'E';
            END;
    END insert_tracking_id;

    PROCEDURE insert_usagedata (
        p_schedule_instance_id  IN  VARCHAR2,
        p_run_date              IN  TIMESTAMP,
        p_interface_id          IN  VARCHAR2,
        p_interface_name        IN  VARCHAR2,
        p_instance_id           IN  VARCHAR2,
        p_process_flag          IN  VARCHAR2,
        p_message               IN  VARCHAR2,
        p_trackingid            IN  VARCHAR2,
        p_usage_data_rec        IN  usagedata_tbl_type
    ) IS

        errcode  NUMBER;
        errmsg   VARCHAR2(32000);
        errindx  VARCHAR2(240);
        lcount   NUMBER := 0;
        dup_val EXCEPTION;
        PRAGMA exception_init ( dup_val, -00001 );
    BEGIN
        FORALL indx IN p_usage_data_rec.first..p_usage_data_rec.last SAVE EXCEPTIONS
            INSERT INTO fusionintegration.oss_accountusage_core_stg (
                record_id,
                schedule_instance_id,
                run_date_time,
                interface_id,
                interface_name,
                instance_id,
                process_flag,
                message,
                trackingid,
                dsaccountid,
                uom,
                quantity,
                usagedate,
                usageid
            ) VALUES (
                p_usage_data_rec(indx).record_id,
                p_schedule_instance_id,
                p_run_date,
                p_interface_id,
                p_interface_name,
                p_instance_id,
                p_process_flag,
                p_message,
                p_trackingid,
                p_usage_data_rec(indx).dsaccountid,
                p_usage_data_rec(indx).uom,
                p_usage_data_rec(indx).quantity,
                p_usage_data_rec(indx).usagedate,
                p_usage_data_rec(indx).usageid
            );

        BEGIN
            UPDATE fusionintegration.oss_stitch_payload_stg
            SET
                status = 'P',
                message = 'Please refer table FUSIONINTEGRATION.OSS_ACCOUNTUSAGE_CORE_STG for INSTANCE_ID : ' || p_instance_id
            WHERE
                    trackingid = p_trackingid
                AND status = 'N';

        END;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            FOR i IN 1..SQL%bulk_exceptions.count LOOP
                errmsg := NULL;
                errcode := NULL;
                errindx := NULL;
                lcount := lcount + 1;
                errmsg := sqlerrm(-SQL%bulk_exceptions(i).error_code);
                errcode := -SQL%bulk_exceptions(i).error_code;
                errindx := SQL%bulk_exceptions(i).error_index;
                INSERT INTO fusionintegration.oss_accountusage_core_error (
                    record_id,
                    run_date_time,
                    interface_id,
                    interface_name,
                    instance_id,
                    s3trackingid,
                    s3usageid,
                    status,
                    error_code,
                    error_message,
                    error_details
                ) VALUES (
                    p_usage_data_rec(errindx).record_id,
                    p_run_date,
                    p_interface_id,
                    p_interface_name,
                    p_instance_id,
                    p_trackingid,
                    p_usage_data_rec(errindx).usageid,
                    'E',
                    errcode,
                    errmsg,
                    'Duplicate values exists in FUSIONINTEGRATION.OSS_ACCOUNTUSAGE_CORE_STG table for USAGEID ' || p_usage_data_rec(
                    errindx).usageid
                );

            END LOOP;

           /* BEGIN
                UPDATE fusionintegration.oss_stitch_payload_stg
                SET
                    status = 'E',
                    message = errmsg
                              || '.Please refer table OSS_ACCOUNTUSAGE_CORE_ERROR for INSTANCE_ID : '
                              || p_instance_id
                WHERE
                        trackingid = p_trackingid
               -- and message IS NULL
                    AND status = 'N';

            END; */

            IF ( p_usage_data_rec.count = SQL%bulk_exceptions.count ) THEN
                BEGIN
                    UPDATE fusionintegration.oss_stitch_payload_stg
                    SET
                        status = 'E',
                        message = errmsg
                                  || '.Please refer table OSS_ACCOUNTUSAGE_CORE_ERROR for INSTANCE_ID : '
                                  || p_instance_id
                    WHERE
                            trackingid = p_trackingid
               -- and message IS NULL
                        AND status = 'N';

                END;

            ELSE
                BEGIN
                    UPDATE fusionintegration.oss_stitch_payload_stg
                    SET
                        status = 'W',
                        message = errmsg
                                  || '.Please refer table OSS_ACCOUNTUSAGE_CORE_ERROR for INSTANCE_ID : '
                                  || p_instance_id
                    WHERE
                            trackingid = p_trackingid
               -- and message IS NULL
                        AND status = 'N';

                END;
            END IF;

            COMMIT;
    END insert_usagedata;

    PROCEDURE update_records (
        p_schedule_instance_id IN VARCHAR2
    ) IS
    BEGIN
        IF p_schedule_instance_id IS NOT NULL THEN
            BEGIN
                UPDATE oss_accountusage_core_stg stg
                SET
                    stg.schedule_instance_id = p_schedule_instance_id,
                    stg.process_flag =
                        CASE
                            WHEN (
                                SELECT
                                    COUNT(*)
                                FROM
                                    oss_report_response_stg
                                WHERE
                                        usagedate = regexp_substr(stg.usagedate, '[^(T)]+')
                                    AND dsaccount = stg.dsaccountid
                                    AND uom = stg.uom
                            ) > 0  THEN
                                'P'
                            WHEN (
                                SELECT
                                    COUNT(*)
                                FROM
                                    oss_report_response_stg
                                WHERE
                                        usagedate = regexp_substr(stg.usagedate, '[^(T)]+')
                                    AND dsaccount = stg.dsaccountid
                                    AND uom = stg.uom
                            ) < 1  THEN
                                'E'
                            WHEN (
                                SELECT
                                    COUNT(1)
                                FROM
                                    (
                                        SELECT DISTINCT
                                            subscription_number
                                        FROM
                                            oss_report_response_stg
                                        WHERE
                                                dsaccount = stg.dsaccountid
                                            AND uom = stg.uom
                                    )
                            ) > 1  THEN
                                'E'
                        END,
                    message =
                        CASE
                            WHEN (
                                SELECT
                                    COUNT(*)
                                FROM
                                    oss_report_response_stg
                                WHERE
                                        usagedate = regexp_substr(stg.usagedate, '[^(T)]+')
                                    AND dsaccount = stg.dsaccountid
                                    AND uom = stg.uom
                            ) > 0  THEN
                                'Processed'
                            WHEN (
                                SELECT
                                    COUNT(*)
                                FROM
                                    oss_report_response_stg
                                WHERE
                                        usagedate = regexp_substr(stg.usagedate, '[^(T)]+')
                                    AND dsaccount = stg.dsaccountid
                                    AND uom = stg.uom
                            ) < 1  THEN
                                'No Subscription Found'
                            WHEN (
                                SELECT
                                    COUNT(1)
                                FROM
                                    (
                                        SELECT DISTINCT
                                            subscription_number
                                        FROM
                                            oss_report_response_stg
                                        WHERE
                                                dsaccount = stg.dsaccountid
                                            AND uom = stg.uom
                                    )
                            ) > 1  THEN
                                'More than one subscription found'
                        END
                WHERE
                    stg.process_flag <> 'P';

                COMMIT;
            END;

            BEGIN
                UPDATE oss_report_response_stg res
                SET
                    res.quantity = (
                        SELECT
                            SUM(quantity)
                        FROM
                            oss_accountusage_core_stg
                        WHERE
                                process_flag = 'P'
                            AND dsaccountid = res.dsaccount
                            AND uom = res.uom
                            AND regexp_substr(usagedate, '[^(T)]+') = res.usagedate
                    );

                COMMIT;
            END;

        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END update_records;

    PROCEDURE update_success_records (
        p_schedule_instance_id  IN  VARCHAR2,
        p_message               IN  VARCHAR2,
        p_dsaccountid           IN  VARCHAR2,
        p_uom                   IN  VARCHAR2,
        p_usagedate             IN  VARCHAR2
    ) IS
    BEGIN
        BEGIN
            UPDATE fusionintegration.oss_accountusage_core_stg
            SET
                schedule_instance_id = p_schedule_instance_id,
                process_flag = 'P',
                message = p_message
            WHERE
                    process_flag <> 'E'
                AND dsaccountid = p_dsaccountid
                AND uom = p_uom
                AND usagedate LIKE '%'
                                   || p_usagedate
                                   || '%';

            COMMIT;
        END;

        BEGIN
            UPDATE fusionintegration.oss_report_response_stg
            SET
                status = 'P'
            WHERE
                    status <> 'P'
                AND dsaccount = p_dsaccountid
                AND uom = p_uom
                AND usagedate = p_usagedate;

            COMMIT;
        END;

    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END update_success_records;

END ds_oss_account_usg_pkg;