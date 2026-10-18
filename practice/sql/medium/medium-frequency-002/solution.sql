-- Xom Data · Customers Who Hit Three Orders a Year
-- Problem: https://xomdata.com/practice/medium-frequency-002
-- Solved: 2026-10-18

select 
    customer_id,
    count(order_id) as order_count 
from orders
where order_date between '2024-01-01' and '2024-12-31'
group by 1
having count(order_id) >= 3
