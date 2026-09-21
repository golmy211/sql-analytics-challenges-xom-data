-- Xom Data · Customers who ever bought skincare
-- Problem: https://xomdata.com/practice/easy-join-006
-- Solved: 2026-09-21

-- Write your SQL here
select
    distinct c.customer_name 
from customers c 
join purchases p on c.id = p.customer_id
where p.category = 'Skincare'
