        curl -X POST http://localhost:8083/connectors -H "Content-Type: application/json" -d '{
                        "name": "jdbc_source_legacy_loan_contracts",
                        "config": {
                                "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
                                "connection.url": "jdbc:oracle:thin:@// <IP_ORACLE_LEGACY> :1521/ <SERVICE_NAME_LEGACY> ",
                                "connection.user":" <USUARIO_LEGACY> ",
                                "connection.password":" <SENHA_LEGACY> ",
                                "topic.prefix": "legacy_loan_contracts",
                                "mode":"bulk",
                                "timestamp.column.name":"DATA_REFERENCIA_CONSULTA",
                                "query": "SELECT * FROM (SELECT SYSDATE DATA_REFERENCIA_CONSULTA, CPF_CNPJ_CLIENTE, C.ID_CONTRATO, PRODUTO_VENDA, SITUACAO_CONTRATO, DATA_INICIO_ORIGINAL, DATA_VENCIMENTO, VALOR, TAXA_JUROS_MORA, MULTA_ATRASO, NUMERO_TOTAL_PARCELAS FROM EM_CONTRATO c, VEM_API_CONTRATO_PRODUTO cp WHERE cp.id_contrato = c.id_contrato AND c.id_contrato in (890987,200000378,333222111,100000028) ORDER BY DBMS_RANDOM.RANDOM) WHERE rownum = 1",
                                "poll.interval.ms": 1000,
                                "numeric.mapping":"best_fit"
                                }
                        }'

