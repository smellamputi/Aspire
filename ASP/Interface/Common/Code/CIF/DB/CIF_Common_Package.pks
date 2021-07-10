create or replace PACKAGE                   cif_common_package AS
    g_instance_id NUMBER := NULL;

 /*  procedure delete_stg_table(p_instance_id number); */
 /*  PROCEDURE insert_error_log_message ( p_instance_id        IN NUMBER
                                      , p_sequence_number    IN NUMBER
                                      , p_run_date           IN DATE
                                      , p_message_severity   IN VARCHAR2
                                      , p_message            IN VARCHAR2
                                      , p_attribute1         IN VARCHAR2
                                      , p_attribute2         IN VARCHAR2
                                      , p_attribute3         IN VARCHAR2
                                      , p_attribute4         IN VARCHAR2
                                      , p_attribute5         IN VARCHAR2
                                      , p_attribute6         IN VARCHAR2
                                      , p_attribute7         IN VARCHAR2
                                      , p_attribute8         IN VARCHAR2
                                      , p_attribute9         IN VARCHAR2
                                      , p_attribute10        IN VARCHAR2
                                      , p_attribute11        IN VARCHAR2
                                      , p_attribute12        IN VARCHAR2
                                      , p_attribute13        IN VARCHAR2
                                      , p_attribute14        IN VARCHAR2
                                      , p_attribute15        IN VARCHAR2 ); */
    PROCEDURE insert_error_log_message (
        p_instance_id         IN   NUMBER,
        p_interface_name      IN   VARCHAR2,
        p_interface_id        IN   VARCHAR2,
        p_run_date            IN   DATE,
        p_message_severity    IN   VARCHAR2,
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
    );

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
    );

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
    );

    PROCEDURE insert_process_run_details (
        p_instance_id        IN   NUMBER,
        p_integration_name   IN   VARCHAR2,
        p_last_run_date      IN   DATE,
        p_status             IN   VARCHAR2
    );

    PROCEDURE update_process_run_details (
        p_instance_id        IN   NUMBER,
        p_integration_name   IN   VARCHAR2,
        p_last_run_date      IN   DATE,
        p_status             IN   VARCHAR2
    );

    FUNCTION get_row_count (
        p_stage_table   VARCHAR2 DEFAULT NULL,
        p_instance_id   NUMBER
    ) RETURN NUMBER;

    PROCEDURE insert_job_details (
        p_instance_id   IN   NUMBER,
        p_callback_id   IN   NUMBER,
        p_job_id        IN   NUMBER,
        p_job_name      IN   VARCHAR2,
        p_job_status    IN   VARCHAR2
    );

    FUNCTION get_main_instance_id (
        p_aic_instance_id NUMBER
    ) RETURN NUMBER;

    PROCEDURE update_job_details (
        p_callback_id       IN    NUMBER,
        p_callback_status   IN    VARCHAR2,
        p_run_date          IN    DATE,
        p_integration_id    OUT   VARCHAR2,
        p_instance_id       OUT   NUMBER,
        p_source_path       OUT   VARCHAR2
    );

    PROCEDURE generate_email_body (
        p_instance_id               IN    NUMBER,
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
    );

    PROCEDURE insert_process_instance (
        p_oic_instance_id           IN    NUMBER,
        p_interface_id          IN VARCHAR2,
        p_integration_name      IN    VARCHAR2,
        p_integration_pattern   IN    VARCHAR2,
        p_run_date              IN    DATE,
        p_scope_name            IN VARCHAR2,
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
    );

    FUNCTION get_lookup_value (
        p_source          VARCHAR2,
        p_mapping_value   VARCHAR2,
        p_lookup_type     VARCHAR2,
        p_column          VARCHAR2
    ) RETURN VARCHAR2;

END CIF_COMMON_PACKAGE;
