-- Xom Data · A risk detector tuned to each person's habit
-- Problem: https://xomdata.com/practice/hard-churn-006
-- Solved: 2026-11-06

with s as(
    select
        customer_id,
        order_date,
        lead(order_date)over(PARTITION BY customer_id order by order_date) as next_order
    from orders 
    where order_date <= '2024-06-30'
),
f as (
    select 
        customer_id,
        order_date,
        next_order,
        cast(next_order as date) - cast(order_date as date) as gap_days
    from s
), 
a as (
select
    customer_id,
    cast('2024-06-30' as date) - cast(max(order_date) as date) as days_silent,
    round(avg(gap_days),2) as avg_gap,
    case when count(*) = 1 then 'unknown'
        when cast('2024-06-30' as date) - cast(max(order_date) as date) > 1.5 * round(avg(gap_days),2) then 'at_risk'
        else 'healthy'
        end as risk
from f
group by 1
) 
select
    *
from a
