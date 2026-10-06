-- Xom Data · The yellow warning zone before losing a customer
-- Problem: https://xomdata.com/practice/medium-churn-005
-- Solved: 2026-10-06

select 
    customer_id,
    max(order_date) as last_order_date,
    julianday('2024-06-30') - julianday(max(order_date)) as days_silent
from orders
group by 1
having julianday('2024-06-30') - julianday(max(order_date)) between 60 and 89
order by days_silent desc, customer_id asc
