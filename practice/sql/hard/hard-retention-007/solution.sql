-- Xom Data · Returning right on schedule at month n
-- Problem: https://xomdata.com/practice/hard-retention-007
-- Solved: 2026-11-01

with s as (
    select
        customer_id,
        TO_CHAR(cast(order_date as date),'YYYY-MM') as cohort_month,
        CAST(TO_CHAR(CAST(order_date AS DATE),'YYYY')AS INTEGER)* 12 + CAST(TO_CHAR(CAST(order_date as DATE),'MM') AS INTEGER) as cidx
    from orders 
),
f as (
select 
    customer_id,
    min(cohort_month) as first_date,
    min(cidx) as first_cidx
from s
group by 1
),

a as (
    select
        f.first_date as cohort_month,
        count(distinct s.customer_id) as cohort_size,
        count(distinct case when s.cidx = f.first_cidx + 1 then s.customer_id end) as m1,
        count(distinct case when s.cidx = f.first_cidx + 2 then s.customer_id end) as m2,
        count(distinct case when s.cidx = f.first_cidx + 3 then s.customer_id end) as m3
    from s
    join f on s.customer_id = f.customer_id
    group by 1
    order by 1 asc
)
select 
    *
from a
