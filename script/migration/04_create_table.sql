CREATE TABLE accounts (id uuid, email varchar, password varchar);
CREATE TABLE sessions (id uuid, account_id uuid, creation_date timestamp);