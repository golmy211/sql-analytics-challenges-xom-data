-- Xom Data · A Picture of Engagement Distribution
-- Problem: https://xomdata.com/practice/medium-frequency-004
-- Solved: 2026-10-01

with cus_order as (
    select
        customer_id,
        count(*) as order_cnt
    from orders
    group by customer_id
)
select
    case
        when order_cnt = 1 then '1 order'
        when order_cnt = 2 then '2 orders'
        else '3+ orders'
    end as engagement_bucket,
    count(*) as customer_count
from cus_order
group by 1
order by min(order_cnt);
