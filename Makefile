
.PHONY: up
up:
	@echo "Starting containers ..."
	docker-compose up -d

.PHONY: down
down:
	@echo "Stopping containers ..."
	docker-compose down

.PHONY: topics
topics:
	@echo "Creating Topics ..."
	@sh ./01-person/01-event-person-individual/01-create-topic.sh
	@sh ./01-person/02-event-person-legal/01-create-topic.sh
	@sh ./02-legacy-account/01-create-topic.sh
	@sh ./03-loan/01-create-topics.sh
	@sh ./04-PLD/01-create-topics.sh
	@echo "Topics Created."

.PHONY: seed
seed:
	@echo "Seeding data ..."
	@sh ./01-person/01-event-person-individual/04-individual-created.sh
	@sh ./01-person/02-event-person-legal/03-legal-created.sh
	@docker exec ksqldb-cli bash -c "cat /data/04-PLD/02-create-black-list.sql <(echo 'EXIT')| ksql http://ksqldb-server:8088"
	@docker exec ksqldb-cli bash -c "cat /data/03-loan/04-insert-contracts.sql <(echo 'EXIT')| ksql http://ksqldb-server:8088"
	@echo "End Seed."

.PHONY: streams
streams:
	@echo "Creating Streams ..."
	@docker exec ksqldb-cli bash -c "cat /data/01-person/01-event-person-individual/02-person-created-stream-table.sql  <(echo 'EXIT')| ksql http://ksqldb-server:8088"
	@docker exec ksqldb-cli bash -c "cat /data/01-person/02-event-person-legal/02-legal-created-stream-table.sql <(echo 'EXIT')| ksql http://ksqldb-server:8088"
	@docker exec ksqldb-cli bash -c "cat /data/02-legacy-account/02-account-stream-table.sql <(echo 'EXIT')| ksql http://ksqldb-server:8088"
	@docker exec ksqldb-cli bash -c "cat /data/03-loan/02-contracts-stream-table.sql <(echo 'EXIT')| ksql http://ksqldb-server:8088"
	@docker exec ksqldb-cli bash -c "cat /data/03-loan/05-flows-stream-table.sql <(echo 'EXIT')| ksql http://ksqldb-server:8088"
	@docker exec ksqldb-cli bash -c "cat /data/03-loan/06-flows-collection.sql <(echo 'EXIT')| ksql http://ksqldb-server:8088"
	@docker exec ksqldb-cli bash -c "cat /data/04-PLD/02-create-black-list.sql <(echo 'EXIT')| ksql http://ksqldb-server:8088"
	@docker exec ksqldb-cli bash -c "cat /data/04-PLD/03-streams-PLD.sql <(echo 'EXIT')| ksql http://ksqldb-server:8088"
	@echo "Streams Created."

.PHONY: connectors
connectors:
	@echo "Configuring connectors ..."
	@sh ./02-legacy-account/03-connect-legacy-account.sh
	@sh 04-PLD/06-neo4j-connector.sh

.PHONY: config
config: topics streams connectors seed

.PHONY: wait
wait: 
	@docker exec -it ksqldb-cli bash -c 'echo -e "\n\n⏳ Waiting for KSQL to be available ...\n"; while [ $$(curl -s -o /dev/null -w %{http_code} http://ksqldb-server:8088/) -eq 000 ] ; do echo -e $(date) "KSQL Server HTTP state: " $(curl -s -o /dev/null -w %{http_code} http://ksqldb-server:8088/) " (waiting for 200)" ; sleep 5 ; done; echo -e "KSQL up and running\n"'

.PHONY: ksql
ksql: wait
	@docker exec -it ksqldb-cli bash -c 'ksql http://ksqldb-server:8088'

.PHONY: all
all: up wait config ksql
	@echo "Finished"


.PHONY: update-ev-person
update-ev-person:
	@echo "Updating Person Events ..."
	@sh ./01-person/01-event-person-individual/05-individual-updated.sh
	@sh ./01-person/02-event-person-legal/04-legal-updated.sh
	@echo "Person updated"

.PHONY: flows
flows: start-gen
	@sh ./03-loan/07-generate-flows.sh

.PHONY: transactions
transactions: start-gen
	@sh ./04-PLD/05-generate-transactions.sh

.PHONY: stop-gen
stop-gen:
	@docker-compose stop ksql-datagen

.PHONY: start-gen
start-gen:
	@docker-compose start ksql-datagen
