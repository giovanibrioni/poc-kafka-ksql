docker exec ksql-datagen ksql-datagen schema=/data/datagen/loan_contracts.avro bootstrap-server=broker:29092 schemaRegistryUrl=http://schema-registry:8081 format=avro key=ID_CONTRATO topic=legacy_loan_contracts msgRate=1 iterations=100