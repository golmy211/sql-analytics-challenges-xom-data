-- Xom Data · The store's all-time loyalty record holder
-- Problem: https://xomdata.com/practice/hard-streak-004
-- Solved: 2026-11-15

with s as(
    select 
        customer_id,
        to_char(cast(order_date as date),'YYYY-MM') as month,
        cast(to_char(cast(order_date as date),'YYYY') as integer) * 12 +   cast(to_char(cast(order_date as date),'MM') as integer) - ROW_NUMBER()over(PARTITION BY customer_id order by order_date) as grp 
    from orders 
),
f as (
    select 
        customer_id,
        count(*) as record_streak,
        min(month) as streak_start,
        max(month) as streak_end
    from s 
    group by customer_id,grp 
),
r as (
    select *,
            ROW_NUMBER()over(order by record_streak desc,customer_id) as rn 
    from f
)
select customer_id, record_streak, streak_start, streak_end
from r
where rn = 1
order by record_streak desc, customer_id asc
limit 1
