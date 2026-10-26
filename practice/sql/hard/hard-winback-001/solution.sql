-- Xom Data · Those who returned after two months of silence
-- Problem: https://xomdata.com/practice/hard-winback-001
-- Solved: 2026-10-26

with s as (
    select 
        customer_id,
        order_date,
        lag(order_date) over (
            partition by customer_id
            order by order_date asc
        ) as prev_date 
    from orders 
)

    select 
        customer_id,
        order_date,
        cast(order_date as date) - cast(prev_date as date) as gap_days 
    from s 
    where prev_date is not null and cast(order_date as date) - cast(prev_date as date) >= 60
