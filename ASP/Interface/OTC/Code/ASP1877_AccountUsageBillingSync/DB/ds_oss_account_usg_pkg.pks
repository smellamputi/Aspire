create or replace PACKAGE ds_oss_account_usg_pkg AS

/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       DS_OSS_ACCOUNT_USG_PKG TABLE SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: DS_OSS_ACCOUNT_USG_PKG
   REM
   REM DESC...: Package to insert values in Account Usage Stage
   REM
   REM
   REM
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Rohit Srivastava     Initial Version                                     03/05/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
    TYPE stitch_rec_type IS RECORD (
        record_id       NUMBER,
        run_date_time   TIMESTAMP,
        interface_id    VARCHAR2(10),
        interface_name  VARCHAR2(120),
        instance_id     VARCHAR2(20),
        trackingid      VARCHAR2(240),
        s3downloadlink  VARCHAR2(4000)
    );
    PROCEDURE insert_tracking_id (
        p_stitch_data_rec  IN   stitch_rec_type,
        p_insert_status    OUT  VARCHAR2
    );

/*
    **********Below object type must be created in ATP ********
    ***********************************************************

DROP TYPE usagedata_rec_type ;

CREATE OR REPLACE TYPE usagedata_rec_type AS OBJECT (
    record_id    NUMBER,
    dsaccountid  VARCHAR2(240),
    uom          VARCHAR2(50),
    uom_source   VARCHAR2(120),
    quantity     NUMBER,
    usagedate    VARCHAR2(16),
    usageid      VARCHAR2(240)
);

**** Dependent Table Type ***************

DROP TYPE usagedata_rec_type ;

CREATE OR REPLACE TYPE usagedata_tbl_type AS TABLE OF usagedata_rec_type; */

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
    );

    PROCEDURE update_records (
        p_schedule_instance_id IN VARCHAR2
    );

    PROCEDURE update_success_records (
        p_schedule_instance_id  IN  VARCHAR2,
        p_message               IN  VARCHAR2,
        p_dsaccountid           IN  VARCHAR2,
        p_uom                   IN  VARCHAR2,
        p_usagedate             IN  VARCHAR2
    );

     PROCEDURE update_scope_failure (
       p_schedule_instance_id  IN  VARCHAR2
    );

END ds_oss_account_usg_pkg;