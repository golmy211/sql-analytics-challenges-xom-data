-- Xom Data · Each customer's debut month
-- Problem: https://xomdata.com/practice/medium-cohort-003
-- Solved: 2026-09-24

select
    customer_id,
    min(substring(order_date,1,7)) as cohort_month
from orders 
group by 1
order by cohort_month asc, customer_id asc
