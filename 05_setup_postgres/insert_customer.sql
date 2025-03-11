SET search_path TO ezcream_05;

INSERT INTO customer (first_name, last_name, email, address)
VALUES
    (
        'Ragnar',
        'Lothbrok',
        'ragnar@kattegat.com',
        '1 Valhalla Way'
    ),
    (
        'Lagertha',
        'Lothbrok',
        'lagertha@kattegat.com',
        '2 Shieldmaiden Road'
    ),
    (
        'Bjorn',
        'Ironside',
        'bjorn@kattegat.com',
        '3 Viking Bay'
    ),
    (
        'Ivar',
        'the Boneless',
        'ivar@danes.com',
        '4 The Great Heathen Army Camp'
    );

INSERT INTO ezcream_05.customer (customer_id, first_name, last_name, email, address)
VALUES
    (
        50,
        'Ubbe',
        'Lothbrok',
        'ragnar@kattegat.com',
        '1 Valhalla Way'
    );

DELETE FROM ezcream_05.customer WHERE customer_id = 50;

SELECT * FROM ezcream_05.customer;