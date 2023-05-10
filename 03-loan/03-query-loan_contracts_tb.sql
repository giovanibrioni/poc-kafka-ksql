SELECT document_number, 
        contract_id, 
        product, 
        status
FROM LEGACY_LOAN_CONTRACTS_TRANSFORMED EMIT CHANGES;

SELECT  TIMESTAMPTOSTRING( last_update_date , 'yyyy-MM-dd HH:mm:ss') last_update_date, 
        document_number, 
        contract_id, 
        product, 
        status, 
        TIMESTAMPTOSTRING( start_date , 'yyyy-MM-dd HH:mm:ss') start_date,
        TIMESTAMPTOSTRING( end_date , 'yyyy-MM-dd HH:mm:ss') end_date,
        interest_rate, fine_for_delay, total_installments
FROM LOAN_CONTRACTS_TB EMIT CHANGES;