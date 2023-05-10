curl -X POST http://localhost:8083/connectors -H "Content-Type: application/json" -d '{
                "name": "jdbc_source_legacy_loan_flow",
                "config": {
                        "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
                        "connection.url": "jdbc:oracle:thin:@// <IP_ORACLE_LEGACY> :1521/ <SERVICE_NAME_LEGACY> ",
                        "connection.user":" <USUARIO_LEGACY> ",
                        "connection.password":" <SENHA_LEGACY> ",
                        "topic.prefix": "legacy_loan_flows",
                        "mode":"bulk",
                        "timestamp.column.name":"DATA_REFERENCIA_CONSULTA",
                        "query": "SELECT * FROM (SELECT DATA_REFERENCIA_CONSULTA, ID_PAGAMENTO, NUM_PARCELA, ID_CONTRATO, SITUACAO_PAGAMENTO, DATA_VENCIMENTO, VALOR_VENCIMENTO, VALOR_PRESENTE, VALOR_PRINCIPAL_ORIGINAL, VALOR_PRESENTE_SALDO_DEVEDOR FROM VEM_API_FLUXO_PAGAMENTO_C6 WHERE id_contrato IN (890987,200000378,333222111,100000028) ORDER BY DBMS_RANDOM.RANDOM) WHERE rownum = 1",
                        "poll.interval.ms": 1000,
                        "transforms": "Cast",
                        "transforms.Cast.type": "org.apache.kafka.connect.transforms.Cast$Value",
                        "transforms.Cast.spec": "ID_PAGAMENTO:string,VALOR_PRESENTE:string,VALOR_PRINCIPAL_ORIGINAL:string,VALOR_PRESENTE_SALDO_DEVEDOR:string",
                        "numeric.mapping":"best_fit"
                        }
                }'
