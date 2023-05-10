docker exec broker kafka-topics --create --topic legacy_accounts --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:2181
