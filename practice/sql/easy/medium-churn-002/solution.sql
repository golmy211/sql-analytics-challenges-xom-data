-- Xom Data · Active or stopped subscription
-- Problem: https://xomdata.com/practice/medium-churn-002
-- Solved: 2026-09-25

select 
    sub_id,
    customer_id,
    case 
        when end_date < '2024-06-30' then 'stopped'
        else 'active'
        end as status 
from subscriptions
