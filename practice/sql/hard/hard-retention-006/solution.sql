-- Xom Data · Retention ledger triangle
-- Problem: https://xomdata.com/practice/hard-retention-006
-- Solved: 2026-11-12

with s as(
    select 
        customer_id,
        min(order_date) as first_date
    from orders
    group by 1 
),
f as (
    select 
        s.customer_id,
        TO_CHAR(cast(s.first_date as date),'YYYY-MM') as cohort_month,
        CAST(TO_CHAR(cast(s.first_date as date),'YYYY') AS INTEGER)* 12 + CAST(TO_CHAR(cast(s.first_date as date),'MM') AS INTEGER) as fidx,
        CAST(TO_CHAR(cast(o.order_date as date),'YYYY') AS INTEGER)* 12 + CAST(TO_CHAR(cast(o.order_date as date),'MM') AS INTEGER) as cidx
    from orders o 
    join s on o.customer_id = s.customer_id
),
c as (
    select 
        cohort_month,
        count(distinct customer_id) as cohort_size
    from f 
    group by 1 
),
a as (
    select 
        cohort_month,
        cidx - fidx as month_age,
        count(distinct customer_id) as retained

    from f
    group by 1,2
)


select 
    a.cohort_month,
    a.month_age,
    c.cohort_size,
    a.retained,
    round(a.retained * 100.0/c.cohort_size,2) as retention_pct
from c
join a on c.cohort_month = a.cohort_month
order by 1,2
