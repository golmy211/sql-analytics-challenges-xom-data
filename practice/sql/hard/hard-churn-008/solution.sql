-- Xom Data · Customer base growth accounting ledger
-- Problem: https://xomdata.com/practice/hard-churn-008
-- Solved: 2026-10-29

with a as (
    select distinct
        customer_id,
        to_char(cast(order_date as date),'YYYY-MM') as month,
        cast(to_char(cast(order_date as date),'YYYY') as integer) * 12
          + cast(to_char(cast(order_date as date),'MM') as integer) as midx
    from orders
),
l as (
    select
        customer_id,
        month,
        midx,
        lag(midx)  over (partition by customer_id order by midx) as prev_midx,
        lead(midx) over (partition by customer_id order by midx) as next_midx 
    from a
),
ch as (
    select
        midx + 1 as midx,
        count(distinct customer_id) as churned
    from l
    where next_midx is null or next_midx > midx + 1
    group by 1
),
agg as (
    select
        l.month,
        count(distinct case when prev_midx is null then l.customer_id end) as new_customers,
        count(distinct case when prev_midx < l.midx - 1 then l.customer_id end) as resurrected,
        coalesce(max(ch.churned), 0) as churned
    from l
    left join ch on ch.midx = l.midx
    group by 1
)
select *,
    new_customers + resurrected - churned as net_change
from agg
order by month
