SET 'auto.offset.reset' = 'earliest';

CREATE STREAM LOAN_FLOWS_LATE_PAYMENT 
    WITH (kafka_topic='loan_flows_late_payment') AS
        SELECT * 
        FROM LOAN_FLOWS
        WHERE STATUS = 'ATRASADO'
        EMIT CHANGES;

CREATE STREAM LOAN_FLOWS_LATE_PAYMENT_ENRICHED_BY_CONTRACT AS
        SELECT  LP.CONTRACT_ID contract_id, 
                LP.INSTALLMENT_NUMBER installment_number, 
                LP.STATUS status, 
                LP.DUE_DATE due_date, 
                LP.DUE_VALUE due_value, 
                LP.PRESENT_VALUE present_value, 
                C.FINE_FOR_DELAY fine_for_delay, 
                C.END_DATE contract_end_date, 
                C.DOCUMENT_NUMBER document_number 
        FROM LOAN_FLOWS_LATE_PAYMENT lp
        LEFT JOIN LOAN_CONTRACTS_TB c
        	ON C.CONTRACT_ID = LP.CONTRACT_ID
        EMIT CHANGES;


CREATE STREAM LOAN_FLOWS_LATE_PAYMENT_ENRICHED_BY_PERSON AS
       SELECT   CONTRACT_ID contract_id, 
                INSTALLMENT_NUMBER installment_number, 
                STATUS status, 
                DUE_DATE due_date, 
                DUE_VALUE due_value, 
                PRESENT_VALUE present_value, 
                FINE_FOR_DELAY fine_for_delay, 
                CONTRACT_END_DATE contract_end_date, 
                P.DOCUMENT_NUMBER document_number,
                P.NAME name,
                P.PERSON_ID person_id,
                P.EMAIL email
        FROM LOAN_FLOWS_LATE_PAYMENT_ENRICHED_BY_CONTRACT LPC
        LEFT JOIN PERSON_TB P
        	ON LPC.DOCUMENT_NUMBER = P.DOCUMENT_NUMBER
        EMIT CHANGES;

CREATE STREAM LOAN_FLOWS_LATE_PAYMENT_ENRICHED_COMPLETE
    WITH (kafka_topic='loan_flows_late_payment_enriched') AS
        SELECT  CONTRACT_ID contract_id, 
                INSTALLMENT_NUMBER installment_number, 
                STATUS status, 
                DUE_DATE due_date, 
                DUE_VALUE due_value, 
                PRESENT_VALUE present_value, 
                FINE_FOR_DELAY fine_for_delay, 
                CONTRACT_END_DATE contract_end_date, 
                LPP.DOCUMENT_NUMBER document_number, 
                PERSON_ID person_id, 
                ACCOUNT_NUMBER account_number,
                NAME name, EMAIL email
        FROM LOAN_FLOWS_LATE_PAYMENT_ENRICHED_BY_PERSON LPP
        LEFT JOIN  BANK_ACCOUNTS_TB AC
        	ON LPP.DOCUMENT_NUMBER = AC.DOCUMENT_NUMBER
        EMIT CHANGES;



