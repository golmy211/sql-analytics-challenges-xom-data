-- Xom Data · Repeat-customer tracking table by cohort
-- Problem: https://xomdata.com/practice/hard-cohort-002
-- Solved: 2026-10-28

with s as(
    select 
        customer_id,
        TO_CHAR(cast(min(order_date) as date),'YYYY-MM') as cohort_month,
        cast(to_char(cast(min(order_date) as date),'YYYY')as INTEGER) * 12 
        + cast(to_char(cast(min(order_date) as date),'MM')as INTEGER) as cidx 
    from orders 
    group by 1
),
f as (
    select 
        cohort_month,
        count(distinct customer_id) as m0
    from s
    group by 1
),
m1 as (
    select 
        s.cohort_month,
        count(distinct S.customer_id) as m0,
        COALESCE(COUNT(case 
            when cast(to_char(cast(o.order_date as date),'YYYY')as INTEGER) * 12  +  cast(to_char(cast(o.order_date as date),'MM')as INTEGER) = s.cidx + 1
            then o.customer_id end),0)as m1,
         COALESCE(COUNT(case 
            when cast(to_char(cast(o.order_date as date),'YYYY')as INTEGER) * 12  +  cast(to_char(cast(o.order_date as date),'MM')as INTEGER) = s.cidx + 2
            then o.customer_id end),0)as m2,
         COALESCE(COUNT(case 
            when cast(to_char(cast(o.order_date as date),'YYYY')as INTEGER) * 12  +  cast(to_char(cast(o.order_date as date),'MM')as INTEGER) = s.cidx + 3
            then o.customer_id end),0)as m3
    from orders o
    join s on o.customer_id = s.customer_id
    group by 1
)
select * 
from m1
