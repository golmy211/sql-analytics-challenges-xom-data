-- Xom Data · The customer's joining month on every order
-- Problem: https://xomdata.com/practice/medium-cohort-001
-- Solved: 2026-09-24

-- Write your SQL here
select
    customer_name,
    order_date,
    min(substring(order_date,1,7)) OVER (
        partition by customer_name
    ) as cohort_month
from orders 
group by 1,2
order by customer_name asc , order_date asc, cohort_month asc
