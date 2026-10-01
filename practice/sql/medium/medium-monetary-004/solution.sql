-- Xom Data · Each Customer's Record-Setting Order
-- Problem: https://xomdata.com/practice/medium-monetary-004
-- Solved: 2026-10-01

with cus_rank as (
select
    customer_id,
    order_id,
    order_date,
    amount,
    row_number()over(
        partition by customer_id
        order by amount desc, order_date asc, order_id asc
    )as rn
from orders 
)
select 
    customer_id,
    order_id,
    order_date,
    amount
from cus_rank
where rn = 1 
order by customer_id asc
