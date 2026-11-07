-- Xom Data · Do comeback orders run bigger?
-- Problem: https://xomdata.com/practice/hard-winback-003
-- Solved: 2026-11-07

with s as(
    select 
        customer_id,
        CAST(to_char(cast(order_date as date),'YYYY')AS INTEGER) * 12 + CAST(to_char(cast(order_date as date),'MM')AS INTEGER) as cidx,
        amount
    from orders 
),
f as (
    select 
        customer_id,
        cidx,
        lag(cidx)over(PARTITION BY customer_id order by cidx,customer_id) as prev_cidx,
        amount
    from s 
),
a as (
    select 
        COALESCE(count(*),0) as winback_orders,
        round(avg(amount),2) as avg_winback_amount

    from f 
    where cidx >= prev_cidx + 2 
    
),
g as (
    select 
        count(*) as normal_orders,
        round(avg(amount),2) as avg_normal_amount
    from f
    where prev_cidx is null or cidx < prev_cidx + 2
)

select 
    *
from a 
join g on true
