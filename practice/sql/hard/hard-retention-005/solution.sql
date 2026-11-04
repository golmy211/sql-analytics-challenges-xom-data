-- Xom Data · Surviving from the second month onward
-- Problem: https://xomdata.com/practice/hard-retention-005
-- Solved: 2026-11-04

with s as (
    select 
        customer_id,
        min(order_date) as first_date
    from orders
    group by 1 
),
f as (
    select 
        s.customer_id,
        to_char(cast(s.first_date as date),'YYYY-MM') as cohort_month,
        CAST(to_char(cast(s.first_date as date),'YYYY')AS INTEGER) * 12 + CAST(to_char(cast(s.first_date as date),'MM')AS INTEGER) as fidx,
        CAST(to_char(cast(o.order_date as date),'YYYY')AS INTEGER) * 12 + CAST(to_char(cast(o.order_date as date),'MM')AS INTEGER) as cidx
    from s 
    join orders o on s.customer_id = o.customer_id
)

select 
    cohort_month,
    count(distinct customer_id) as cohort_size,
    count(distinct case when cidx - fidx >= 2 then customer_id end) as survivors,
    round(count(distinct case when cidx - fidx >= 2 then customer_id end) * 100.0/count(distinct customer_id),2) as survival_pct
from f
group by 1
order by 1
