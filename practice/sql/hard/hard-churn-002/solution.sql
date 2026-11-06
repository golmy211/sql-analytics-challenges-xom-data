-- Xom Data · How many of last month's customers are lost this month
-- Problem: https://xomdata.com/practice/hard-churn-002
-- Solved: 2026-11-06

with s as (
    select  
        distinct customer_id,
        TO_CHAR(cast(order_date as date),'YYYY-MM') as month,
        CAST(TO_CHAR(cast(order_date as date),'YYYY')AS INTEGER) * 12 + CAST(TO_CHAR(cast(order_date as date),'MM')AS INTEGER) as cidx 
    from orders 
), 
f as (
    select 
        month,
        customer_id,
        cidx,
        lead(cidx) over(PARTITION BY customer_id order by cidx ) as next_cidx
    from s 
)
select 
    month,
    count(case when next_cidx is null or next_cidx <> cidx + 1 then customer_id end) as churned_customers
from f
where cidx < (select max(cidx) from s)
group by 1 
order by month
