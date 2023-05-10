SET 'auto.offset.reset' = 'earliest';

CREATE STREAM LEGACY_ACCOUNTS (
        CD_CLIENTE VARCHAR, 
        CD_AGENCIA VARCHAR, 
        CD_CONTA VARCHAR, 
        TP_CONTA VARCHAR, 
        DS_STATUS VARCHAR, 
        DT_ABERTURA BIGINT, 
        DT_ENCERRAMENTO BIGINT, 
        DT_ULT_ALTERACAO BIGINT) 
    WITH (kafka_topic='legacy_accounts', value_format='AVRO');

CREATE STREAM LEGACY_ACCOUNT_TRANSFORMED 
    WITH (kafka_topic='bank_accounts') AS 
    SELECT CD_CLIENTE AS document_number, 
        CD_AGENCIA AS branch_number, 
        CD_CONTA AS account_number, 
        TP_CONTA AS account_type, 
        DS_STATUS AS account_status, 
        DT_ABERTURA AS account_opening_date, 
        DT_ENCERRAMENTO AS account_closing_date, 
        DT_ULT_ALTERACAO AS last_update_date 
    FROM LEGACY_ACCOUNTS 
    PARTITION BY CD_CLIENTE EMIT CHANGES;

CREATE TABLE BANK_ACCOUNTS_TB (
        document_number VARCHAR, 
        branch_number VARCHAR, 
        account_number VARCHAR, 
        account_type VARCHAR, 
        account_status VARCHAR, 
        account_opening_date BIGINT, 
        account_closing_date BIGINT, 
        last_update_date BIGINT) 
    WITH (kafka_topic='bank_accounts', value_format='AVRO', KEY='document_number');

