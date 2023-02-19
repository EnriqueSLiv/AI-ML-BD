CREATE OR REPLACE TABLE keepcoding.Tabla_2 AS (
SELECT
        tb1.calls_ivr_id AS ivr_id,
        tb1.calls_phone_number AS phone_number,
        tb1.calls_ivr_result AS ivr_result,
        CASE WHEN STARTS_WITH(tb1.calls_vdn_label, 'ATC') THEN 'FRONT'
             WHEN STARTS_WITH(tb1.calls_vdn_label, 'TECH') THEN 'TECH'
             WHEN tb1.calls_vdn_label = 'ABSORPTION' THEN 'ABSORPTION'
             ELSE 'RESTO'
        END AS vdn_aggregation,

        tb1.calls_start_date AS start_date,
        tb1.calls_end_date AS end_date,
        tb1.calls_total_duration AS total_duration,
        tb1.calls_customer_segment AS customer_segment,
        tb1.calls_ivr_language AS ivr_language,
        tb1.calls_steps_module AS steps_module,
        tb1.calls_module_aggregation AS module_aggregation,
        
        IFNULL(tb1.document_type, 'NULL') AS document_type,
        IFNULL(tb1.document_identification, 'NULL') AS document_identification,
        IFNULL(tb1.customer_phone, 'NULL') AS customer_phone,
        IFNULL(tb1.billing_account_id, 'NULL') AS billing_account_id,
        MAX(IF(tb2.module_name = 'AVERIA_MASIVA', 1, 0)) AS masiva_lg,
        MAX(IF(tb2.step_name = 'CUSTOMERINFOBYPHONE.TX' AND tb2.step_description_error = 'NULL', 1, 0)) AS info_by_phone_lg,
        MAX(IF(tb2.step_name = 'CUSTOMERINFOBYDNI.TX' AND tb2.step_description_error = 'NULL', 1, 0)) AS info_by_dni_lg 
    
    FROM keepcoding.ivr_detail tb1
        JOIN keepcoding.ivr_detail tb2
        ON tb1.calls_ivr_id = tb2.calls_ivr_id
        GROUP BY 
                tb1.calls_ivr_id, tb1.calls_phone_number, tb1.calls_ivr_result,
                tb1.calls_vdn_label, tb1.calls_start_date, tb1.calls_end_date,
                tb1.calls_total_duration, tb1.calls_customer_segment, tb1.calls_ivr_language,
                tb1.calls_steps_module, tb1.calls_module_aggregation, tb1.document_type,
                tb1.document_identification, tb1.customer_phone, tb1.billing_account_id,
                tb1.module_name, tb1.step_name, tb1.step_description_error, tb1.calls_ivr_id,
                tb2.calls_start_date, tb2.calls_ivr_id, tb2.calls_phone_number
           
            QUALIFY ROW_NUMBER() OVER(PARTITION BY tb1.calls_ivr_id ORDER BY tb1.document_type NULLS LAST, 
            tb1.document_identification NULLS LAST, tb1.customer_phone NULLS LAST, tb1.billing_account_id NULLS LAST) = 1
            ORDER BY tb1.calls_phone_number, tb1.calls_start_date ASC, tb2.calls_phone_number, tb2.calls_start_date ASC);

CREATE OR REPLACE TABLE keepcoding.ivr_summary AS(
SELECT  ivr_id, phone_number, ivr_result, vdn_aggregation, start_date, end_date,
        total_duration, customer_segment, ivr_language, steps_module, module_aggregation,
        NULLIF(document_type, 'DESCONOCIDO') AS document_type, NULLIF(document_identification, 'DESCONOCIDO') AS document_identification, 
        NULLIF(customer_phone, 'DESCONOCIDO') AS customer_phone, NULLIF(billing_account_id, 'DESCONOCIDO') AS billing_account_id,
        masiva_lg, info_by_phone_lg, info_by_dni_lg,
        IF(TIMESTAMP_DIFF(start_date, LAG(start_date) OVER(ORDER BY phone_number), HOUR) < 24
        AND phone_number = LAG(phone_number) OVER(ORDER BY phone_number), 1, 0) AS repeated_phone_24H,
        IF(TIMESTAMP_DIFF(LEAD(start_date) OVER(ORDER BY phone_number), start_date, HOUR) < 24
        AND phone_number = LEAD(phone_number) OVER(ORDER BY phone_number), 1, 0) AS cause_recall_phone_24H

    FROM keepcoding.Tabla_2
    GROUP BY 
           ivr_id, phone_number, ivr_result, vdn_aggregation, 
           start_date, end_date, total_duration, customer_segment, 
           ivr_language, steps_module, module_aggregation, document_type,
           document_identification, customer_phone, billing_account_id, 
           masiva_lg, info_by_phone_lg, info_by_dni_lg
    ORDER BY phone_number, start_date ASC
);
