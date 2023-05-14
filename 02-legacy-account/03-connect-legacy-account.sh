curl -X POST http://localhost:8083/connectors -H "Content-Type: application/json" -d '{
"name": "jdbc_source_lecacy_accounts",
"config": {
        "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
        "connection.url": "jdbc:postgresql://postgres:5432/accounts_db",
        "connection.user":"postgresuser",
        "connection.password":"postgrespw",
        "topic.prefix": "connect_",
        "table.whitelist": "legacy_accounts",
        "timestamp.column.name":"dt_ult_alteracao",
        "poll.interval.ms": 1000,
        "numeric.mapping":"best_fit",
        "mode": "timestamp"
        }
}'