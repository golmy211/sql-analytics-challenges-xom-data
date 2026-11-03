-- Xom Data · Churned and returning customers
-- Problem: https://xomdata.com/practice/hard-churn-001
-- Solved: 2026-11-03

with s as (
    select 
        user_id,
        order_date,
        lead(order_date)over(
            partition by user_id
            order by order_date asc
        ) as next_order
    from orders
),
f as (
    select
        user_id,
        order_date as prev_order,
        next_order,
        cast(next_order as date) - cast(order_date as date) as gap_days
    from s 
    where  cast(next_order as date) - cast(order_date as date) >= 90
)
select * 
from f
order by gap_days desc, user_id
