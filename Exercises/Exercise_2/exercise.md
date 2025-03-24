## 0. Ezcream orders

A)
    everything in the same table, no price, duplicate data

B1)
    tuples depends on different attributes, prmiary key has solo dependency in this case it does not cause
    one order is connected to several products. Does not conform to 2NF

B2)
    customer -> customer_id, name, address
    order -> order_id, order_date, customer_id
    orderline -> order_id, product_id, quantity
    product -> product_id, product_name

C)
    if added only as an attribute the past orders would also change in total price