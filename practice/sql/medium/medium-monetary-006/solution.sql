-- Xom Data · Spend per Active Month
-- Problem: https://xomdata.com/practice/medium-monetary-006
-- Solved: 2026-10-04

select 
    customer_id,
    sum(amount) as total_spent,
    count(distinct substring(order_date,1,7)) as active_months,
    round(sum(amount) * 1.00/count(distinct substring(order_date,1,7)),2) as spend_per_month
from orders
group by 1
order by spend_per_month desc, customer_id asc
