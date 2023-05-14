SET 'auto.offset.reset' = 'earliest';

CREATE STREAM LEGACY_ACCOUNTS (
        ID  BIGINT,
        CD_CLIENTE STRING, 
        CD_AGENCIA STRING, 
        CD_CONTA STRING, 
        DS_STATUS STRING, 
        DT_ABERTURA BIGINT,
        DT_ULT_ALTERACAO BIGINT) 
    WITH (kafka_topic='connect_legacy_accounts', value_format='AVRO');


CREATE STREAM LEGACY_ACCOUNT_TRANSFORMED 
    WITH (kafka_topic='bank_accounts') AS 
    SELECT CD_CLIENTE AS document_number, 
        CD_AGENCIA AS branch_number, 
        CD_CONTA AS account_number, 
        DS_STATUS AS account_status, 
        DT_ABERTURA AS account_opening_date
    FROM LEGACY_ACCOUNTS 
    PARTITION BY CD_CLIENTE EMIT CHANGES;

CREATE TABLE BANK_ACCOUNTS_TB (
        document_number STRING, 
        branch_number STRING, 
        account_number STRING, 
        account_status STRING, 
        account_opening_date STRING) 
    WITH (kafka_topic='bank_accounts', value_format='AVRO', KEY='document_number');

