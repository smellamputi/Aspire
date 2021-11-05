create or replace PACKAGE BODY                   cif_common_package AS 
--g_instance_id Varchar2(20000);

/********************************************************************
 Procedure: Insert_error_log_message
 Description: This Procedure is used to insert the log messages to CIF_LOG_MESSAGES_TBL table from OIC Integration.
********************************************************************/ 
/*PROCEDURE insert_error_log_message (
    p_instance_id        IN   NUMBER,
    p_sequence_number    IN   NUMBER,
    p_run_date           IN   DATE,
    p_message_severity   IN   VARCHAR2,
    p_message            IN   VARCHAR2,
    p_attribute1         IN   VARCHAR2,
    p_attribute2         IN   VARCHAR2,
    p_attribute3         IN   VARCHAR2,
    p_attribute4         IN   VARCHAR2,
    p_attribute5         IN   VARCHAR2,
    p_attribute6         IN   VARCHAR2,
    p_attribute7         IN   VARCHAR2,
    p_attribute8         IN   VARCHAR2,
    p_attribute9         IN   VARCHAR2,
    p_attribute10        IN   VARCHAR2,
    p_attribute11        IN   VARCHAR2,
    p_attribute12        IN   VARCHAR2,
    p_attribute13        IN   VARCHAR2,
    p_attribute14        IN   VARCHAR2,
    p_attribute15        IN   VARCHAR2
)*/

    PROCEDURE insert_error_log_message (
        p_instance_id         IN   NUMBER,
        p_interface_name      IN   VARCHAR2,
        p_interface_id        IN   VARCHAR2,
        p_run_date            IN   DATE,
        p_message_severity   IN VARCHAR2,
        p_scope_name          IN   VARCHAR2,
        p_status              IN   VARCHAR2,
        p_error_code          IN   VARCHAR2,
        p_error_message       IN   VARCHAR2,
        p_error_details       IN   VARCHAR2,
        p_attribute1          IN   VARCHAR2,
        p_attribute2          IN   VARCHAR2,
        p_attribute3          IN   VARCHAR2,
        p_attribute4          IN   VARCHAR2,
        p_attribute5          IN   VARCHAR2,
        p_attribute6          IN   VARCHAR2,
        p_attribute7          IN   VARCHAR2,
        p_attribute8          IN   VARCHAR2,
        p_attribute9          IN   VARCHAR2,
        p_attribute10         IN   VARCHAR2,
        p_attribute11         IN   VARCHAR2,
        p_attribute12         IN   VARCHAR2,
        p_attribute13         IN   VARCHAR2,
        p_attribute14         IN   VARCHAR2,
        p_attribute15         IN   VARCHAR2,
        p_attribute16         IN   VARCHAR2,
        p_attribute17         IN   VARCHAR2,
        p_attribute18         IN   VARCHAR2,
        p_attribute19         IN   VARCHAR2,
        p_attribute20         IN   VARCHAR2,
        p_attribute21         IN   VARCHAR2,
        p_attribute22         IN   VARCHAR2,
        p_attribute23         IN   VARCHAR2,
        p_attribute24         IN   VARCHAR2,
        p_attribute25         IN   VARCHAR2,
        p_attribute26         IN   VARCHAR2,
        p_attribute27         IN   VARCHAR2,
        p_attribute28         IN   VARCHAR2,
        p_attribute29         IN   VARCHAR2,
        p_attribute30         IN   VARCHAR2,
        p_last_updated_date   IN   DATE,
        p_last_update_by      IN   NUMBER,
        p_last_login_by       IN   NUMBER,
        p_created_by          IN   NUMBER,
        p_created_date        IN   DATE
    ) AS 
   /* CURSOR get_sequence_number IS 
      SELECT Max (sequence_number) 
      FROM   CIF_LOG_MESSAGES_TBL 
      WHERE  instance_id = p_instance_id; */ --Commented as a part of CIF_Common_Package Enhancement to improve performance
        l_sequence_number NUMBER; 

  /*  cursor c1 is
    select integration_name,attribute1 from
    CIF_PROCESS_INSTANCE_TBL where instance_id=p_instance_id; */ --Commented as a part of CIF_Common_Package Enhancement to improve performance

   -- l_rec c1%rowtype; --Commented as a part of CIF_Common_Package Enhancement to improve performance
    BEGIN 
     /*   OPEN get_sequence_number; 

      FETCH get_sequence_number INTO l_sequence_number; 

      CLOSE get_sequence_number; */ --Commented as a part of CIF_Common_Package Enhancement to improve performance
        BEGIN --Added as a part of CIF_Common_Package Enhancement to improve performance
            SELECT
                MAX(sequence_number)
            INTO l_sequence_number
            FROM
                cif_log_messages_tbl
            WHERE
                instance_id = p_instance_id;

        EXCEPTION
            WHEN OTHERS THEN
                l_sequence_number := 0;
        END;

        dbms_output.put_line('Before CIF_LOG_MESSAGES_TBL insert');
      /*INSERT INTO CIF_LOG_MESSAGES_TBL 
                  (instance_id, 
                   sequence_number, 
                   run_date, 
                   message_severity, 
                   message, 
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
                   attribute15) 
      VALUES      ( p_instance_id, 
                   NVL(l_sequence_number,0)+ 1, 
                   p_run_date, 
                   p_message_severity, 
                   p_message, 
                   p_attribute1, 
                   p_attribute2, 
                   p_attribute3, 
                   p_attribute4, 
                   p_attribute5, 
                   p_attribute6, 
                   p_attribute7, 
                   p_attribute8, 
                   p_attribute9, 
                   p_attribute10, 
                   p_attribute11, 
                   p_attribute12, 
                   p_attribute13, 
                   p_attribute14, 
                   p_attribute15 ); */
        INSERT INTO cif_log_messages_tbl (
            instance_id,
            interface_name,
            interface_id,
            sequence_number,
            run_date,
            message_severity,
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
            p_instance_id,
            p_interface_name,
            p_interface_id,
            nvl(l_sequence_number, 0) + 1,
            p_run_date,
            p_message_severity,
            p_scope_name,
            p_status,
            --p_error_code,
            SUBSTR(p_error_code, 1, 60),
            p_error_message,
            p_error_details,
            p_attribute1,
            p_attribute2,
            p_attribute3,
            p_attribute4,
            p_attribute5,
            p_attribute6,
            p_attribute7,
            p_attribute8,
            p_attribute9,
            p_attribute10,
            p_attribute11,
            p_attribute12,
            p_attribute13,
            p_attribute14,
            p_attribute15,
            p_attribute16,
            p_attribute17,
            p_attribute18,
            p_attribute19,
            p_attribute20,
            p_attribute21,
            p_attribute22,
            p_attribute23,
            p_attribute24,
            p_attribute25,
            p_attribute26,
            p_attribute27,
            p_attribute28,
            p_attribute29,
            p_attribute30,
            p_last_updated_date,
            p_last_update_by,
            p_last_login_by,
            p_created_by,
            p_created_date
        );

        dbms_output.put_line('Before CIF_LOG_MESSAGES_TBL after');

                 /* if(UPPER(p_message_severity) = 'ERROR') then
                      open c1;
                      fetch c1 into l_rec;
                      close c1;
                   end if;*/ --Commented as a part of CIF_Common_Package Enhancement to improve performance
    EXCEPTION
        WHEN OTHERS THEN
           /* INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                message_severity,
                message
            ) VALUES (
                p_instance_id,
                nvl(l_sequence_number, 0) + 1,
                p_run_date,
                'Error',
                'Error while inserting record into CIF_LOG_MESSAGES_TBL - '
                || sys.standard.sqlcode
                || ' : '
                || sys.standard.sqlerrm
            ); */
            INSERT INTO cif_log_messages_tbl (
                instance_id,
                interface_name,
                interface_id,
                sequence_number,
                run_date,
                message_severity,
                status,
                error_code,
                error_message,
                error_details
            ) VALUES (
                p_instance_id,
                p_interface_name,
                p_interface_id,
                nvl(l_sequence_number, 0) + 1,
                p_run_date,
                p_message_severity,
                'E',
                sys.standard.sqlcode,
                sys.standard.sqlerrm,
                'Error while inserting record into CIF_LOG_MESSAGES_TBL - '
                || sys.standard.sqlcode
                || ' : '
                || sys.standard.sqlerrm
            );

    END insert_error_log_message; 

/********************************************************************
 Procedure: Insert_process_file_details
 Description: This Procedure is used to insert the file details in CIF_PROCESS_FILE_DETAILS_TBL table for each OIC Integration.
********************************************************************/

    PROCEDURE insert_process_file_details (
        p_instance_id                    IN   NUMBER,
        p_file_name                      IN   VARCHAR2,
        p_file_size                      IN   VARCHAR2,
        p_file_row_count                 IN   NUMBER,
        p_load_row_count                 IN   NUMBER,
        p_load_date_time                 IN   DATE,
        p_load_status                    IN   VARCHAR2,
        p_validation_failure_row_count   IN   NUMBER,
        p_validation_status              IN   VARCHAR2,
        p_validation_date_time           IN   DATE,
        p_attribute1                     IN   VARCHAR2,
        p_attribute2                     IN   VARCHAR2,
        p_attribute3                     IN   VARCHAR2,
        p_attribute4                     IN   VARCHAR2,
        p_attribute5                     IN   VARCHAR2,
        p_attribute6                     IN   VARCHAR2,
        p_attribute7                     IN   VARCHAR2,
        p_attribute8                     IN   VARCHAR2,
        p_attribute9                     IN   VARCHAR2,
        p_attribute10                    IN   VARCHAR2,
        p_attribute11                    IN   VARCHAR2,
        p_attribute12                    IN   VARCHAR2,
        p_attribute13                    IN   VARCHAR2,
        p_attribute14                    IN   VARCHAR2,
        p_attribute15                    IN   VARCHAR2
    ) AS 
 /*   CURSOR get_sequence_number IS 
      SELECT Max (sequence_number) 
      FROM   CIF_LOG_MESSAGES_TBL 
      WHERE  instance_id = p_instance_id; */ --Commented as a part of CIF_Common_Package Enhancement to improve performance
        l_sequence_number NUMBER;
    BEGIN 
   /*   OPEN get_sequence_number; 

      FETCH get_sequence_number INTO l_sequence_number; 

      CLOSE get_sequence_number; */ --Commented as a part of CIF_Common_Package Enhancement to improve performance
        BEGIN --Added as a part of CIF_Common_Package Enhancement to improve performance
            SELECT
                MAX(sequence_number)
            INTO l_sequence_number
            FROM
                cif_log_messages_tbl
            WHERE
                instance_id = p_instance_id;

        EXCEPTION
            WHEN OTHERS THEN
                l_sequence_number := 0;
        END;

        INSERT INTO cif_process_file_details_tbl (
            instance_id,
            file_name,
            file_size,
            file_row_count,
            load_row_count,
            load_date_time,
            load_status,
            validation_failure_row_count,
            validation_status,
            validation_date_time,
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
            attribute15
        ) VALUES (
            p_instance_id,
            p_file_name,
            p_file_size,
            p_file_row_count,
            p_load_row_count,
            p_load_date_time,
            p_load_status,
            p_validation_failure_row_count,
            p_validation_status,
            p_validation_date_time,
            p_attribute1,
            p_attribute2,
            p_attribute3,
            p_attribute4,
            p_attribute5,
            p_attribute6,
            p_attribute7,
            p_attribute8,
            p_attribute9,
            p_attribute10,
            p_attribute11,
            p_attribute12,
            p_attribute13,
            p_attribute14,
            p_attribute15
        );

    EXCEPTION
        WHEN OTHERS THEN
           /* INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                message_severity,
                message
            ) VALUES (
                p_instance_id,
                nvl(l_sequence_number, 0) + 1,
                SYSDATE,
                'Error',
                'Error while inserting record into CIF_PROCESS_FILE_DETAILS_TBL - '
                || sys.standard.sqlcode
                || ' : '
                || sys.standard.sqlerrm
            ); */
            INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                status,
                error_code,
                error_message,
                error_details
            ) VALUES (
                p_instance_id,
                nvl(l_sequence_number, 0) + 1,
                SYSDATE,
                'Error',
                sys.standard.sqlcode,
                sys.standard.sqlerrm,
                'Error while inserting record into CIF_PROCESS_FILE_DETAILS_TBL - '
                || sys.standard.sqlcode
                || ' : '
                || sys.standard.sqlerrm
            );

    END insert_process_file_details;

/********************************************************************
 Procedure: Update_process_file_details
 Description: This Procedure is used to update the file details in CIF_PROCESS_FILE_DETAILS_TBL table for each OIC Integration.
********************************************************************/

    PROCEDURE update_process_file_details (
        p_instance_id                    IN   NUMBER,
        p_file_name                      IN   VARCHAR2,
        p_file_size                      IN   VARCHAR2,
        p_file_row_count                 IN   NUMBER,
        p_load_row_count                 IN   NUMBER,
        p_load_date_time                 IN   DATE,
        p_load_status                    IN   VARCHAR2,
        p_validation_failure_row_count   IN   NUMBER,
        p_validation_status              IN   VARCHAR2,
        p_validation_date_time           IN   DATE,
        p_attribute1                     IN   VARCHAR2,
        p_attribute2                     IN   VARCHAR2,
        p_attribute3                     IN   VARCHAR2,
        p_attribute4                     IN   VARCHAR2,
        p_attribute5                     IN   VARCHAR2,
        p_attribute6                     IN   VARCHAR2,
        p_attribute7                     IN   VARCHAR2,
        p_attribute8                     IN   VARCHAR2,
        p_attribute9                     IN   VARCHAR2,
        p_attribute10                    IN   VARCHAR2,
        p_attribute11                    IN   VARCHAR2,
        p_attribute12                    IN   VARCHAR2,
        p_attribute13                    IN   VARCHAR2,
        p_attribute14                    IN   VARCHAR2,
        p_attribute15                    IN   VARCHAR2
    ) AS 
 /*   CURSOR get_sequence_number IS 
      SELECT Max (sequence_number) 
      FROM   CIF_LOG_MESSAGES_TBL 
      WHERE  instance_id = p_instance_id; */ --Commented as a part of CIF_Common_Package Enhancement to improve performance
        l_sequence_number NUMBER;
    BEGIN 
     /* OPEN get_sequence_number; 
      FETCH get_sequence_number INTO l_sequence_number; 
      CLOSE get_sequence_number; */ --Commented as a part of CIF_Common_Package Enhancement to improve performance
        BEGIN --Added as a part of CIF_Common_Package Enhancement to improve performance
            SELECT
                MAX(sequence_number)
            INTO l_sequence_number
            FROM
                cif_log_messages_tbl
            WHERE
                instance_id = p_instance_id;

        EXCEPTION
            WHEN OTHERS THEN
                l_sequence_number := 0;
        END;

        IF p_instance_id IS NOT NULL AND p_file_name IS NOT NULL THEN
            UPDATE cif_process_file_details_tbl
            SET
                load_row_count = nvl(p_load_row_count, load_row_count),
                load_date_time = nvl(p_load_date_time, load_date_time),
                load_status = nvl(p_load_status, load_status),
                validation_failure_row_count = nvl(p_validation_failure_row_count, validation_failure_row_count),
                validation_status = nvl(p_validation_status, validation_status),
                validation_date_time = nvl(p_validation_date_time, validation_date_time),
                attribute1 = nvl(p_attribute1, attribute1),
                attribute2 = nvl(p_attribute2, attribute2),
                attribute3 = nvl(p_attribute3, attribute3),
                attribute4 = nvl(p_attribute4, attribute4),
                attribute5 = nvl(p_attribute5, attribute5),
                attribute6 = nvl(p_attribute6, attribute6),
                attribute7 = nvl(p_attribute7, attribute7),
                attribute8 = nvl(p_attribute8, attribute8),
                attribute9 = nvl(p_attribute9, attribute9),
                attribute10 = nvl(p_attribute10, attribute10),
                attribute11 = nvl(p_attribute11, attribute11),
                attribute12 = nvl(p_attribute12, attribute12),
                attribute13 = nvl(p_attribute13, attribute13),
                attribute14 = nvl(p_attribute14, attribute14),
                attribute15 = nvl(p_attribute15, attribute15)
            WHERE
                instance_id = p_instance_id
                AND file_name = p_file_name;

        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            /*INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                message_severity,
                message
            ) VALUES (
                p_instance_id,
                nvl(l_sequence_number, 0) + 1,
                SYSDATE,
                'Error',
                'Error while updating record in CIF_PROCESS_FILE_DETAILS_TBL - '
                || sys.standard.sqlcode
                || ' : '
                || sys.standard.sqlerrm
            );*/
            INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                status,
                error_code,
                error_message,
                error_details
            ) VALUES (
                p_instance_id,
                nvl(l_sequence_number, 0) + 1,
                SYSDATE,
                'Error',
                sys.standard.sqlcode,
                sys.standard.sqlerrm,
                'Error while inserting record into CIF_PROCESS_FILE_DETAILS_TBL - '
                || sys.standard.sqlcode
                || ' : '
                || sys.standard.sqlerrm
            );

    END update_process_file_details;

/********************************************************************
 Procedure: Insert_process_instance_old
 Description: This Procedure is used to insert the Integration details in CIF_PROCESS_INSTANCE_TBL table for each OIC Integration.
********************************************************************/

    PROCEDURE insert_process_instance_old (
        p_instance_id           IN   NUMBER,
        p_integration_name      IN   VARCHAR2,
        p_integration_pattern   IN   VARCHAR2,
        p_run_date              IN   DATE,
        p_start_time            IN   DATE,
        p_end_time              IN   DATE,
        p_status_time           IN   DATE,
        p_status                IN   VARCHAR2,
        p_attribute1            IN   VARCHAR2,
        p_attribute2            IN   VARCHAR2,
        p_attribute3            IN   VARCHAR2,
        p_attribute4            IN   VARCHAR2,
        p_attribute5            IN   VARCHAR2,
        p_attribute6            IN   VARCHAR2,
        p_attribute7            IN   VARCHAR2,
        p_attribute8            IN   VARCHAR2,
        p_attribute9            IN   VARCHAR2,
        p_attribute10           IN   VARCHAR2,
        p_attribute11           IN   VARCHAR2,
        p_attribute12           IN   VARCHAR2,
        p_attribute13           IN   VARCHAR2,
        p_attribute14           IN   VARCHAR2,
        p_attribute15           IN   VARCHAR2
    ) AS 
    /* CURSOR get_sequence_number IS 
      SELECT Max (sequence_number) 
      FROM   CIF_LOG_MESSAGES_TBL 
      WHERE  instance_id = p_instance_id; */ --Commented as a part of CIF_Common_Package Enhancement to improve performance
        l_sequence_number NUMBER;
    BEGIN 
     /* OPEN get_sequence_number; 

      FETCH get_sequence_number INTO l_sequence_number; 

      CLOSE get_sequence_number; */ --Commented as a part of CIF_Common_Package Enhancement to improve performance
        BEGIN --Added as a part of CIF_Common_Package Enhancement to improve performance
            SELECT
                MAX(sequence_number)
            INTO l_sequence_number
            FROM
                cif_log_messages_tbl
            WHERE
                instance_id = p_instance_id;

        EXCEPTION
            WHEN OTHERS THEN
                l_sequence_number := 0;
        END;

        INSERT INTO cif_process_instance_tbl (
            instance_id,
            integration_name,
            integration_pattern,
            run_date,
            start_time,
            end_time,
            status_time,
            status,
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
            attribute15
        ) VALUES (
            p_instance_id,
            p_integration_name,
            p_integration_pattern,
            p_run_date,
            p_start_time,
            p_end_time,
            p_status_time,
            p_status,
            p_attribute1,
            p_attribute2,
            p_attribute3,
            p_attribute4,
            p_attribute5,
            p_attribute6,
            p_attribute7,
            p_attribute8,
            p_attribute9,
            p_attribute10,
            p_attribute11,
            p_attribute12,
            p_attribute13,
            p_attribute14,
            p_attribute15
        );

        insert_process_run_details(p_instance_id, p_integration_name, p_run_date, p_status);
    EXCEPTION
        WHEN OTHERS THEN
            /*INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                message_severity,
                message
            ) VALUES (
                p_instance_id,
                nvl(l_sequence_number, 0) + 1,
                p_run_date,
                'Error',
                'Error while inserting record into CIF_PROCESS_INSTANCE_TBL - '
                || sys.standard.sqlcode
                || ' : '
                || sys.standard.sqlerrm
            );*/
            INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                status,
                error_code,
                error_message,
                error_details
            ) VALUES (
                p_instance_id,
                nvl(l_sequence_number, 0) + 1,
                p_run_date,
                'Error',
                sys.standard.sqlcode,
                sys.standard.sqlerrm,
                'Error while inserting record into CIF_PROCESS_INSTANCE_TBL - '
                || sys.standard.sqlcode
                || ' : '
                || sys.standard.sqlerrm
            );

    END insert_process_instance_old; 

/********************************************************************
 Procedure: Insert_process_instance
 Description: This Procedure is used to insert the Integration details in CIF_PROCESS_INSTANCE_TBL table for each OIC Integration.
********************************************************************/   
--//Doubt//

    PROCEDURE insert_process_instance (
        p_oic_instance_id       IN    NUMBER,
        p_interface_id          IN VARCHAR2,
        p_integration_name      IN    VARCHAR2,
        p_integration_pattern   IN    VARCHAR2,
        p_run_date              IN    DATE,
        p_scope_name            IN    VARCHAR2,
        p_start_time            IN    DATE,
        p_end_time              IN    DATE,
        p_status_time           IN    DATE,
        p_status                IN    VARCHAR2,
        p_attribute1            IN    VARCHAR2,
        p_attribute2            IN    VARCHAR2,
        p_attribute3            IN    VARCHAR2,
        p_attribute4            IN    VARCHAR2,
        p_attribute5            IN    VARCHAR2,
        p_attribute6            IN    VARCHAR2,
        p_attribute7            IN    VARCHAR2,
        p_attribute8            IN    VARCHAR2,
        p_attribute9            IN    VARCHAR2,
        p_attribute10           IN    VARCHAR2,
        p_attribute11           IN    VARCHAR2,
        p_attribute12           IN    VARCHAR2,
        p_attribute13           IN    VARCHAR2,
        p_attribute14           IN    VARCHAR2,
        p_attribute15           IN    VARCHAR2,
        p_instance_id           OUT   NUMBER
    ) AS 
  /*  CURSOR get_sequence_number IS 
      SELECT Max (sequence_number) 
      FROM   CIF_LOG_MESSAGES_TBL 
      WHERE  instance_id = p_instance_id; */ --Commented as a part of CIF_Common_Package Enhancement to improve performance
        l_sequence_number NUMBER; 
        l_insert_count NUMBER;
   -- l_instance_id     NUMBER; --Commented as a part of CIF_Common_Package Enhancement to improve performance
    BEGIN 
   /*   SELECT CIF_AIC_INSTANCE_SEQ.NEXTVAL 
      INTO   l_instance_id 
      FROM   dual;

      p_instance_id := l_instance_id;   */ --Commented as a part of CIF_Common_Package Enhancement to improve performance
        BEGIN --Added as a part of CIF_Common_Package Enhancement to improve performance
            SELECT
                MAX(sequence_number)
            INTO l_sequence_number
            FROM
                cif_log_messages_tbl
            WHERE
                instance_id = p_oic_instance_id;

        EXCEPTION
            WHEN OTHERS THEN
                l_sequence_number := 1;
        END;

        BEGIN --Added as a part of CIF_Common_Package Enhancement to improve performance
            /*INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                message_severity,
                message
            ) VALUES (
                p_aic_instance_id,
                1,
                p_run_date,
                'INFO',
                'Start Integration Run - ' || p_integration_name
            );*/
            
            INSERT INTO cif_log_messages_tbl (
                 instance_id,
                 interface_id,
                 interface_name,
                sequence_number,
                run_date,
                message_severity,
                scope_name,
                attribute1  -- process description
                
            ) VALUES (
                p_oic_instance_id,
                p_interface_id,
                p_integration_name,
                nvl(l_sequence_number, 0) + 1,
                p_run_date,
                'INFO',
                p_scope_name,
                p_integration_name || ' process logged for - '|| p_scope_name
               
            );
            COMMIT ;

        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;

      --OPEN get_sequence_number; 
      --FETCH get_sequence_number INTO l_sequence_number; 
      --CLOSE get_sequence_number; 
      --p_instance_id := l_sequence_number ; 
        BEGIN
        SELECT
                COUNT(1)
            INTO l_insert_count
            FROM
                cif_process_instance_tbl
            WHERE
                instance_id = p_oic_instance_id
                AND integration_name = p_integration_name
                AND integration_pattern = p_integration_pattern ;
        END;
         IF (l_insert_count = 0) THEN
        
        BEGIN
        INSERT INTO cif_process_instance_tbl (
            instance_id,
            integration_name,
            integration_pattern,
            run_date,
            start_time,
            end_time,
            status_time,
            status,
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
            aic_instance_id
        ) VALUES ( --l_instance_id, 
            p_oic_instance_id,
            p_integration_name,
            p_integration_pattern,
            p_run_date,
            p_start_time,
            p_end_time,
            p_status_time,
            p_status,
            p_attribute1,
            p_attribute2,
            p_attribute3,
            p_attribute4,
            p_attribute5,
            p_attribute6,
            p_attribute7,
            p_attribute8,
            p_attribute9,
            p_attribute10,
            p_attribute11,
            p_attribute12,
            p_attribute13,
            p_attribute14,
            p_attribute15,
            p_oic_instance_id
        );
        COMMIT;
        END ;
        ELSE
        NULL;
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
           /* INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                message_severity,
                message
            ) VALUES     -- ( Nvl (p_instance_id, p_aic_instance_id), --Commented as a part of CIF_Common_Package Enhancement to improve performance
             (
                p_aic_instance_id, --Added as a part of CIF_Common_Package Enhancement to improve performance
                nvl(l_sequence_number, 0) + 1,
                p_run_date,
                'Error',
                'Error while inserting record into CIF_PROCESS_INSTANCE_TBL - '
                || sys.standard.sqlcode
                || ' : '
                || sys.standard.sqlerrm
            );*/
            INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                message_severity,
                status,
                error_code,
                error_message,
                error_details
            ) VALUES (
                p_oic_instance_id,
                nvl(l_sequence_number, 0) + 1,
                p_run_date,
                'ERROR',
                'E',
                sys.standard.sqlcode,
                sys.standard.sqlerrm,
                'Error while inserting record into CIF_PROCESS_INSTANCE_TBL - '
                || sys.standard.sqlcode
                || ' : '
                || sys.standard.sqlerrm
            );

    END insert_process_instance; 

/********************************************************************
 Procedure: Update_process_instance
 Description: This Procedure is used to update the Integration details in CIF_PROCESS_INSTANCE_TBL table for each OIC Integration.
********************************************************************/

    PROCEDURE update_process_instance (
        p_instance_id   IN   NUMBER,
        p_end_time      IN   DATE,
        p_status_time   IN   DATE,
        p_status        IN   VARCHAR2,
        p_attribute1    IN   VARCHAR2,
        p_attribute2    IN   VARCHAR2,
        p_attribute3    IN   VARCHAR2,
        p_attribute4    IN   VARCHAR2,
        p_attribute5    IN   VARCHAR2,
        p_attribute6    IN   VARCHAR2,
        p_attribute7    IN   VARCHAR2,
        p_attribute8    IN   VARCHAR2,
        p_attribute9    IN   VARCHAR2,
        p_attribute10   IN   VARCHAR2,
        p_attribute11   IN   VARCHAR2,
        p_attribute12   IN   VARCHAR2,
        p_attribute13   IN   VARCHAR2,
        p_attribute14   IN   VARCHAR2,
        p_attribute15   IN   VARCHAR2
    ) AS 
  /* CURSOR get_sequence_number IS 
      SELECT Max (sequence_number) 
      FROM   CIF_LOG_MESSAGES_TBL 
      WHERE  instance_id = p_instance_id; */ --Commented as a part of CIF_Common_Package Enhancement to improve performance
        l_sequence_number NUMBER;
    BEGIN 
   /*   OPEN get_sequence_number; 

      FETCH get_sequence_number INTO l_sequence_number; 

      CLOSE get_sequence_number; */ --Commented as a part of CIF_Common_Package Enhancement to improve performance
        BEGIN --Added as a part of CIF_Common_Package Enhancement to improve performance
            SELECT
                MAX(sequence_number)
            INTO l_sequence_number
            FROM
                cif_log_messages_tbl
            WHERE
                instance_id = p_instance_id;

        EXCEPTION
            WHEN OTHERS THEN
                l_sequence_number := 0;
        END;

        IF p_instance_id IS NOT NULL THEN
            UPDATE cif_process_instance_tbl
            SET
                end_time = nvl(p_end_time, end_time),
                status_time = nvl(p_status_time, status_time),
                status = DECODE(upper(status), 'ERROR', 'ERROR', nvl(p_status, status)),
                attribute1 = nvl(p_attribute1, attribute1),
                attribute2 = nvl(p_attribute2, attribute2),
                attribute3 = nvl(p_attribute3, attribute3),
                attribute4 = nvl(p_attribute4, attribute4),
                attribute5 = nvl(p_attribute5, attribute5),
                attribute6 = nvl(p_attribute6, attribute6),
                attribute7 = nvl(p_attribute7, attribute7),
                attribute8 = nvl(p_attribute8, attribute8),
                attribute9 = nvl(p_attribute9, attribute9),
                attribute10 = nvl(p_attribute10, attribute10),
                attribute11 = nvl(p_attribute11, attribute11),
                attribute12 = nvl(p_attribute12, attribute12),
                attribute13 = nvl(p_attribute13, attribute13),
                attribute14 = nvl(p_attribute14, attribute14),
                attribute15 = nvl(p_attribute15, attribute15)
            WHERE
                instance_id = p_instance_id;

            BEGIN --Anonymous Block Added as a part of CIF_Common_Package Enhancement to improve performance
                update_process_run_details(p_instance_id => p_instance_id, p_integration_name => NULL, p_last_run_date => NULL, p_status
                => p_status);

            EXCEPTION
                WHEN OTHERS THEN
                   /* INSERT INTO cif_log_messages_tbl (
                        instance_id,
                        sequence_number,
                        run_date,
                        message_severity,
                        message
                    ) VALUES (
                        p_instance_id,
                        nvl(l_sequence_number, 0) + 1,
                        p_end_time,
                        'Error',
                        'Error while updating record in Update_process_run_details - '
                        || sys.standard.sqlcode
                        || ' : '
                        || sys.standard.sqlerrm
                    );*/
                    INSERT INTO cif_log_messages_tbl (
                        instance_id,
                        sequence_number,
                        run_date,
                        status,
                        error_code,
                        error_message,
                        error_details
                    ) VALUES (
                        p_instance_id,
                        l_sequence_number + 1,
                        p_end_time,
                        'Error',
                        sys.standard.sqlcode,
                        sys.standard.sqlerrm,
                        'Error while updating record into Update_process_run_details - '
                        || sys.standard.sqlcode
                        || ' : '
                        || sys.standard.sqlerrm
                    );

            END;

        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            /*INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                message_severity,
                message
            ) VALUES (
                p_instance_id, 
                            --Nvl ( l_sequence_number, 0 ) + 1, --Commented as a part of CIF_Common_Package Enhancement to improve performance
                l_sequence_number + 1, --Added as a part of CIF_Common_Package Enhancement to improve performance 
                p_end_time,
                'Error',
                'Error while updating record in CIF_PROCESS_INSTANCE_TBL - '
                || sys.standard.sqlcode
                || ' : '
                || sys.standard.sqlerrm
            );*/
            INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                status,
                error_code,
                error_message,
                error_details
            ) VALUES (
                p_instance_id,
                l_sequence_number + 1,
                p_end_time,
                'Error',
                sys.standard.sqlcode,
                sys.standard.sqlerrm,
                'Error while updating record into Update_process_run_details - '
                || sys.standard.sqlcode
                || ' : '
                || sys.standard.sqlerrm
            );

    END update_process_instance;  

/********************************************************************
 Procedure: Insert_process_run_details
 Description: This Procedure is used to insert the process details in CIF_PROCESS_RUN_DETAILS_TBL table for each OIC Integration.
********************************************************************/

    PROCEDURE insert_process_run_details (
        p_instance_id        IN   NUMBER,
        p_integration_name   IN   VARCHAR2,
        p_last_run_date      IN   DATE,
        p_status             IN   VARCHAR2
    ) AS 
  /*  CURSOR get_sequence_number IS 
      SELECT Max (sequence_number) 
      FROM   CIF_LOG_MESSAGES_TBL 
      WHERE  instance_id = p_instance_id; */ --Commented as a part of CIF_Common_Package Enhancement to improve performance
        l_sequence_number NUMBER;
    BEGIN 
    /*  OPEN get_sequence_number; 

      FETCH get_sequence_number INTO l_sequence_number; 

      CLOSE get_sequence_number; */ --Commented as a part of CIF_Common_Package Enhancement to improve performance
        BEGIN --Added as a part of CIF_Common_Package Enhancement to improve performance
            SELECT
                MAX(sequence_number)
            INTO l_sequence_number
            FROM
                cif_log_messages_tbl
            WHERE
                instance_id = p_instance_id;

        EXCEPTION
            WHEN OTHERS THEN
                l_sequence_number := 0;
        END;

        INSERT INTO cif_process_run_details_tbl (
            instance_id,
            integration_name,
            last_run_date,
            status
        ) VALUES (
            p_instance_id,
            p_integration_name,
            p_last_run_date,
            p_status
        );

    EXCEPTION
        WHEN OTHERS THEN
            /* INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                message_severity,
                message
            ) VALUES (
                p_instance_id,
                nvl(l_sequence_number, 0) + 1,
                p_last_run_date,
                'Error',
                'Error while inserting record into CIF_PROCESS_RUN_DETAILS_TBL - '
                || sys.standard.sqlcode
                || ' : '
                || sys.standard.sqlerrm
            );*/
            INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                status,
                error_code,
                error_message,
                error_details
            ) VALUES (
                p_instance_id,
                l_sequence_number + 1,
                p_last_run_date,
                'Error',
                sys.standard.sqlcode,
                sys.standard.sqlerrm,
                'Error while inserting record into CIF_PROCESS_RUN_DETAILS_TBL - '
                || sys.standard.sqlcode
                || ' : '
                || sys.standard.sqlerrm
            );

    END insert_process_run_details; 

/********************************************************************
 Procedure: Update_process_run_details
 Description: This Procedure is used to update the process details in CIF_PROCESS_RUN_DETAILS_TBL table for each OIC Integration.
********************************************************************/

    PROCEDURE update_process_run_details (
        p_instance_id        IN   NUMBER,
        p_integration_name   IN   VARCHAR2,
        p_last_run_date      IN   DATE,
        p_status             IN   VARCHAR2
    ) AS 
   /* CURSOR get_sequence_number IS 
      SELECT Max (sequence_number) 
      FROM   CIF_LOG_MESSAGES_TBL 
      WHERE  instance_id = p_instance_id; */ --Commented as a part of CIF_Common_Package Enhancement to improve performance
        l_sequence_number NUMBER;
    BEGIN 
    /*  OPEN get_sequence_number; 

      FETCH get_sequence_number INTO l_sequence_number; 

      CLOSE get_sequence_number; */ --Commented as a part of CIF_Common_Package Enhancement to improve performance
        BEGIN --Added as a part of CIF_Common_Package Enhancement to improve performance
            SELECT
                MAX(sequence_number)
            INTO l_sequence_number
            FROM
                cif_log_messages_tbl
            WHERE
                instance_id = p_instance_id;

        EXCEPTION
            WHEN OTHERS THEN
                l_sequence_number := 0;
        END;

        UPDATE cif_process_run_details_tbl
        SET
            integration_name = nvl(p_integration_name, integration_name),
            last_run_date = nvl(p_last_run_date, last_run_date),
            status = DECODE(upper(status), 'ERROR', 'ERROR', nvl(p_status, status))
        WHERE
            instance_id = p_instance_id;

    EXCEPTION
        WHEN OTHERS THEN
           /* INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                message_severity,
                message
            ) VALUES (
                p_instance_id,
                nvl(l_sequence_number, 0) + 1,
                p_last_run_date,
                'Error',
                'Error while updating record into CIF_PROCESS_RUN_DETAILS_TBL - '
                || sys.standard.sqlcode
                || ' : '
                || sys.standard.sqlerrm
            );*/
            INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                status,
                error_code,
                error_message,
                error_details
            ) VALUES (
                p_instance_id,
                nvl(l_sequence_number, 0) + 1,
                p_last_run_date,
                'Error',
                sys.standard.sqlcode,
                sys.standard.sqlerrm,
                'Error while updating record into CIF_PROCESS_RUN_DETAILS_TBL - '
                || sys.standard.sqlcode
                || ' : '
                || sys.standard.sqlerrm
            );

    END update_process_run_details; 

/********************************************************************
 Procedure: Generate_email_body
 Description: This Procedure is used to generate the email body as per values passed as input parameter.
********************************************************************/   
  /* PROCEDURE Generate_email_body (p_instance_id             IN NUMBER,  --Commented as a part of CIF_Common_Package Enhancement to improve performance
                                 p_integration_name        IN VARCHAR2, 
                                 p_integration_pattern     IN VARCHAR2, 
                                 p_run_date                IN DATE, 
                                 p_message_type            IN VARCHAR2, 
                                 p_stage                   IN VARCHAR2, 
                                 p_gbl_fault_error_code    IN VARCHAR2, 
                                 p_gbl_fault_error_reason  IN VARCHAR2, 
                                 p_gbl_fault_error_details IN VARCHAR2, 
                                 p_job_id                  IN VARCHAR2, 
                                 p_job_name                IN VARCHAR2, 
                                 x_email_body              OUT VARCHAR2) 
  IS 
    l_email_body     VARCHAR2 ( 32767 ); 
    l_file_name      VARCHAR2 ( 400 ); 
    l_line_separator VARCHAR2 ( 10 ) := '    '; 
    Parenr_Ins_Id NUMBER;
    l_instance_id varchar2(100);
    CURSOR get_ess_job_dtls IS 
      SELECT w.*, 
             f.file_name 
      FROM   CIF_JOB_HISTORY_TBL w, 
             CIF_PROCESS_FILE_DETAILS_TBL f 
      WHERE  1 = 1 --instance_id = p_instance_id 
             AND w.callback_id = p_instance_id--IS NOT NULL 
             AND w.job_id = f.attribute3(+) 
      ORDER  BY job_id; 

     CURSOR get_file_dtls(p_ins_id NUMBER) IS 
      SELECT f.file_name,f.attribute4
      FROM   CIF_PROCESS_FILE_DETAILS_TBL f 
      WHERE  1 = 1 
        AND f.instance_id = p_ins_id 
        AND to_number(f.attribute3) = (SELECT MAX(TO_NUMBER(T.attribute3)) FROM CIF_PROCESS_FILE_DETAILS_TBL T 
                                       WHERE T.INSTANCE_ID = f.instance_id);

       p_file_name varchar2(400) ; 
       p_source_name varchar2(100);
  BEGIN 
      l_email_body := NULL; 

      ---Outbound Integration

     IF (upper(p_integration_pattern) = 'OUTBOUND') THEN

      p_file_name := p_job_id;
      -- Add Greeting 
      l_email_body := l_email_body 
                      || 'Hi Team,' 
                      || l_line_separator 
                      || Chr (10); 

      l_email_body := l_email_body 
                      || l_line_separator 
                      || Chr (10); 

      -- Add message 
      IF Upper (p_message_type) = ( 'ERROR' ) THEN 
        IF Upper (p_stage) = 'LOOKUP' THEN 
          l_email_body := l_email_body 
                          || 
                'Few lookup values are not defined in OIC, please configure values and re-submit the process.' 
                || l_line_separator 
                || Chr (10); 
                ELSIF Upper (p_stage) = 'NOFILE' THEN 
                  l_email_body := l_email_body 
                                  || 
                'There are no files in PeopleSoft server to process, please place the files and re-submit the process.' 
                || l_line_separator 
                || Chr (10); 
                ELSIF Upper (p_stage) = 'NODATAFILE' THEN 
                  l_email_body := l_email_body 
                                  || 
                'There is no data to process, please place the valid file and re-submit the process.' 
                || l_line_separator 
                || Chr (10); 
                ELSIF Upper (p_stage) = 'DUPLICATE' THEN 
                 l_email_body := l_email_body 
                  || 'Duplicate File- File with the same name has already been processed earlier.' 
                  || l_line_separator 
                  || Chr (10); 
  l_email_body := l_email_body 
                  || 'Duplicate File : ' 
                  ||  p_job_name
                  || l_line_separator 
                  || Chr (10); 
  l_email_body := l_email_body 
                  || 'Duplicate File has been moved to : ' 
                  ||  p_job_id
                  || l_line_separator 
                  || Chr (10); 
ELSIF Upper (p_stage) = 'NODATA' THEN 
  l_email_body := l_email_body 
                  || 'BIP report did not generate any data for processing.' 
                  || l_line_separator 
                  || Chr (10); 
ELSIF Upper (p_stage) = 'NOFILEDATA' THEN 
  l_email_body := l_email_body 
                  || 'Blank File i.e. BI Ouput file is not having any data to process.'
                  || l_line_separator 
                  || Chr (10); 
ELSIF Upper (p_stage) = 'DBVALIDATION' THEN 
  l_email_body := l_email_body 
                  || 
  'Integration has validation errors, please verify and re-submit the process.' 
                  || l_line_separator 
                  || Chr (10); 
ELSIF Upper (p_stage) = 'FILEARCHIVE' THEN 
  l_email_body := l_email_body 
                  || 'File Archive failed, please verify the below process.' 
                  || l_line_separator 
                  || Chr (10); 
ELSIF Upper (p_stage) IN ( 'GLOBALFAULT', 'SCOPEFAULT' ) THEN 
  l_email_body := l_email_body 
                  || 
  'Unexpected error has been occurred in integration process.' 
                  || l_line_separator 
                  || Chr (10); 
END IF; 

ELSIF Upper (p_stage) = 'SUCCESSOUTBOUND' THEN 
  l_email_body := l_email_body 
                  || 
'Report run has completed successfully and file is placed in the FTP server.' 
|| l_line_separator 
|| Chr (10); 
END IF; 

-- Add parameters
IF upper(p_integration_pattern) <> 'OUTBOUND' THEN
l_instance_id := p_integration_pattern;
END IF;

IF p_instance_id IS NOT NULL THEN 
  l_email_body := l_email_body 
                  || Chr (10) 
                  || 'Instance ID : ' 
                  || Nvl(l_instance_id, p_instance_id) 
                  || l_line_separator 
                  || Chr (10); 
END IF;

IF p_integration_name IS NOT NULL THEN 
  l_email_body := l_email_body 
                  || 'Integration Name : ' 
                  || p_integration_name 
                  || l_line_separator 
                  || Chr (10); 
END IF; 

IF p_file_name IS NOT NULL THEN 
  l_email_body := l_email_body 
                  || 'Outbound File Name: ' 
                  || p_file_name 
                  || l_line_separator 
                  || Chr (10); 
END IF; 

IF p_job_name IS NOT NULL THEN 
  l_email_body := l_email_body 
                  || 'Outbound File Path: ' 
                  || p_job_name 
                  || l_line_separator 
                  || Chr (10); 
END IF; 

IF p_integration_pattern IS NOT NULL THEN 
   l_email_body := l_email_body 
                  || 'Integration Pattern : ' 
                  || p_integration_pattern 
                  || l_line_separator 
                  || Chr (10); 
END IF;

IF p_run_date IS NOT NULL THEN 
  l_email_body := l_email_body 
                  || 'Run Date : ' 
                  || To_char (p_run_date, 'DD-MON-YYYY HH:MI AM') 
                  || l_line_separator 
                  || Chr (10); 
END IF; 

IF p_gbl_fault_error_code IS NOT NULL THEN 
  l_email_body := l_email_body 
                  || 'Error Code : ' 
                  || p_gbl_fault_error_code 
                  || l_line_separator 
                  || Chr (10); 
END IF;

IF p_gbl_fault_error_reason IS NOT NULL THEN 
  l_email_body := l_email_body 
                  || 'Reason : ' 
                  || p_gbl_fault_error_reason 
                  || l_line_separator 
                  || Chr (10); 
END IF; 

IF p_gbl_fault_error_details IS NOT NULL THEN 
  l_email_body := l_email_body 
                  || 'Details : ' 
                  || p_gbl_fault_error_details 
                  || l_line_separator 
                  || Chr (10); 
END IF; 

l_email_body := l_email_body 
                || l_line_separator 
                || Chr (10); 

-- Add Signature 
l_email_body := l_email_body 
                || 'Thanks,' 
                || l_line_separator 
                || Chr (10) 
                || 'Administrator' 
                || l_line_separator 
                || Chr (10); 

l_email_body := l_email_body 
                || Chr (10); 

    ELSE
     --- Inbound Integration 
      IF(p_integration_name = 'AP GNFR Invoices to Oracle Cloud') THEN
		null;

      ELSE
        OPEN get_file_dtls(p_instance_id);
        FETCH get_file_dtls INTO p_file_name,p_source_name;
        END IF;
      CLOSE get_file_dtls;
      -- Add Greeting 
      l_email_body := l_email_body 
                      || 'Hi Team,' 
                      || l_line_separator 
                      || Chr (10); 

      l_email_body := l_email_body 
                      || l_line_separator 
                      || Chr (10); 

      -- Add message 
      IF Upper (p_message_type) = ( 'ERROR' ) THEN 
        IF Upper (p_stage) = 'LOOKUP' THEN 
          l_email_body := l_email_body 
                          || 
'Few lookup values are not defined in OIC, please configure values and re-submit the process.' 
|| l_line_separator 
|| Chr (10); 
ELSIF Upper (p_stage) = 'NOFILE' THEN 
  l_email_body := l_email_body 
                  || 
'There are no files in PeopleSoft server to process, please place the files and re-submit the process.' 
|| l_line_separator 
|| Chr (10); 
ELSIF Upper (p_stage) = 'DUPLICATE' THEN 
  l_email_body := l_email_body 
                  || 'Duplicate File- File with the same name has already been processed earlier.' 
                  || l_line_separator 
                  || Chr (10); 
  l_email_body := l_email_body 
                  || 'Duplicate File : ' 
                  ||  p_job_name
                  || l_line_separator 
                  || Chr (10); 
  l_email_body := l_email_body 
                  || 'Duplicate File has been moved to : ' 
                  ||  p_job_id
                  || l_line_separator 
                  || Chr (10); 
ELSIF Upper (p_stage) = 'NODATA' THEN 
  l_email_body := l_email_body 
                  || 'BIP report did not generate any data for processing.' 
                  || l_line_separator 
                  || Chr (10); 
ELSIF Upper (p_stage) = 'NOFILEDATA' THEN 
  l_email_body := l_email_body 
                  || 'Blank File i.e. Source file is not having any data to process.'
                  || l_line_separator 
                  || Chr (10); 
ELSIF Upper (p_stage) = 'COAEXCEPTION' THEN 
  l_email_body := l_email_body 
                  || 'Unexpected Exception in XWalk procedure call.' 
                  || l_line_separator 
                  || Chr (10); 
ELSIF Upper (p_stage) = 'HDL_REPORT' THEN 
  l_email_body := l_email_body 
                  || 'HDL has Import/Load Errors. Please check the logs for more details.' 
                  || l_line_separator 
                  || Chr (10); 
  l_email_body := l_email_body 
                  || 'Log has been moved to : ' 
                  ||  p_job_id
                  || l_line_separator 
                  || Chr (10);
ELSIF Upper (p_stage) = 'TIMEOUT' THEN 
  l_email_body := l_email_body 
                  || 'XWalk call got time out.' 
                  || l_line_separator 
                  || Chr (10);
ELSIF Upper (p_stage) = 'COAMAPPING' THEN 
  l_email_body := l_email_body 
                  || 'COA Mapping Error- File is not having valid COA (chart of account) segment values.' 
                  || l_line_separator 
                  || Chr (10); 
  l_email_body := l_email_body 
                  || 'File has been moved to : ' 
                  ||  p_job_id
                  || l_line_separator 
                  || Chr (10);
ELSIF Upper (p_stage) = 'DBVALIDATION' THEN 
  l_email_body := l_email_body 
                  || 
  'Integration has validation errors, please verify and re-submit the process.' 
                  || l_line_separator 
                  || Chr (10); 
ELSIF Upper (p_stage) = 'FILEARCHIVE' THEN 
  l_email_body := l_email_body 
                  || 'File Archive failed, please verify the below process.' 
                  || l_line_separator 
                  || Chr (10); 
ELSIF Upper (p_stage) = 'CALLBACK' THEN 
  l_email_body := l_email_body 
                  || 
'Fusion Ess Job has completed in error, please verify log/output of below Job ID for more details.'
|| l_line_separator 
|| Chr (10); 
ELSIF Upper (p_stage) IN ( 'GLOBALFAULT', 'SCOPEFAULT' ) THEN 
  l_email_body := l_email_body 
                  || 
  'Unexpected error has been occurred in integration process.' 
                  || l_line_separator 
                  || Chr (10); 
END IF; 
ELSIF Upper (p_message_type) IN ( 'SUCCESS', 'SUCCEEDED' ) THEN 
  IF Upper (p_stage) = 'ESSSUBMIT' THEN 
    l_email_body := l_email_body 
                    || 
'Fusion Load Ess Job has been successfully submitted, please find below job details.' 
|| l_line_separator 
|| Chr (10); 
ELSIF Upper (p_stage) = 'CALLBACK' THEN 
  l_email_body := l_email_body 
                  || 'The '||p_integration_name||' Inbound Integration has COMPLETED successfully in ERP Cloud.'
                  || l_line_separator 
                  || Chr (10); 
ELSIF Upper (p_stage) = 'REPORTRUN' THEN 
  l_email_body := l_email_body 
                  || 
'Report run has completed successfully and file is placed in the MFT folder.' 
|| l_line_separator 
|| Chr (10); 

ELSIF Upper (p_stage) = 'FUTURE_CHANGES' THEN 
  l_email_body := l_email_body 
                  || 
'Source file has future dated transactions.' 
|| l_line_separator 
|| Chr (10); 
END IF; 
END IF; 

-- Add parameters
IF p_integration_pattern <> 'Inbound' THEN
l_instance_id := p_integration_pattern;
END IF;

IF Upper(p_stage) = 'CALLBACK' THEN
l_instance_id := NULL;
END IF;

IF p_instance_id IS NOT NULL THEN 
  l_email_body := l_email_body 
                  || Chr (10) 
                  || 'Instance ID : ' 
                  || Nvl(l_instance_id, p_instance_id) 
                  || l_line_separator 
                  || Chr (10); 
END IF;

IF p_integration_name IS NOT NULL THEN 
  l_email_body := l_email_body 
                  || 'Integration Name : ' 
                  || p_integration_name 
                  || l_line_separator 
                  || Chr (10); 
END IF; 

IF p_source_name IS NOT NULL THEN 
  l_email_body := l_email_body 
                  || 'Source Name: ' 
                  || p_source_name 
                  || l_line_separator 
                  || Chr (10); 
END IF; 

IF p_file_name IS NOT NULL THEN 
  l_email_body := l_email_body 
                  || 'File Name: ' 
                  || p_file_name 
                  || l_line_separator 
                  || Chr (10); 
END IF; 

IF p_integration_pattern IS NOT NULL THEN 
  IF Upper(p_stage) = 'CALLBACK' THEN
  l_email_body := l_email_body 
                  || 'Callback Log files can be downloaded from: ' 
                  || p_integration_pattern 
                  || l_line_separator 
                  || Chr (10); 
   ELSIF p_integration_pattern = 'Inbound' THEN	  
   l_email_body := l_email_body 
                  || 'Integration Pattern : ' 
                  || p_integration_pattern 
                  || l_line_separator 
                  || Chr (10); 
END IF;
END IF;

IF p_run_date IS NOT NULL THEN 
  l_email_body := l_email_body 
                  || 'Run Date : ' 
                  || To_char (p_run_date, 'DD-MON-YYYY HH:MI AM') 
                  || l_line_separator 
                  || Chr (10); 
END IF; 

IF p_job_id IS NOT NULL THEN 
 IF (Upper(p_stage) <> 'DUPLICATE')  THEN
 IF (Upper(p_stage) <> 'HDL_REPORT') THEN
 IF (Upper(p_stage) <> 'COAMAPPING') THEN
  l_email_body := l_email_body 
                  || 'Fusion ESS Job ID : ' 
                  || p_job_id 
                  || l_line_separator
                  || Chr (10)                   
                  --|| Chr (10)
                  --||'Note: This Notification is the status from "ERP Import Job"
                          -- (You will receive "CallBack" Notification shortly)'
                  || Chr (10);                   
END IF;
END IF;
END IF;
END IF; 

IF (p_job_name IS NOT NULL)  THEN 
  IF Upper(p_stage) <> 'DUPLICATE'
   THEN
  l_email_body := l_email_body 
                  || 'Fusion ESS Job Name : ' 
                  || p_job_name 
                  || l_line_separator 
                  || Chr (10); 
END IF; 
END IF; 

IF p_gbl_fault_error_code IS NOT NULL THEN 
  l_email_body := l_email_body 
                  || 'Error Code : ' 
                  || p_gbl_fault_error_code 
                  || l_line_separator 
                  || Chr (10); 
END IF;

IF p_gbl_fault_error_reason IS NOT NULL THEN 
  l_email_body := l_email_body 
                  || 'Reason : ' 
                  || p_gbl_fault_error_reason 
                  || l_line_separator 
                  || Chr (10); 
END IF; 

IF p_gbl_fault_error_details IS NOT NULL THEN 
  l_email_body := l_email_body 
                  || 'Details : ' 
                  || p_gbl_fault_error_details 
                  || l_line_separator 
                  || Chr (10); 
END IF; 

IF Upper (p_stage) = 'CALLBACK' THEN 
  FOR lcu_ess_job_dtls_rec IN get_ess_job_dtls LOOP 
      l_file_name := ''; 

      IF lcu_ess_job_dtls_rec.file_name IS NOT NULL THEN 
        l_file_name := 'File  Name : ' 
                       || lcu_ess_job_dtls_rec.file_name 
                       || ',' 
                       || l_line_separator; 
      END IF; 

      l_email_body := l_email_body 
                      || 'Job ID : ' 
                      || lcu_ess_job_dtls_rec.job_id 
                      || ',' 
                      || l_line_separator 
                      || 'Job Name : ' 
                      || lcu_ess_job_dtls_rec.job_name 
                      || ',' 
                      || l_line_separator 
                      || l_file_name 
                      || 'Status : ' 
                      || lcu_ess_job_dtls_rec.job_status 
                      || l_line_separator 
                      || Chr (10); 
  END LOOP; 
END IF; 

l_email_body := l_email_body 
                || l_line_separator 
                || Chr (10); 

-- Add Signature 
l_email_body := l_email_body 
                || 'Thanks,' 
                || l_line_separator 
                || Chr (10) 
                || 'Administrator' 
                || l_line_separator 
                || Chr (10); 

l_email_body := l_email_body 
                || Chr (10); 
end if;
x_email_body := l_email_body; 
END generate_email_body; */

    PROCEDURE generate_email_body (
        p_instance_id               IN    NUMBER,  --Added as a part of CIF_Common_Package Enhancement to improve performance
        p_integration_name          IN    VARCHAR2,
        p_integration_pattern       IN    VARCHAR2,
        p_run_date                  IN    DATE,
        p_message_type              IN    VARCHAR2,
        p_stage                     IN    VARCHAR2,
        p_gbl_fault_error_code      IN    VARCHAR2,
        p_gbl_fault_error_reason    IN    VARCHAR2,
        p_gbl_fault_error_details   IN    VARCHAR2,
        p_job_id                    IN    VARCHAR2,
        p_job_name                  IN    VARCHAR2,
        x_email_body                OUT   VARCHAR2
    ) IS

        l_email_body        VARCHAR2(32767);
        l_email_body_lkp    VARCHAR2(500);
        l_email_subject     VARCHAR2(100);
        l_file_name         VARCHAR2(400);
        l_line_separator    VARCHAR2(10) := '    ';
        CURSOR get_ess_job_dtls IS
        SELECT
            w.*,
            f.file_name
        FROM
            cif_job_history_tbl            w,
            cif_process_file_details_tbl   f
        WHERE
            1 = 1
            AND w.callback_id = p_instance_id--IS NOT NULL 
            AND w.job_id = f.attribute3 (+)
        ORDER BY
            job_id;

        l_sequence_number   NUMBER;
    BEGIN
        BEGIN
            SELECT
                MAX(sequence_number)
            INTO l_sequence_number
            FROM
                cif_log_messages_tbl
            WHERE
                instance_id = p_instance_id;

        EXCEPTION
            WHEN OTHERS THEN
                l_sequence_number := 0;
        END;

        l_email_body := NULL;
        l_email_body := l_email_body
                        || 'Hi Team,'
                        || l_line_separator
                        || chr(10)
                        || l_line_separator
                        || chr(10);

        SELECT
            email_subj,
            email_body
        INTO
            l_email_subject,
            l_email_body_lkp
        FROM
            cif_generate_email_body_tbl
        WHERE
            msg_type = upper(p_message_type)
            AND stage = upper(p_stage);

        IF upper(p_stage) = 'DUPLICATE' THEN
            l_email_body := l_email_body
                            || l_email_body_lkp
                            || l_line_separator
                            || chr(10)
                            || 'Duplicate File : '
                            || p_job_name
                            || l_line_separator
                            || chr(10)
                            || 'Duplicate File has been moved to : '
                            || p_job_id
                            || l_line_separator
                            || chr(10);

            IF p_instance_id IS NOT NULL THEN
                l_email_body := l_email_body
                                || chr(10)
                                || 'Instance ID : '
                                || p_instance_id
                                || l_line_separator
                                || chr(10);

            END IF;

            IF p_integration_name IS NOT NULL THEN
                l_email_body := l_email_body
                                || 'Integration Name : '
                                || p_integration_name
                                || l_line_separator
                                || chr(10);
            END IF;

            IF p_integration_pattern IS NOT NULL THEN
                l_email_body := l_email_body
                                || 'Integration Pattern : '
                                || p_integration_pattern
                                || l_line_separator
                                || chr(10);
            END IF;

            IF p_run_date IS NOT NULL THEN
                l_email_body := l_email_body
                                || 'Run Date : '
                                || TO_CHAR(p_run_date, 'DD-MON-YYYY HH:MI AM')
                                || l_line_separator
                                || chr(10);
            END IF;

        ELSIF upper(p_stage) = 'CALLBACK' THEN
            l_email_body := l_email_body
                            || l_email_body_lkp
                            || l_line_separator
                            || chr(10)
                            || l_line_separator
                            || chr(10);

            IF p_instance_id IS NOT NULL THEN
                l_email_body := l_email_body
                                || chr(10)
                                || 'Instance ID : '
                                || p_instance_id
                                || l_line_separator
                                || chr(10);

            END IF;

            IF p_integration_name IS NOT NULL THEN
                l_email_body := l_email_body
                                || 'Integration Name : '
                                || p_integration_name
                                || l_line_separator
                                || chr(10);
            END IF;

            IF p_integration_pattern IS NOT NULL THEN
                l_email_body := l_email_body
                                || 'Callback Log files can be downloaded from: '
                                || p_integration_pattern
                                || l_line_separator
                                || chr(10);
            END IF;

            IF p_run_date IS NOT NULL THEN
                l_email_body := l_email_body
                                || 'Run Date : '
                                || TO_CHAR(p_run_date, 'DD-MON-YYYY HH:MI AM')
                                || l_line_separator
                                || chr(10)
                                || l_line_separator
                                || chr(10);
            END IF;

            FOR lcu_ess_job_dtls_rec IN get_ess_job_dtls LOOP
                l_file_name := '';
                IF lcu_ess_job_dtls_rec.file_name IS NOT NULL THEN
                    l_file_name := 'File  Name : '
                                   || lcu_ess_job_dtls_rec.file_name
                                   || ','
                                   || l_line_separator;
                END IF;

                l_email_body := l_email_body
                                || 'Job ID : '
                                || lcu_ess_job_dtls_rec.job_id
                                || ','
                                || l_line_separator
                                || 'Job Name : '
                                || lcu_ess_job_dtls_rec.job_name
                                || ','
                                || l_line_separator
                                || l_file_name
                                || 'Status : '
                                || lcu_ess_job_dtls_rec.job_status
                                || l_line_separator
                                || chr(10);

            END LOOP;

        ELSIF upper(p_stage) = 'HDL_REPORT' THEN
            l_email_body := l_email_body
                            || l_email_body_lkp
                            || l_line_separator
                            || chr(10);
            l_email_body := l_email_body
                            || 'Log has been moved to : '
                            || p_job_id
                            || l_line_separator
                            || chr(10);

        ELSIF upper(p_stage) = 'COAMAPPING' THEN
            l_email_body := l_email_body
                            || l_email_body_lkp
                            || l_line_separator
                            || chr(10);
            l_email_body := l_email_body
                            || 'File has been moved to : '
                            || p_job_id
                            || l_line_separator
                            || chr(10);

        ELSIF upper(p_stage) = 'SUCCESSOUTBOUND' THEN
            l_email_body := l_email_body
                            || l_email_body_lkp
                            || l_line_separator
                            || chr(10);
            l_email_body := l_email_body
                            || chr(10)
                            || 'Instance ID : '
                            || p_instance_id
                            || l_line_separator
                            || chr(10);

            l_email_body := l_email_body
                            || 'Integration Name : '
                            || p_integration_name
                            || l_line_separator
                            || chr(10);

            l_email_body := l_email_body
                            || 'File Path: '
                            || p_job_name
                            || l_line_separator
                            || chr(10);

            l_email_body := l_email_body
                            || 'Integration Pattern : '
                            || p_integration_pattern
                            || l_line_separator
                            || chr(10);

            l_email_body := l_email_body
                            || 'Run Date : '
                            || TO_CHAR(p_run_date, 'DD-MON-YYYY HH:MI AM')
                            || l_line_separator
                            || chr(10);

        ELSE
            l_email_body := l_email_body
                            || l_email_body_lkp
                            || l_line_separator
                            || chr(10);
            IF p_instance_id IS NOT NULL THEN
                l_email_body := l_email_body
                                || chr(10)
                                || 'Instance ID : '
                                || p_instance_id
                                || l_line_separator
                                || chr(10);

            END IF;

            IF p_integration_name IS NOT NULL THEN
                l_email_body := l_email_body
                                || 'Integration Name : '
                                || p_integration_name
                                || l_line_separator
                                || chr(10);
            END IF;

            IF p_job_id IS NOT NULL THEN
                l_email_body := l_email_body
                                || 'Fusion ESS Job ID : '
                                || p_job_id
                                || l_line_separator
                                || chr(10);
            END IF;

            IF p_job_name IS NOT NULL THEN
                l_email_body := l_email_body
                                || 'Fusion ESS Job Name : '
                                || p_job_name
                                || l_line_separator
                                || chr(10);
            END IF;

            IF p_integration_pattern IS NOT NULL THEN
                l_email_body := l_email_body
                                || 'Integration Pattern : '
                                || p_integration_pattern
                                || l_line_separator
                                || chr(10);
            END IF;

            IF p_run_date IS NOT NULL THEN
                l_email_body := l_email_body
                                || 'Run Date : '
                                || TO_CHAR(p_run_date, 'DD-MON-YYYY HH:MI AM')
                                || l_line_separator
                                || chr(10);
            END IF;

            l_email_body := l_email_body
                            || l_line_separator
                            || chr(10); 

-- Add Signature 
            l_email_body := l_email_body
                            || 'Thanks,'
                            || l_line_separator
                            || chr(10)
                            || 'Administrator'
                            || l_line_separator
                            || chr(10);

        END IF;

        x_email_body := l_email_body;
    EXCEPTION
        WHEN no_data_found THEN
           /* INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                message_severity,
                message
            ) VALUES (
                p_instance_id,
                nvl(l_sequence_number, 0) + 1,
                SYSDATE,
                'Error',
                'The p_message_type: '
                || p_message_type
                || ' AND p_stage: '
                || p_stage
                || ' are missing in CIF_GENERATE_EMAIL_BODY_TBL table'
            );*/
            INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                status,
                error_code,
                error_message,
                error_details
            ) VALUES (
                p_instance_id,
                nvl(l_sequence_number, 0) + 1,
                SYSDATE,
                'Error',
                'No Data Found', -- changed by Lochana on 11/06
                'No Data Found', -- changed by Lochana on 11/06
                'The p_message_type: '
                || p_message_type
                || ' AND p_stage: '
                || p_stage
                || ' are missing in CIF_GENERATE_EMAIL_BODY_TBL table'
            );

        WHEN OTHERS THEN
            /*INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                message_severity,
                message
            ) VALUES (
                p_instance_id,
                nvl(l_sequence_number, 0) + 1,
                SYSDATE,
                'Error',
                'Error while Generating Email Body using generate_email_body pkg'
                || sys.standard.sqlcode
                || ' : '
                || sys.standard.sqlerrm
            );*/
            INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                status,
                error_code,
                error_message,
                error_details
            ) VALUES (
                p_instance_id,
                nvl(l_sequence_number, 0) + 1,
                SYSDATE,
                'Error',
                sys.standard.sqlcode,
                sys.standard.sqlerrm,
                'Error while Generating Email Body using generate_email_body pkg'
                || sys.standard.sqlcode
                || ' : '
                || sys.standard.sqlerrm
            );

    END generate_email_body; 

/********************************************************************
 Procedure: Insert_job_details
 Description: This Procedure is used to insert the job details in CIF_JOB_HISTORY_TBL table for each OIC Integration.
********************************************************************/

    PROCEDURE insert_job_details (
        p_instance_id   IN   NUMBER,
        p_callback_id   IN   NUMBER,
        p_job_id        IN   NUMBER,
        p_job_name      IN   VARCHAR2,
        p_job_status    IN   VARCHAR2
    ) AS 
   /* CURSOR get_sequence_number IS 
      SELECT Max (sequence_number) 
      FROM   CIF_LOG_MESSAGES_TBL 
      WHERE  instance_id = p_instance_id; */ --Commented as a part of CIF_Common_Package Enhancement to improve performance
        l_sequence_number NUMBER;
    BEGIN 
   /*   OPEN get_sequence_number; 

      FETCH get_sequence_number INTO l_sequence_number; 

      CLOSE get_sequence_number; */ --Commented as a part of CIF_Common_Package Enhancement to improve performance
        BEGIN --Added as a part of CIF_Common_Package Enhancement to improve performance
            SELECT
                MAX(sequence_number)
            INTO l_sequence_number
            FROM
                cif_log_messages_tbl
            WHERE
                instance_id = p_instance_id;

        EXCEPTION
            WHEN OTHERS THEN
                l_sequence_number := 0;
        END;

        IF p_job_id IS NOT NULL THEN
            INSERT INTO cif_job_history_tbl (
                instance_id,
                callback_id,
                job_id,
                job_name,
                job_status
            ) VALUES (
                p_instance_id,
                p_callback_id,
                p_job_id,
                p_job_name,
                p_job_status
            );

        END IF;

    EXCEPTION
        WHEN OTHERS THEN
           /* INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                message_severity,
                message
            ) VALUES (
                nvl(p_instance_id, p_callback_id),
                nvl(l_sequence_number, 0) + 1,
                SYSDATE,
                'Error',
                'Error while inserting record into CIF_JOB_HISTORY_TBL - '
                || sys.standard.sqlcode
                || ' : '
                || sys.standard.sqlerrm
            ); */
            INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                status,
                error_code,
                error_message,
                error_details
            ) VALUES (
                nvl(p_instance_id, p_callback_id),
                nvl(l_sequence_number, 0) + 1,
                SYSDATE,
                'Error',
                sys.standard.sqlcode,
                sys.standard.sqlerrm,
                'Error while inserting record into CIF_JOB_HISTORY_TBL - '
                || sys.standard.sqlcode
                || ' : '
                || sys.standard.sqlerrm
            );

    END insert_job_details;

/********************************************************************
 Procedure: Update_job_details
 Description: This Procedure is used to update the job details in CIF_JOB_HISTORY_TBL table for each OIC Integration.
********************************************************************/

    PROCEDURE update_job_details (
        p_callback_id       IN    NUMBER,
        p_callback_status   IN    VARCHAR2,
        p_run_date          IN    DATE,
        p_integration_id    OUT   VARCHAR2,
        p_instance_id       OUT   NUMBER,
        p_source_path       OUT   VARCHAR2
    ) AS 
 /*   CURSOR get_sequence_number IS 
      SELECT Max (sequence_number) 
      FROM   CIF_LOG_MESSAGES_TBL 
      WHERE  instance_id = p_callback_id; */ --Commented as a part of CIF_Common_Package Enhancement to improve performance

   /* CURSOR get_instance_id IS 
      SELECT CIF_j.instance_id, 
	         CIF_p.attribute1,
             (select attribute2 from CIF_PROCESS_FILE_DETAILS_TBL where instance_id = CIF_p.instance_id and rownum = 1 ) attribute2
            /* CIF_c1.value integration_name, 
             CIF_c1.integration_id, 
             CIF_c2.value integration_pattern
      FROM   CIF_JOB_HISTORY_TBL CIF_j, 
             CIF_PROCESS_INSTANCE_TBL CIF_p
           -- ,CIF_CIF_CONFIG_TBL CIF_c1, 
           --  CIF_CIF_CONFIG_TBL CIF_c2 
      WHERE  CIF_j.instance_id = CIF_p.instance_id 
             AND CIF_j.callback_id = p_callback_id 
           --  AND CIF_p.integration_name = CIF_c1.value 
           --  AND Upper (CIF_c1.name) = 'INTEGRATIONNAME' 
           --  AND CIF_c1.integration_id = CIF_c2.integration_id 
           --  AND Upper (CIF_c2.name) = 'INTEGRATIONTYPE' 
             AND ROWNUM = 1; */
  /*  CURSOR get_integration_params ( 
      p_integration_id VARCHAR2 ) IS 
      SELECT name, 
             value 
      FROM   CIF_CIF_CONFIG_TBL 
      WHERE  integration_id = p_integration_id 
             AND Upper (name) IN ( 'TOEMAILADDRESS', 'FROMEMAILADDRESS', 
                                   'SUCCESSEMAILSUBJECT', 
                                       'ERROREMAILSUBJECT' ); */ --Commented as a part of CIF_Common_Package Enhancement to improve performance
        l_sequence_number   NUMBER;
        l_instance_id       NUMBER;
        l_attribute1        VARCHAR2(200);
        l_attribute2        VARCHAR2(200);
    BEGIN
        l_sequence_number := NULL;
        l_instance_id := NULL;
        l_attribute1 := NULL;
        l_attribute2 := NULL;

     /* OPEN get_sequence_number; 

      FETCH get_sequence_number INTO l_sequence_number; 

      CLOSE get_sequence_number; */ --Commented as a part of CIF_Common_Package Enhancement to improve performance
        BEGIN --Added as a part of CIF_Common_Package Enhancement to improve performance
            SELECT
                MAX(sequence_number)
            INTO l_sequence_number
            FROM
                cif_log_messages_tbl
            WHERE
                instance_id = p_instance_id;

        EXCEPTION
            WHEN OTHERS THEN
                l_sequence_number := 0;
        END;

        BEGIN --Added as a part of CIF_Common_Package Enhancement to improve performance
            SELECT
                cif_j.instance_id,
                cif_p.attribute1,
                (
                    SELECT
                        attribute2
                    FROM
                        cif_process_file_details_tbl
                    WHERE
                        instance_id = cif_p.instance_id
                        AND ROWNUM = 1
                ) attribute2
            INTO
                l_instance_id,
                l_attribute1,
                l_attribute2
            FROM
                cif_job_history_tbl        cif_j,
                cif_process_instance_tbl   cif_p
            WHERE
                cif_j.instance_id = cif_p.instance_id
                AND ROWNUM = 1;

            p_integration_id := l_attribute1;
            p_instance_id := l_instance_id;
            p_source_path := l_attribute2;
        EXCEPTION
            WHEN OTHERS THEN
               /* INSERT INTO cif_log_messages_tbl (
                    instance_id,
                    sequence_number,
                    run_date,
                    message_severity,
                    message
                ) VALUES (
                    nvl(p_instance_id, p_callback_id),
                    nvl(l_sequence_number, 0) + 1,
                    SYSDATE,
                    'Error',
                    'Error while selecting record from CIF_JOB_HISTORY_TBL, CIF_PROCESS_INSTANCE_TBL, CIF_PROCESS_FILE_DETAILS_TBL - '
                    || sys.standard.sqlcode
                    || ' : '
                    || sys.standard.sqlerrm
                );*/
                INSERT INTO cif_log_messages_tbl (
                    instance_id,
                    sequence_number,
                    run_date,
                    status,
                    error_code,
                    error_message,
                    error_details
                ) VALUES (
                    nvl(p_instance_id, p_callback_id),
                    nvl(l_sequence_number, 0) + 1,
                    SYSDATE,
                    'Error',
                    sys.standard.sqlcode,
                    sys.standard.sqlerrm,
                    'Error while selecting record from CIF_JOB_HISTORY_TBL, CIF_PROCESS_INSTANCE_TBL, CIF_PROCESS_FILE_DETAILS_TBL - '
                    || sys.standard.sqlcode
                    || ' : '
                    || sys.standard.sqlerrm
                );

        END;

        UPDATE cif_job_history_tbl cif_a
        SET
            instance_id = (
                SELECT
                    instance_id
                FROM
                    cif_job_history_tbl cif_b
                WHERE
                    cif_b.job_id IN (
                        SELECT
                            job_id
                        FROM
                            cif_job_history_tbl
                        WHERE
                            callback_id IN (
                                p_callback_id
                            )
                    )
                    AND instance_id IS NOT NULL
                    AND callback_id IS NULL
            )
        WHERE
            callback_id = p_callback_id; 

    /*  OPEN get_instance_id; 

      FETCH get_instance_id INTO l_instance_id, l_attribute1,l_attribute2; 

      CLOSE get_instance_id;  */ --Commented as a part of CIF_Common_Package Enhancement to improve performance

	/*  p_integration_id := l_attribute1;
      p_instance_id := l_instance_id;
      p_source_path := l_attribute2; */ --Commented as a part of CIF_Common_Package Enhancement to improve performance

        UPDATE cif_job_history_tbl
        SET
            job_status = p_callback_status
        WHERE
            instance_id = l_instance_id
            AND callback_id IS NULL;

        BEGIN --Added as a part of CIF_Common_Package Enhancement to improve performance
            update_process_instance(p_instance_id => l_instance_id, p_end_time => p_run_date, p_status_time => p_run_date, p_status
            => p_callback_status, p_attribute1 => l_attribute1, p_attribute2 => NULL, p_attribute3 => NULL, p_attribute4 => NULL,
            p_attribute5 => NULL, p_attribute6 => NULL, p_attribute7 => NULL, p_attribute8 => NULL, p_attribute9 => NULL, p_attribute10
            => NULL, p_attribute11 => NULL, p_attribute12 => NULL, p_attribute13 => NULL, p_attribute14 => NULL, p_attribute15 =>
            NULL);
        EXCEPTION
            WHEN OTHERS THEN
               /* INSERT INTO cif_log_messages_tbl (
                    instance_id,
                    sequence_number,
                    run_date,
                    message_severity,
                    message
                ) VALUES (
                    p_callback_id,
                    nvl(l_sequence_number, 0) + 1,
                    SYSDATE,
                    'Error',
                    'Error while updating record into Update_process_instance - '
                    || sys.standard.sqlcode
                    || ' : '
                    || sys.standard.sqlerrm
                ); */
                INSERT INTO cif_log_messages_tbl (
                    instance_id,
                    sequence_number,
                    run_date,
                    status,
                    error_code,
                    error_message,
                    error_details
                ) VALUES (
                    p_callback_id,
                    nvl(l_sequence_number, 0) + 1,
                    SYSDATE,
                    'Error',
                    sys.standard.sqlcode,
                    sys.standard.sqlerrm,
                    'Error while updating record into Update_process_instance - '
                    || sys.standard.sqlcode
                    || ' : '
                    || sys.standard.sqlerrm
                );

        END;

    EXCEPTION
        WHEN OTHERS THEN
          /*  INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                message_severity,
                message
            ) VALUES (
                p_callback_id,
                nvl(l_sequence_number, 0) + 1,
                SYSDATE,
                'Error',
                'Error while updating record into CIF_JOB_HISTORY_TBL - '
                || sys.standard.sqlcode
                || ' : '
                || sys.standard.sqlerrm
            );*/
            INSERT INTO cif_log_messages_tbl (
                instance_id,
                sequence_number,
                run_date,
                status,
                error_code,
                error_message,
                error_details
            ) VALUES (
                p_callback_id,
                nvl(l_sequence_number, 0) + 1,
                SYSDATE,
                'Error',
                sys.standard.sqlcode,
                sys.standard.sqlerrm,
                'Error while updating record into CIF_JOB_HISTORY_TBL - '
                || sys.standard.sqlcode
                || ' : '
                || sys.standard.sqlerrm
            );

    END update_job_details;

/********************************************************************
 Function: Get_row_count
 Description: This Function is used to return the records count whose status are INPROCESS for a particular instance id.
********************************************************************/

    FUNCTION get_row_count (
        p_stage_table   VARCHAR2 DEFAULT NULL,
        p_instance_id   NUMBER
    ) RETURN NUMBER IS
        c1       SYS_REFCURSOR;
        l_stmt   VARCHAR2(1000);
        l_cnt    NUMBER;
    BEGIN
        IF p_stage_table IS NULL THEN
            l_cnt := 0;
        ELSE
            l_stmt := ' SELECT COUNT(INSTANCE_ID) FROM '
                      || p_stage_table
                      || ' WHERE STATUS = ''INPROCESS'' AND INSTANCE_ID != '
                      || p_instance_id;
            OPEN c1 FOR l_stmt;

            FETCH c1 INTO l_cnt;
            IF ( c1%notfound ) THEN
                l_cnt := 0;
            END IF;
            CLOSE c1;
        END IF;

        RETURN l_cnt;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 0;
    END get_row_count;

/********************************************************************
 Function: Get_main_instance_id
 Description: This Function is used to return the main instance id.
********************************************************************/

    FUNCTION get_main_instance_id (
        p_aic_instance_id NUMBER
    ) RETURN NUMBER IS
        l_instance_id NUMBER;
        CURSOR get_instance_id IS
        SELECT
            instance_id
        FROM
            cif_process_instance_tbl
        WHERE
            aic_instance_id = p_aic_instance_id;

    BEGIN
        l_instance_id := NULL;
        OPEN get_instance_id;
        FETCH get_instance_id INTO l_instance_id;
        CLOSE get_instance_id;
        RETURN l_instance_id;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN -1;
    END get_main_instance_id; 

/********************************************************************
 Function: get_lookup_value
 Description: This Function is used to get the value from CIF_COMMON_LOOKUP DB table for the passed source and lookup_type value.
********************************************************************/

    FUNCTION get_lookup_value (
        p_source          VARCHAR2,
        p_mapping_value   VARCHAR2,
        p_lookup_type     VARCHAR2,
        p_column          VARCHAR2
    ) RETURN VARCHAR2 IS

        l_value   VARCHAR2(1000);
        CURSOR c1 IS
        SELECT
            fusion_value,
            attribute1,
            attribute2,
            attribute3,
            attribute4,
            attribute5,
            attribute6,
            attribute7,
            attribute8,
            attribute9,
            attribute10
        FROM
            cif_common_lookup
        WHERE
            ( ( p_source IS NOT NULL
                AND source = p_source )
              OR ( p_source IS NULL
                   AND 1 = 1 ) )
            AND lookup_type = p_lookup_type
            AND upper(legacy_value) = upper(p_mapping_value);

        l_rec     c1%rowtype;
    BEGIN
        OPEN c1;
        FETCH c1 INTO l_rec;
        IF ( c1%notfound ) THEN
            l_value := 'NO_VAL';
        ELSE
            IF ( p_column = 'FUSION_VALUE' ) THEN
                l_value := l_rec.fusion_value;
            ELSIF ( p_column = 'ATTRIBUTE1' ) THEN
                l_value := l_rec.attribute1;
            ELSIF ( p_column = 'ATTRIBUTE2' ) THEN
                l_value := l_rec.attribute2;
            ELSIF ( p_column = 'ATTRIBUTE3' ) THEN
                l_value := l_rec.attribute3;
            ELSIF ( p_column = 'ATTRIBUTE4' ) THEN
                l_value := l_rec.attribute4;
            ELSIF ( p_column = 'ATTRIBUTE5' ) THEN
                l_value := l_rec.attribute5;
            ELSIF ( p_column = 'ATTRIBUTE6' ) THEN
                l_value := l_rec.attribute6;
            ELSIF ( p_column = 'ATTRIBUTE7' ) THEN
                l_value := l_rec.attribute7;
            ELSIF ( p_column = 'ATTRIBUTE8' ) THEN
                l_value := l_rec.attribute8;
            ELSIF ( p_column = 'ATTRIBUTE9' ) THEN
                l_value := l_rec.attribute9;
            ELSIF ( p_column = 'ATTRIBUTE10' ) THEN
                l_value := l_rec.attribute10;
            END IF;
        END IF;

        RETURN l_value;
        CLOSE c1;
    EXCEPTION  --Added as a part of CIF_Common_Package Enhancement to improve performance
        WHEN OTHERS THEN
            RETURN -1;
    END get_lookup_value;

END cif_common_package;