-- Xom Data · Monthly store visit rhythm
-- Problem: https://xomdata.com/practice/medium-active-001
-- Solved: 2026-09-25

select 
    SUBSTRING(order_date,1,7) as month,
    count(distinct customer_id) as active_customers
from orders 
group by 1
order by month asc
