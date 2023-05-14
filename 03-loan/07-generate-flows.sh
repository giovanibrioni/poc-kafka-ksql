docker exec ksql-datagen bash -c "ksql-datagen schema=/data/datagen/loan_flows.avro bootstrap-server=broker:29092 schemaRegistryUrl=http://schema-registry:8081 format=avro key=ID_CONTRATO topic=legacy_loan_flows msgRate=1 iterations=100"