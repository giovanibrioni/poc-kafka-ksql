curl -X POST -H "Content-Type: application/vnd.kafka.json.v2+json" \
      -H "Accept: application/vnd.kafka.v2+json" \
      --data '{"records": [
    {"value": {"class": "individual","person_id": "individual-1","individual": {"name": "Nome Cliente 1","cpf": "14897275903","email": "email_cliente_1@gmail.com","politically_exposed_person": true,"address": {"address_id": 1,"type": "Rua","zip_code": "00000001","street": "Rua 1","number": "1","complement": "Casa","reference_point": "Supermercado Paulista","neighborhood": "Jardim Paulista","city": "Barueri","state": "São Paulo","country": "Brasil","primary": true},"phone": {"phone_id": 1,"type": "Celular","area_code": "11","country_code": "55","number": "911111111","primary": true},"person_id": "individual-1","status": "Aprovada"}}},
    {"value": {"class": "individual","person_id": "individual-2","individual": {"name": "Nome Cliente 2","cpf": "39079931870","email": "email_cliente_2@gmail.com","politically_exposed_person": true,"address": {"address_id": 2,"type": "Rua","zip_code": "00000002","street": "Rua 2","number": "2","complement": "Casa","reference_point": "Supermercado Paulista","neighborhood": "Jardim Paulista","city": "Barueri","state": "São Paulo","country": "Brasil","primary": true},"phone": {"phone_id": 2,"type": "Celular","area_code": "22","country_code": "55","number": "922222222","primary": true},"person_id": "individual-2","status": "Aprovada"}}},
    {"value": {"class": "individual","person_id": "individual-3","individual": {"name": "Nome Cliente 3","cpf": "21666098051","email": "email_cliente_3@gmail.com","politically_exposed_person": true,"address": {"address_id": 3,"type": "Rua","zip_code": "00000003","street": "Rua 3","number": "3","complement": "Casa","reference_point": "Supermercado Paulista","neighborhood": "Jardim Paulista","city": "Barueri","state": "São Paulo","country": "Brasil","primary": true},"phone": {"phone_id": 3,"type": "Celular","area_code": "33","country_code": "55","number": "933333333","primary": true},"person_id": "individual-3","status": "Aprovada"}}},
    {"value": {"class": "individual","person_id": "individual-4","individual": {"name": "Nome Cliente 4","cpf": "65477328860","email": "email_cliente_4@gmail.com","politically_exposed_person": true,"address": {"address_id": 4,"type": "Rua","zip_code": "00000004","street": "Rua 4","number": "4","complement": "Casa","reference_point": "Supermercado Paulista","neighborhood": "Jardim Paulista","city": "Barueri","state": "São Paulo","country": "Brasil","primary": true},"phone": {"phone_id": 4,"type": "Celular","area_code": "44","country_code": "55","number": "944444444","primary": true},"person_id": "individual-4","status": "Aprovada"}}}
]}' "http://localhost:8082/topics/ev_person_individual"