-- Xom Data · Mapping the distribution of quiet gaps
-- Problem: https://xomdata.com/practice/hard-gap-005
-- Solved: 2026-10-30

with s as (
    select 
        customer_id,
        order_date,
        lag(order_date)over(
            partition by customer_id
            order by order_date asc, order_id
        ) as prev_date
    from orders 
),
a as (
    select 
        customer_id,
        cast(order_date as date) - cast(prev_date as date) as gap_days
    from s 
),
f as (
    select 
        case when gap_days between 0 and 7 then '0-7d'
            when gap_days between 8 and 30 then '8-30d'
            when gap_days between 31 and 90 then '31-90d'
            else '90d+'
            end as gap_bucket,
        count(*) as gap_count,
        min(gap_days) as sort_key
    from a
    where gap_days is not null
    group by 1
)

select 
    gap_bucket,
    gap_count,
    round(gap_count * 100.00/sum(gap_count)over(),2) as share_pct
from f
order by sort_key
