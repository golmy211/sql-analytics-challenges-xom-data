-- Xom Data · Purchase rhythm and churn signal
-- Problem: https://xomdata.com/practice/hard-gap-001
-- Solved: 2026-10-26

with s as (
    select 
        customer_id,
        order_date,
        lag(order_date)over(
            partition by customer_id
            order by order_date 
        ) as next_order_date
    from orders 

),
agg as (
    select 
        customer_id,
        round(cast(next_order_date as date) - cast(order_date as date),1) as avg_days
    from s 
) 
    select 
        customer_id,
        abs(round(avg(avg_days),1)) as avg_gap_days,
        case 
            when  abs(round(avg(avg_days),1)) is null then 'single'
            when  abs(round(avg(avg_days),1)) <= 30 then 'fast'
            else 'slow'
            end as pace
    from agg 
    group by customer_id
