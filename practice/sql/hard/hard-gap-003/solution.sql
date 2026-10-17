-- Xom Data · Predicting the customer's next visit date
-- Problem: https://xomdata.com/practice/hard-gap-003
-- Solved: 2026-10-17

with s as (
    select 
        customer_id,
        order_date,
        lead(order_date)over(
            partition by customer_id
            order by order_date asc, order_id asc
        ) as next_date
    from orders 
), 
agg as (
    select 
        customer_id,
        max(order_date) as last_order_date,
        floor(avg(next_date::date - order_date::date))::int as avg_gap_days
    from s 
    group by customer_id
    having count(next_date) > 0

)

select 
    customer_id,
    last_order_date,
    avg_gap_days,
    (last_order_date::date + avg_gap_days)::text as predicted_next_date
from agg 
order by predicted_next_date asc, customer_id asc
