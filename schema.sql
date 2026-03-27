-- Клиенты
CREATE TABLE clients (
    id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Счета
CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    client_id INT REFERENCES clients(id),
    balance NUMERIC(12,2) DEFAULT 0 CHECK (balance >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Транзакции
CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    from_account INT,
    to_account INT,
    amount NUMERIC(12,2) NOT NULL CHECK (amount > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
