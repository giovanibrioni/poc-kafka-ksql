curl -s \
     -X "POST" "http://localhost:8083/connectors/" \
     -H "Content-Type: application/json" \
     -d '{
          "name": "sink_neo4j_ted_send",
          "config": {
            "connector.class": "streams.kafka.connect.sink.Neo4jSinkConnector",
            "errors.tolerance": "all",
            "errors.log.enable": true,
            "errors.log.include.messages": true,
            "neo4j.server.uri": "bolt://neo4j:7687",
            "neo4j.authentication.basic.username": "neo4j",
            "neo4j.authentication.basic.password": "connect",
            "topics": "SUSPICIOUS_TXNS",
            "neo4j.topic.cypher.SUSPICIOUS_TXNS": "MERGE (ac:account{account_id: event.ORIGIN_ACCOUNT_NUMBER}) merge (suspect:suspect{name: event.SUSPECT_NAME}) merge (ac)-[:SEND_MONEY_TO{amount:event.AMOUNT,txn_id:event.TXN_ID}]->(suspect)"
          }
        } '