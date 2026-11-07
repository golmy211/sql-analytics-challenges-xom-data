-- Xom Data · Monthly customer churn rate
-- Problem: https://xomdata.com/practice/hard-churn-003
-- Solved: 2026-11-07

with s as (
    select 
        distinct customer_id,
        TO_CHAR(cast(order_date as date),'YYYY-MM') as month,
        CAST(TO_CHAR(cast(order_date as date),'YYYY')AS INTEGER) * 12 + CAST(TO_CHAR(cast(order_date as date),'MM')AS INTEGER) AS cidx
    from orders 
),
f as (
    select 
        month,
        customer_id,
        cidx,
        lead(cidx)over(
            PARTITION BY customer_id
            order by cidx
        ) as next_cidx
    from s 
),
a as (
select 
    month,
    count(distinct customer_id) as active_customers,
    count(distinct case when next_cidx > cidx + 1 or next_cidx is null then customer_id end) as churned_customers
from f
where month < (SELECT max(month) from f)
group by 1
)
select 
    month,
    active_customers,
    churned_customers,
    round(churned_customers * 100.00/ active_customers,2) as churn_rate_pct
from a
