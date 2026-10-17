-- Xom Data · Each cohort's size and first-month cash
-- Problem: https://xomdata.com/practice/medium-cohort-008
-- Solved: 2026-10-17

with r as (
    select
        customer_id,
        min(substring(order_date, 1, 7)) as cohort_month
    from orders
    group by customer_id
)
select
    r.cohort_month,
    count(distinct r.customer_id) as cohort_size,
    sum(o.amount) as first_month_revenue
from r
join orders o
    on o.customer_id = r.customer_id
   and substring(o.order_date, 1, 7) = r.cohort_month
group by r.cohort_month
order by r.cohort_month;
