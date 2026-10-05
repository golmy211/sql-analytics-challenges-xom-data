-- Xom Data · Diligent customers across all four quarters
-- Problem: https://xomdata.com/practice/medium-repeat-006
-- Solved: 2026-10-05

select
    customer_id,
    count(*) as orders_2024
from orders
where order_date between '2024-01-01' and '2024-12-31'
group by customer_id
having sum(substr(order_date, 6, 2) between '01' and '03') > 0
   and sum(substr(order_date, 6, 2) between '04' and '06') > 0
   and sum(substr(order_date, 6, 2) between '07' and '09') > 0
   and sum(substr(order_date, 6, 2) between '10' and '12') > 0
