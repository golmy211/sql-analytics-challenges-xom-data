-- Xom Data · Each customer's starting quarter
-- Problem: https://xomdata.com/practice/medium-cohort-005
-- Solved: 2026-10-07

select
    customer_id,
    min(
        substr(order_date, 1, 4) || '-Q' ||
        ((cast(substr(order_date, 6, 2) as int) + 2) / 3)
    ) as first_quarter
from orders
group by customer_id;
