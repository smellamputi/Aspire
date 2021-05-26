/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       AR_CC_RETRY_PKG PACKAGE BODY SCRIPT
       $Version 1.0
   REM ============================================================================
   REM
   REM NAME...: AR_CC_RETRY_PKG

   REM
   REM DESC...: Package body to identify eligible invoices for ASP-5561 Credit Card Retry Interface
   REM
   REM
   REM FILES..: none
   REM
   REM HISTORY:
   REM
   REM WHO                  WHAT                                                 WHEN
   REM --------------       ----------------------------------------------      ----------
   REM Gowthami Pola        Package body to identify eligible invoices          05/24/2021
   REM
   REM ===============================================================================
   REM
   REM ===================================================================================

   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
CREATE OR REPLACE PACKAGE BODY fusionintegration.ar_cc_retry_pkg
AS
   PROCEDURE ar_cc_retry_cg_inv_prc (p_customer_group   IN     VARCHAR2,
                                     p_user_name        IN     VARCHAR2,
                                     p_instance_id      IN     NUMBER,
                                     p_status              OUT VARCHAR2,
                                     p_message             OUT VARCHAR2)
   AS
      gc_user_name         VARCHAR2 (100) := p_user_name;
      var_limit            PLS_INTEGER DEFAULT 1000;
      var_date_format      VARCHAR2 (500) := 'DD-MON-YY HH24:MI:SS';
      var_sql_stmt         VARCHAR2(500) := 'ALTER SESSION SET NLS_DATE_FORMAT ='||''''||var_date_format||'''';
      var_cg_name          VARCHAR2 (500);
      var_exception          EXCEPTION;

      CURSOR cur_error_map
      IS
         SELECT stg.record_id, ecm.error_label
           FROM fusionintegration.ar_cc_retry_inv_stg stg,
                fusionintegration.ar_cc_retry_error_code_mapping ecm
          WHERE stg.ERROR_CODE = ecm.ERROR_CODE
                AND stg.oic_instance_id = p_instance_id;

      TYPE ErrorMapTabTyp IS TABLE OF cur_error_map%ROWTYPE
                                INDEX BY BINARY_INTEGER;

      var_errormap_tbl     ErrorMapTabTyp;

      CURSOR cur_customer_groups
      IS
         SELECT *
           FROM fusionintegration.ar_cc_retry_customer_groups
          WHERE active_flag = 'Y'
                AND customer_group_name =
                       NVL (p_customer_group, customer_group_name);

      CURSOR cur_retry_rules (
         p_cg_config_id   IN NUMBER,
         p_cg_retry_id    IN NUMBER)
      IS
         WITH inv_stg
           AS (SELECT record_id, oic_instance_id, error_label, customer_group_name, inv_retry_count,last_pmt_attempt_date
           FROM fusionintegration.ar_cc_retry_inv_stg
          WHERE nvl(cg_attr1_value,1) = NVL (  (SELECT attribute_value FROM fusionintegration.ar_cc_retry_cg_config_rules
                        WHERE attribute_name = cg_attribute1 AND cg_config_id = p_cg_config_id), nvl(cg_attr1_value,1))
          AND nvl(cg_attr2_value,1) =  NVL (  (SELECT attribute_value FROM fusionintegration.ar_cc_retry_cg_config_rules
                         WHERE attribute_name = cg_attribute2 AND cg_config_id = p_cg_config_id),  nvl(cg_attr2_value,1)) 
          AND nvl(cg_attr3_value,1) = NVL (  (SELECT attribute_value FROM fusionintegration.ar_cc_retry_cg_config_rules
                         WHERE attribute_name = cg_attribute3 AND cg_config_id = p_cg_config_id),  nvl(cg_attr3_value,1))
          AND NVL (cg_attr4_value, 1) =  NVL ( (SELECT attribute_value FROM fusionintegration.ar_cc_retry_cg_config_rules
                         WHERE attribute_name = cg_attribute4 AND cg_config_id = p_cg_config_id), NVL(cg_attr4_value, 1))
          AND oic_instance_id = p_instance_id)
      SELECT (SELECT max(attempt_id) from fusionintegration.ar_cc_retry_cg_retry_rules cgr1 where cgr1.cg_retry_id = p_cg_retry_id and cgr1.error_label = inv_stg.error_label ) retry_count,
             cgr.retry_interval,
             cgr.interval_type,
             inv_stg.record_id,
             cgr.customer_group_name,
             ROUND((TO_DATE(SYSDATE,'DD-MON-YY HH24:MI:SS')-TO_DATE(inv_stg.last_pmt_attempt_date,'DD-MON-YY HH24:MI:SS'))*(DECODE(cgr.interval_type,'HOURS',24,'MINS',1440,'DAY',1)),2) interval_diff
        FROM inv_stg, fusionintegration.ar_cc_retry_cg_retry_rules cgr
       WHERE     cgr.cg_retry_id = p_cg_retry_id
             AND cgr.error_label = inv_stg.error_label 
			 AND cgr.attempt_id= inv_stg.inv_retry_count
             AND inv_stg.customer_group_name IS NULL
             AND inv_stg.oic_instance_id = p_instance_id;

      TYPE CgRetryRulesTyp IS TABLE OF cur_retry_rules%ROWTYPE
                                 INDEX BY BINARY_INTEGER;

      var_retryrules_tbl   CgRetryRulesTyp;

      CURSOR cur_eligible_invoices
      IS
         SELECT record_id
           FROM fusionintegration.ar_cc_retry_inv_stg
          WHERE     oic_instance_id = p_instance_id
                AND inv_retry_count <= retry_count
                AND interval_diff >= retry_interval
                AND customer_group_name IS NOT NULL;

      TYPE CgEligInvTyp IS TABLE OF cur_eligible_invoices%ROWTYPE
                              INDEX BY BINARY_INTEGER;

      var_eliginv_tbl      CgEligInvTyp;
   BEGIN
      EXECUTE IMMEDIATE var_sql_stmt;                     --set 24H dateformat

      BEGIN
         IF p_customer_group IS NOT NULL
         THEN
            BEGIN
               SELECT customer_group_name
                 INTO var_cg_name
                 FROM fusionintegration.ar_cc_retry_customer_groups
                WHERE customer_group_name = p_customer_group;
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_message := 'Invalid Customer Group Name';
                  RAISE var_exception;
            END;
         END IF;
      END;

      BEGIN
         OPEN cur_error_map; --update error label based on error code for all invoices

         LOOP
            FETCH cur_error_map
            BULK COLLECT INTO var_errormap_tbl
            LIMIT var_limit;

            EXIT WHEN var_errormap_tbl.COUNT = 0;

            BEGIN
               FORALL rec_upd IN 1 .. var_errormap_tbl.COUNT
                  UPDATE fusionintegration.ar_cc_retry_inv_stg
                     SET error_label = var_errormap_tbl (rec_upd).error_label,
                         last_update_date = SYSDATE,
                         last_updated_by = gc_user_name
                   WHERE record_id = var_errormap_tbl (rec_upd).record_id
                         AND oic_instance_id = p_instance_id;
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_message := SQLERRM || '-while updating error label';
                  RAISE var_exception;
            END;

            DBMS_OUTPUT.put_line (var_errormap_tbl.COUNT);
            COMMIT;
         END LOOP;

         CLOSE cur_error_map;
      END;

      BEGIN
         FOR rec IN cur_customer_groups              --for each customer group
         LOOP
            BEGIN
               DBMS_OUTPUT.put_line (rec.customer_group_name);

               OPEN cur_retry_rules (rec.cg_config_id, rec.cg_retry_id); --update retry count and retry interval for all invoices

               LOOP
                  FETCH cur_retry_rules
                  BULK COLLECT INTO var_retryrules_tbl
                  LIMIT var_limit;

                  EXIT WHEN var_retryrules_tbl.COUNT = 0;

                  BEGIN
                     FORALL rec_upd IN 1 .. var_retryrules_tbl.COUNT
                        UPDATE fusionintegration.ar_cc_retry_inv_stg
                           SET customer_group_name =
                                  var_retryrules_tbl (rec_upd).customer_group_name,
                               retry_count =
                                  var_retryrules_tbl (rec_upd).retry_count,
                               RETRY_interval =
                                  var_retryrules_tbl (rec_upd).retry_interval,
                               interval_type =
                                  var_retryrules_tbl (rec_upd).interval_type,
                               interval_diff =
                                  var_retryrules_tbl (rec_upd).interval_diff,
                               last_update_date = SYSDATE,
                               last_updated_by = gc_user_name
                         WHERE record_id =
                                  var_retryrules_tbl (rec_upd).record_id
                               AND oic_instance_id = p_instance_id;
                  EXCEPTION
                     WHEN OTHERS
                     THEN
                        p_message := SQLERRM || '-while updating retry rules';
                        RAISE var_exception;
                  END;

                  DBMS_OUTPUT.put_line (var_retryrules_tbl.COUNT);
                  COMMIT;
               END LOOP;

               CLOSE cur_retry_rules;
            END;
         END LOOP;
      END;

      BEGIN
         OPEN cur_eligible_invoices;       --update eligible flag for invoices

         LOOP
            FETCH cur_eligible_invoices
            BULK COLLECT INTO var_eliginv_tbl
            LIMIT var_limit;

            EXIT WHEN var_eliginv_tbl.COUNT = 0;

            BEGIN
               FORALL rec_upd IN 1 .. var_eliginv_tbl.COUNT
                  UPDATE fusionintegration.ar_cc_retry_inv_stg
                     SET eligible_flag = 'Y',
                         last_update_date = SYSDATE,
                         last_updated_by = gc_user_name
                   WHERE record_id = var_eliginv_tbl (rec_upd).record_id
                         AND oic_instance_id = p_instance_id;
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_message := SQLERRM || '-while updating eligible flag';
                  RAISE var_exception;
            END;

            DBMS_OUTPUT.put_line (var_eliginv_tbl.COUNT);
            COMMIT;
         END LOOP;

         CLOSE cur_eligible_invoices;
      END;

      p_status := 'S';
      p_message := 'Successfully Completed';
   EXCEPTION
      WHEN var_exception
      THEN
         p_status := 'E';
      WHEN OTHERS
      THEN
         p_status := 'E';
         p_message := 'Unexpected Exception Occurred-' || SQLERRM;
   END;
END ar_cc_retry_pkg;