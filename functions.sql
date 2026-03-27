CREATE OR REPLACE FUNCTION transfer_money(
    sender INT,
    receiver INT,
    transfer_amount NUMERIC
)
RETURNS VOID AS
$$
BEGIN
    -- Проверка баланса
    IF (SELECT balance FROM accounts WHERE id = sender) < transfer_amount THEN
        RAISE EXCEPTION 'Недостаточно средств';
    END IF;

    -- Списание
    UPDATE accounts
    SET balance = balance - transfer_amount
    WHERE id = sender;

    -- Пополнение
    UPDATE accounts
    SET balance = balance + transfer_amount
    WHERE id = receiver;

    -- Запись транзакции
    INSERT INTO transactions (from_account, to_account, amount)
    VALUES (sender, receiver, transfer_amount);

END;
$$ LANGUAGE plpgsql;
