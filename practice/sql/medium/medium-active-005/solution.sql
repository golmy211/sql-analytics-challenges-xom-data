-- Xom Data · Month-over-month momentum in customer count
-- Problem: https://xomdata.com/practice/medium-active-005
-- Solved: 2026-10-10

with s as (
select 
    strftime('%Y-%m', order_date) as month,
    count(distinct customer_id) as active_customers
from orders
group by 1 
)
select 
    month,
    active_customers,
    active_customers - lag(active_customers)over(
        order by month asc
    ) as change_vs_prev
from s 
order by month asc
