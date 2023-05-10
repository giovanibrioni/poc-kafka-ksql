select  TIMESTAMPTOSTRING( LAST_UPDATE_DATE , 'yyyy-MM-dd HH:mm:ss') LAST_UPDATE_DATE, 
        document_number, 
        person_id, 
        name, 
        email, 
        type, 
        address, 
        phone
from EV_PERSON_INDIVIDUAL_TRANSFORMED emit changes;

select TIMESTAMPTOSTRING( LAST_UPDATE_DATE , 'yyyy-MM-dd HH:mm:ss') LAST_UPDATE_DATE, 
        document_number, 
        person_id, 
        name, 
        email, 
        type, 
        address, 
        phone
from PERSON_TB LIMIT 10;