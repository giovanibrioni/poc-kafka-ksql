SET 'auto.offset.reset' = 'earliest';

CREATE STREAM EC_PERSON_INDIVIDUAL (class VARCHAR, person_id VARCHAR, individual STRUCT<
        name VARCHAR,
        cpf VARCHAR,
        email VARCHAR,
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
    WITH (kafka_topic='ev_person_individual', value_format='JSON');

CREATE STREAM EV_PERSON_INDIVIDUAL_TRANSFORMED 
    WITH (kafka_topic='person', value_format='AVRO') 
    AS SELECT person_id, class  AS type, 
            individual->cpf     AS document_number, 
            individual->name    AS name, 
            individual->email   AS email, 
            individual->address AS address, 
            individual->phone   AS phone, 
            ROWTIME             AS last_update_date 
        FROM EV_PERSON_INDIVIDUAL 
        PARTITION BY individual->cpf EMIT CHANGES;

CREATE TABLE PERSON_TB (document_number VARCHAR, person_id VARCHAR, type VARCHAR, last_update_date BIGINT,
        name VARCHAR,
        email VARCHAR,
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
                    number VARCHAR>) 
    WITH (kafka_topic='person', value_format='AVRO', KEY='document_number');
