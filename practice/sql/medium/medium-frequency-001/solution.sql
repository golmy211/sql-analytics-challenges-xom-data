-- Xom Data · Customers Active Over the Past Half Year
-- Problem: https://xomdata.com/practice/medium-frequency-001
-- Solved: 2026-10-18

select 
    customer_id,
    count(order_id) as order_count
from orders
where order_date between '2024-01-01' and '2024-06-30'
group by 1 
order by order_count desc, customer_id asc
