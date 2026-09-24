-- Xom Data · Labeling customers as retained or churned
-- Problem: https://xomdata.com/practice/medium-churn-001
-- Solved: 2026-09-24

select 
    customer_id, 
    max(order_date) as last_order_date,
    case 
        when julianday('2024-06-30') - julianday(max(order_date)) > 90 then 'churned'
        else 'active'
        end as status
from orders 
group by 1
