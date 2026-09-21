-- Xom Data · Orders with customer names
-- Problem: https://xomdata.com/practice/easy-join-001
-- Solved: 2026-09-21

-- Write your SQL here
select 
    o.order_code,
    c.customer_name,
    o.amount
from customers c
join orders o on c.id = o.customer_id
