-- Xom Data · The size of each customer cohort
-- Problem: https://xomdata.com/practice/medium-cohort-004
-- Solved: 2026-10-06

with first_orders as (
    select
        customer_id,
        substr(min(order_date), 1, 7) as cohort_month
    from orders
    group by customer_id
)
select
    cohort_month,
    count(*) as cohort_size
from first_orders
group by cohort_month
order by cohort_month asc
