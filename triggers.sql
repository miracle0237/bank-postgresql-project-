-- Создаем таблицу логов
CREATE TABLE account_logs (
    id SERIAL PRIMARY KEY,
    account_id INT,
    old_balance NUMERIC,
    new_balance NUMERIC,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Функция триггера
CREATE OR REPLACE FUNCTION log_balance_change()
RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO account_logs(account_id, old_balance, new_balance)
    VALUES (OLD.id, OLD.balance, NEW.balance);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Триггер
CREATE TRIGGER balance_update_trigger
AFTER UPDATE ON accounts
FOR EACH ROW
WHEN (OLD.balance IS DISTINCT FROM NEW.balance)
EXECUTE FUNCTION log_balance_change();
