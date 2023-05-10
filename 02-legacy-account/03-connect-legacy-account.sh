curl -X POST http://localhost:8083/connectors -H "Content-Type: application/json" -d '{
                "name": "jdbc_source_legacy_account",
                "config": {
                        "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
                        "connection.url": "jdbc:oracle:thin:@// <IP_ORACLE_LEGACY> :1521/ <SERVICE_NAME_LEGACY> ",
                        "connection.user":" <USUARIO_LEGACY> ",
                        "connection.password":" <SENHA_LEGACY> ",
                        "topic.prefix": "legacy_accounts",
                        "mode":"bulk",
                        "timestamp.column.name":"DT_ULT_ALTERACAO",
                        "query": "SELECT * FROM (SELECT * FROM view_cliente_contas_aux_v2 WHERE CD_CLIENTE IN (14897275903,18131546000147,65477328860,39079931870, 21666098051,77650851000104) ORDER BY DBMS_RANDOM.RANDOM) WHERE rownum = 1",
                        "poll.interval.ms": 2000,
                        "numeric.mapping":"best_fit"
                        }
                }'