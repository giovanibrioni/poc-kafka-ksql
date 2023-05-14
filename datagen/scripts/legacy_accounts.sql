CREATE EXTENSION pgcrypto;

CREATE TABLE IF NOT EXISTS legacy_accounts
(
    ID SERIAL PRIMARY KEY,
    CD_CLIENTE TEXT NOT NULL,
    CD_AGENCIA TEXT NOT NULL,
    CD_CONTA TEXT NOT NULL,
    DS_STATUS TEXT NOT NULL,
    DT_ABERTURA TIMESTAMPTZ NOT NULL,
    DT_ULT_ALTERACAO TIMESTAMPTZ NOT NULL
);

INSERT INTO legacy_accounts(CD_CLIENTE , CD_AGENCIA ,CD_CONTA, DS_STATUS, DT_ABERTURA, DT_ULT_ALTERACAO) values ('14897275903','1','13500','BLOCKED','2021-01-01', CURRENT_TIMESTAMP);
INSERT INTO legacy_accounts(CD_CLIENTE , CD_AGENCIA ,CD_CONTA, DS_STATUS, DT_ABERTURA, DT_ULT_ALTERACAO) values ('32018409042','1','13501','CLOSED','2021-02-02', CURRENT_TIMESTAMP);
INSERT INTO legacy_accounts(CD_CLIENTE , CD_AGENCIA ,CD_CONTA, DS_STATUS, DT_ABERTURA, DT_ULT_ALTERACAO) values ('39079931870','1','13502','ACTIVE','2021-02-03', CURRENT_TIMESTAMP);
INSERT INTO legacy_accounts(CD_CLIENTE , CD_AGENCIA ,CD_CONTA, DS_STATUS, DT_ABERTURA, DT_ULT_ALTERACAO) values ('77650851000104','1','13503','ACTIVE','2021-03-04', CURRENT_TIMESTAMP);
INSERT INTO legacy_accounts(CD_CLIENTE , CD_AGENCIA ,CD_CONTA, DS_STATUS, DT_ABERTURA, DT_ULT_ALTERACAO) values ('18131546000147','1','13504','ACTIVE','2021-03-05', CURRENT_TIMESTAMP);
INSERT INTO legacy_accounts(CD_CLIENTE , CD_AGENCIA ,CD_CONTA, DS_STATUS, DT_ABERTURA, DT_ULT_ALTERACAO) values ('21666098051','1','13505','ACTIVE','2021-03-06', CURRENT_TIMESTAMP);
INSERT INTO legacy_accounts(CD_CLIENTE , CD_AGENCIA ,CD_CONTA, DS_STATUS, DT_ABERTURA, DT_ULT_ALTERACAO) values ('65477328860','1','13506','ACTIVE','2021-03-07', CURRENT_TIMESTAMP);