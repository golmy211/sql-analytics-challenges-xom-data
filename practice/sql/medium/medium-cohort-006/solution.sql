-- Xom Data · Customer Shopping Tenure
-- Problem: https://xomdata.com/practice/medium-cohort-006
-- Solved: 2026-10-08

select
    customer_id,
    strftime('%Y-%m', min(order_date)) as first_month,
    strftime('%Y-%m', max(order_date)) as last_month,
    (strftime('%Y', max(order_date)) - strftime('%Y', min(order_date))) * 12
      + (strftime('%m', max(order_date)) - strftime('%m', min(order_date))) as tenure_months
from orders
group by customer_id
order by tenure_months desc, customer_id asc;
