-- Xom Data · New customers and returning customers each month
-- Problem: https://xomdata.com/practice/hard-cohort-003
-- Solved: 2026-10-20

with first_orders as (
    select
        customer_id,
        min(left(order_date::text, 7)) as first_month
    from orders
    group by customer_id
),
monthly as (
    select distinct
        customer_id,
        left(order_date::text, 7) as month
    from orders
)
select
    m.month,
    count(*) filter (where m.month = f.first_month) as new_customers,
    count(*) filter (where m.month > f.first_month) as returning_customers
from monthly m
join first_orders f on f.customer_id = m.customer_id
group by m.month
order by m.month;
