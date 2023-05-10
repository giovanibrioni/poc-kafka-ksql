SET 'auto.offset.reset' = 'earliest';

CREATE STREAM EV_PERSON_LEGAL (class VARCHAR, person_id VARCHAR, legal STRUCT<
        business_name VARCHAR,
        company_name VARCHAR,
        cnpj VARCHAR,
        address STRUCT<address_id BIGINT,
                        type VARCHAR,
                        zip_code VARCHAR,
                        street VARCHAR,
                        number VARCHAR,
                        complement VARCHAR,
                        city VARCHAR,
                        state VARCHAR,
                        country VARCHAR>,
        phone STRUCT<phone_id BIGINT,
                    type VARCHAR,
                    area_code VARCHAR,
                    country_code VARCHAR,
                    number VARCHAR>>) 
    WITH (kafka_topic='ev_person_legal', value_format='JSON');

CREATE STREAM EV_PERSON_LEGAL_TRANSFORMED 
    WITH (kafka_topic='person', value_format='AVRO') 
    AS SELECT person_id, class     AS type, 
            legal->cnpj            AS document_number, 
            legal->business_name   AS name, 
            legal->address         AS address, 
            legal->phone           AS phone, 
            ROWTIME                AS last_update_date 
        FROM EV_PERSON_LEGAL 
        PARTITION BY legal->cnpj EMIT CHANGES;

