-- Xom Data · Countdown before losing a customer
-- Problem: https://xomdata.com/practice/medium-churn-003
-- Solved: 2026-09-25

select
    customer_id,
    julianday('2024-06-30') - julianday(max(order_date)) as days_silent,
    90 - (julianday('2024-06-30') - julianday(max(order_date))) as days_left
from orders
group by 1
having julianday('2024-06-30') - julianday(max(order_date)) <= 90
order by days_left, customer_id
