docker exec broker kafka-topics --create --topic ev_person_legal --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:2181
