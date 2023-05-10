docker exec broker kafka-topics --create --topic black_list --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:2181
docker exec broker kafka-topics --create --topic txns --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:2181





