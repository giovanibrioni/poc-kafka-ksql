SET 'auto.offset.reset' = 'earliest';

CREATE STREAM LEGACY_LOAN_FLOWS (
    DATA_REFERENCIA_CONSULTA BIGINT,  
    NUM_PARCELA BIGINT, 
    ID_CONTRATO VARCHAR, 
    SITUACAO_PAGAMENTO VARCHAR, 
    DATA_VENCIMENTO BIGINT, 
    VALOR_VENCIMENTO DOUBLE,
    VALOR_PRESENTE STRING,
    VALOR_PRESENTE_SALDO_DEVEDOR STRING
    ) 
WITH (kafka_topic='legacy_loan_flows', value_format='AVRO');

CREATE STREAM LECAGY_LOAN_FLOWS_TRANSFORMED 
    WITH (kafka_topic='loan_flows') AS 
    SELECT ID_CONTRATO + ':' + CAST(NUM_PARCELA AS STRING) AS flow_key,
        DATA_REFERENCIA_CONSULTA AS last_update_date,  
        NUM_PARCELA AS installment_number, 
        ID_CONTRATO AS contract_id, 
        SITUACAO_PAGAMENTO AS status, 
        DATA_VENCIMENTO AS due_date, 
        VALOR_VENCIMENTO AS due_value,
        CAST(VALOR_PRESENTE AS DOUBLE) AS present_value,
        CAST(VALOR_PRESENTE_SALDO_DEVEDOR AS DOUBLE) AS principal_outstading
    FROM LEGACY_LOAN_FLOWS 
    PARTITION BY ID_CONTRATO + ':' + CAST(NUM_PARCELA AS STRING) EMIT CHANGES;


CREATE STREAM LOAN_FLOWS (
    flow_key VARCHAR,
    last_update_date BIGINT,  
    installment_number BIGINT, 
    contract_id VARCHAR, 
    status VARCHAR, 
    due_date BIGINT, 
    due_value DOUBLE,
    present_value DOUBLE,
    principal_outstading DOUBLE
) WITH (kafka_topic='loan_flows', value_format='AVRO', KEY='flow_key');

CREATE TABLE LOAN_FLOWS_TB (
    flow_key VARCHAR,
    last_update_date BIGINT,  
    installment_number BIGINT, 
    contract_id VARCHAR, 
    status VARCHAR, 
    due_date BIGINT, 
    due_value DOUBLE,
    present_value DOUBLE,
    principal_outstading DOUBLE) 
    WITH (kafka_topic='loan_flows', value_format='AVRO', KEY='flow_key');


    