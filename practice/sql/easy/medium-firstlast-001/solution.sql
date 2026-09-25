-- Xom Data · Each customer's first and most recent order
-- Problem: https://xomdata.com/practice/medium-firstlast-001
-- Solved: 2026-09-25

select
    customer_id,
    min(order_date) as first_order_date,
    max(order_date) as last_order_date
from orders 
group by 1
order by customer_id
