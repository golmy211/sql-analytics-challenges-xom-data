-- Xom Data · How much is left after one month
-- Problem: https://xomdata.com/practice/hard-retention-002
-- Solved: 2026-10-28

with s as (
    select
        customer_id,
        min(order_date) as first_date
    from orders
    group by 1
),

c as (
    select
        customer_id,
        substring(first_date, 1, 7) as cohort_month,
        cast(substring(first_date, 1, 4) as integer) * 12
          + cast(substring(first_date, 6, 2) as integer) as cidx
    from s
),
m as (
    select distinct
        customer_id,
        cast(substring(order_date, 1, 4) as integer) * 12
          + cast(substring(order_date, 6, 2) as integer) as midx
    from orders
)
select 
    c.cohort_month,
    count(distinct c.customer_id) as cohort_size,
    count(distinct case when m.midx = c.cidx + 1 then c.customer_id end) as retained_m1,
    round(100.0*(count(distinct case when m.midx = c.cidx + 1 then c.customer_id end))/count(distinct c.customer_id),2) as retention_pct
from m
join c on m.customer_id = c.customer_id
group by 1 
order by cohort_month asc
