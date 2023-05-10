docker exec broker kafka-topics --create --topic legacy_loan_contracts --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:2181
docker exec broker kafka-topics --create --topic legacy_loan_flows --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:2181
