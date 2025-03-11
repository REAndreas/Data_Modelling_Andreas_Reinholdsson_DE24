SET search_path TO ezcream_05;

TRUNCATE TABLE orders RESTART IDENTITY;

INSERT INTO orders(customer_id, order_date)
VALUES
    (2, '2024-05-04'),
    (50, '900-02-05');

--DELETE FROM ezcream_05.orders WHERE customer_id = 50;

SELECT * FROM ezcream_05.orders;