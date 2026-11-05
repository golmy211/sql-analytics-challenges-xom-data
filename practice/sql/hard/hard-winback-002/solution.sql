-- Xom Data · Counting comebacks each month
-- Problem: https://xomdata.com/practice/hard-winback-002
-- Solved: 2026-11-05

with s as (
    select 
        customer_id,
        order_date,
        lag(order_date)over(partition by customer_id order by order_date) as prev_date,
        CAST(TO_CHAR(cast(order_date as date),'YYYY') AS INTEGER) * 12 + CAST(TO_CHAR(cast(order_date as date),'MM') AS INTEGER) as cidx 
    from orders 
),
f as (
    select
        customer_id,
        TO_CHAR(cast(order_date as date),'YYYY-MM') as month,
        cidx,
        CAST(TO_CHAR(cast(prev_date as date),'YYYY')AS INTEGER)*12 + CAST(TO_CHAR(cast(prev_date as date),'MM')AS INTEGER) as fidx 
    from s 
)

select 
    month,
    count(distinct customer_id) as resurrected_customers
 from f
 where cidx - fidx > 2 
 group by 1
 order by month
