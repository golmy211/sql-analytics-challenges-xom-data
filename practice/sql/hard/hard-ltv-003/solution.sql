-- Xom Data · How much is the first 90 days of life worth
-- Problem: https://xomdata.com/practice/hard-ltv-003
-- Solved: 2026-11-03

with s as(
    select 
        customer_id,
        min(order_date) as first_date
    from orders
    group by 1  
),
f as(
    select 
        s.customer_id,
        to_char(cast(s.first_date as date),'YYYY-MM') as cohort_month,
        sum(o.amount) as revenue
    from s 
    join orders o on s.customer_id = o.customer_id
    where cast(o.order_date as date ) - cast(s.first_date as date) <= 90 
    group by 1,2
)

select 
    cohort_month,
    count(distinct customer_id) as cohort_size,
    round(avg(revenue),2) as avg_ltv_90d
from f
group by 1
