-- Xom Data · Customer Freshness Leaderboard
-- Problem: https://xomdata.com/practice/medium-recency-003
-- Solved: 2026-10-03

with topp as (
select
    customer_id,
    max(order_date) as last_order_date
from orders 
group by 1 
)
select 
    customer_id,
    last_order_date,
    rank()over(
        order by last_order_date desc
    ) as freshness_rank
from topp
order by freshness_rank asc, customer_id asc
