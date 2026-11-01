-- Xom Data · First three-month return-rate matrix
-- Problem: https://xomdata.com/practice/hard-retention-004
-- Solved: 2026-11-01

with s as (
    select 
        customer_id,
        order_date,
        CAST(to_char(cast(order_date as date),'YYYY')AS INTEGER)*12 +  CAST(to_char(cast(order_date as date),'MM')AS INTEGER) as cidx 
    from orders 
    group by 1,2
),
o as (
     select 
        customer_id,
        min(order_date) as cohort_month,
        CAST(to_char(cast(min(order_date) as date),'YYYY')AS INTEGER)*12 +  CAST(to_char(cast(min(order_date) as date),'MM')AS INTEGER) as fidx 
    from orders 
    group by 1
),
f as (
    SELECT
        TO_CHAR(cast(o.cohort_month as date),'YYYY-MM') as cohort_month,
        count(distinct o.customer_id) as cohort_size,
        count(distinct case when s.cidx = o.fidx then o.customer_id end) as m0,
        count(distinct case when s.cidx = o.fidx + 1 then o.customer_id end) as m1,
        count(distinct case when s.cidx = o.fidx + 2 then o.customer_id end) as m2
    from s 
    join o on s.customer_id = o.customer_id
    group by 1
)
select 
    cohort_month,
    cohort_size,
    round(m0 * 100.00/cohort_size,2) as m0_pct,
    round(m1 * 100.00/cohort_size,2) as m1_pct,
    round(m2 * 100.00/cohort_size,2) as m2_pct
from f  
order by cohort_month asc
