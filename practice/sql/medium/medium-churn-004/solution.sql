-- Xom Data · The blacklist of long-silent customers
-- Problem: https://xomdata.com/practice/medium-churn-004
-- Solved: 2026-10-16

select 
    customer_id,
    max(order_date) as last_order_date,
    ('2024-06-30')::date - max(order_date)::date as days_silent
from orders 
group by 1 
having ('2024-06-30')::date - max(order_date)::date > 90 
order by days_silent desc, customer_id asc
