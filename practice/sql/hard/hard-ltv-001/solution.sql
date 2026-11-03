-- Xom Data · Average lifetime value by cohort
-- Problem: https://xomdata.com/practice/hard-ltv-001
-- Solved: 2026-11-03

with s as (
    select 
        customer_id,
        TO_CHAR(cast(min(order_date)as date),'YYYY-MM') as cohort_month,
        sum(amount) as revenue
    from orders
    group by 1  
),
f as(

    select 
        cohort_month,
        count(*) as cohort_size,
        round(avg(revenue),2) as avg_ltv
    from s
    group by 1
)


select * 
from f
order by cohort_month asc
