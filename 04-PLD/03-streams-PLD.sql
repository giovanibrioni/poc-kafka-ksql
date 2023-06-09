CREATE STREAM TXNS (TXN_ID BIGINT, 
                     ORIGIN_ACCOUNT_NUMBER VARCHAR, 
                     RECIPIENT_DOCUMENT_NUMBER VARCHAR, 
                     TYPE VARCHAR,
                     AMOUNT DOUBLE) 
     WITH (KAFKA_TOPIC = 'txns', VALUE_FORMAT = 'AVRO');

 CREATE STREAM TXNS_TED 
               WITH (KAFKA_TOPIC = 'transactions_ted', VALUE_FORMAT = 'AVRO')
               AS SELECT * 
                  FROM TXNS
                  WHERE TYPE = 'TED' 
                  PARTITION BY RECIPIENT_DOCUMENT_NUMBER EMIT CHANGES;

CREATE STREAM SUSPICIOUS_TXNS 
AS SELECT TXN_ID, ORIGIN_ACCOUNT_NUMBER, T.RECIPIENT_DOCUMENT_NUMBER RECIPIENT_DOCUMENT_NUMBER, AMOUNT, B.NAME SUSPECT_NAME  
   FROM TXNS_TED T 
        INNER JOIN 
        BLACK_LIST_TB B 
        ON T.RECIPIENT_DOCUMENT_NUMBER = B.DOCUMENT_NUMBER
   EMIT CHANGES;


   