-- Xom Data · Orders during the promo period
-- Problem: https://xomdata.com/practice/easy-between-002
-- Solved: 2026-09-21

-- Write your SQL here
select 
    order_code,
    order_date,
    total_amount
from orders 
where order_date between '2025-06-01' and '2025-06-30'
