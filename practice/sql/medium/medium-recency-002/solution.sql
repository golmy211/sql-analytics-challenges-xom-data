-- Xom Data · Thirty Days of Absence
-- Problem: https://xomdata.com/practice/medium-recency-002
-- Solved: 2026-09-25

select
    customer_id,
    max(order_date) as last_order_date
from orders 
group by 1
having julianday('2024-06-30') - julianday(max(order_date)) > 30
