-- Xom Data · What the First Impression Was Worth
-- Problem: https://xomdata.com/practice/medium-firstlast-003
-- Solved: 2026-10-03

select 
    distinct customer_id,
    first_value(order_date)over(
        partition by customer_id
        order by order_date asc 
    ) as first_order_date,
    first_value(amount)over(
        partition by customer_id
        order by order_date asc 
    ) as first_amount
from orders 
order by customer_id asc
