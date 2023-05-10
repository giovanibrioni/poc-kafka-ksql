       --Fluxos de Pacelas
       SELECT contract_id, 
                installment_number, 
                status, 
                present_value
        FROM LOAN_FLOWS
        EMIT CHANGES;

        --Contratos devedores cobrança
       SELECT contract_id, 
                installment_number, 
                status, 
                present_value
        FROM LOAN_FLOWS_LATE_PAYMENT
        EMIT CHANGES;

       --Contratos devedores enriquecidos cobrança
       SELECT contract_id, 
                installment_number, 
                status, 
                present_value, 
                name,
                account_number 
        FROM LOAN_FLOWS_LATE_PAYMENT_ENRICHED_COMPLETE
        EMIT CHANGES;
       
        --Agrupamento de fluxos para squad de risco
        SELECT  TIMESTAMPTOSTRING( due_date , 'yyyy-MM-dd') as due_date,
                status, 
                COUNT(*) AS installments_by_status, 
                SUM(present_value) AS present_value 
        FROM LOAN_FLOWS_TB 
        GROUP BY due_date, status
        EMIT CHANGES;

