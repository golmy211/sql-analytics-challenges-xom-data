-- Xom Data · How Long Since a Customer Last Returned
-- Problem: https://xomdata.com/practice/medium-recency-001
-- Solved: 2026-10-03

select 
    customer_id,
    max(order_date) as last_order_date,
    julianday('2024-06-30') - julianday(max(order_date))as days_since
from orders 
group by 1
order by days_since asc, customer_id asc
