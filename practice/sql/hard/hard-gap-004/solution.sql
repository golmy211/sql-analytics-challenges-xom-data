-- Xom Data · An unusually long absence
-- Problem: https://xomdata.com/practice/hard-gap-004
-- Solved: 2026-10-31

with s as (
    select 
        customer_id,
        order_date,
        lag(order_date)over(PARTITION BY customer_id order by order_date asc) as prev_date
    from orders 
),
a as (

    select 
        customer_id,
        prev_date as gap_start,
        order_date as gap_end,
        cast(order_date as date) - cast(prev_date as date) as gap_days
    from s 
    where cast(order_date as date) - cast(prev_date as date) is not null
),
f as (
    select 
        customer_id,
        gap_start,
        gap_end,
        gap_days,
        avg(gap_days) over ( partition by customer_id) as avg_gap,
        count(*) over (partition by customer_id) as order_count
    from a
   
)
select
        customer_id,
        gap_start,
        gap_end,
        gap_days,
        round(avg_gap,2) as avg_gap
from f
where order_count >= 2 and gap_days > 2*avg_gap
