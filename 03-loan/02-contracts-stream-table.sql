SET 'auto.offset.reset' = 'earliest';

CREATE STREAM LEGACY_LOAN_CONTRACTS (
        DATA_REFERENCIA_CONSULTA BIGINT, 
        CPF_CNPJ_CLIENTE VARCHAR, 
        ID_CONTRATO VARCHAR, 
        PRODUTO_VENDA STRING, 
        SITUACAO_CONTRATO STRING, 
        DATA_INICIO_ORIGINAL BIGINT, 
        DATA_VENCIMENTO BIGINT, 
        VALOR DOUBLE, 
        TAXA_JUROS_MORA DOUBLE, 
        MULTA_ATRASO DOUBLE, 
        NUMERO_TOTAL_PARCELAS BIGINT) 
    WITH (kafka_topic='legacy_loan_contracts', value_format='AVRO');

CREATE STREAM LEGACY_LOAN_CONTRACTS_TRANSFORMED 
    WITH (kafka_topic='loan_contracts') AS 
    SELECT DATA_REFERENCIA_CONSULTA AS last_update_date, 
            CPF_CNPJ_CLIENTE AS document_number, 
            ID_CONTRATO AS contract_id, 
            PRODUTO_VENDA AS product, 
            CASE 
                WHEN SITUACAO_CONTRATO = 'AN' THEN 'ANORMAL' 
                WHEN SITUACAO_CONTRATO = 'NO' THEN 'NORMAL' 
                WHEN SITUACAO_CONTRATO = 'AT' THEN 'ATRASADO' 
                ELSE 'Unknown' 
                END AS status,
            DATA_INICIO_ORIGINAL AS start_date, 
            DATA_VENCIMENTO AS end_date, VALOR, 
            TAXA_JUROS_MORA AS interest_rate, 
            MULTA_ATRASO AS fine_for_delay, 
            NUMERO_TOTAL_PARCELAS AS total_installments 
    FROM LEGACY_LOAN_CONTRACTS PARTITION BY ID_CONTRATO EMIT CHANGES;

CREATE TABLE LOAN_CONTRACTS_TB (
            last_update_date BIGINT, 
            document_number VARCHAR, 
            contract_id VARCHAR, 
            product VARCHAR, 
            status VARCHAR, 
            start_date BIGINT, 
            end_date BIGINT, 
            interest_rate DOUBLE, 
            fine_for_delay DOUBLE, 
            total_installments BIGINT) 
    WITH (kafka_topic='loan_contracts', value_format='AVRO', KEY='contract_id');
