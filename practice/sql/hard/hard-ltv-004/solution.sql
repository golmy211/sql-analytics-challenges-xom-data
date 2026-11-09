-- Xom Data · How much of a customer's life is the first month
-- Problem: https://xomdata.com/practice/hard-ltv-004
-- Solved: 2026-11-09

with s as (
    select 
        customer_id,
        TO_CHAR(cast(min(order_date)as date),'YYYY-MM') as cohort_month
    from orders
    group by 1
),
a as (
    select 
       s.cohort_month,
       sum(amount) as first_month_revenue
    from s
    join orders o on s.customer_id = o.customer_id
    and s.cohort_month = TO_CHAR(cast(o.order_date as date),'YYYY-MM')
    group by 1

),
f as (
    select 
        s.cohort_month,
        sum(o.amount) as lifetime_revenue
    from s
    join orders o on s.customer_id = o.customer_id
    group by 1 
)

select 
    a.cohort_month,
    a.first_month_revenue,
    f.lifetime_revenue,
    round(a.first_month_revenue * 100.0/f.lifetime_revenue,2) as first_month_share_pct
from a
join f on a.cohort_month = f.cohort_month
order by 1
