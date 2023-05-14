docker exec broker kafka-topics --create --topic connect_legacy_accounts --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:2181
