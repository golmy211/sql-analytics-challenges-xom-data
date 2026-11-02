-- Xom Data · Customers silent for 90 days
-- Problem: https://xomdata.com/practice/hard-anti-001
-- Solved: 2026-11-02

with s as(
    select 
        user_id,
        max(order_date) as last_order_date
    from orders
    group by 1

),
f as(
    select 
        o.user_id,
        s.last_order_date,
        max(o.order_date)over() as max_date 
    from orders o 
    join s on o.user_id = s.user_id

),
a as (
    select 
        distinct user_id,
        last_order_date,
        cast(max_date as date) - cast(last_order_date as date) as days_since_last
    from f 
)

select 
* 
from a
where days_since_last >= 90 
order by days_since_last desc, user_id asc
