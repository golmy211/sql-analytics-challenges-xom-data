-- Xom Data · Who Joined During Promo Season
-- Problem: https://xomdata.com/practice/medium-cohort-007
-- Solved: 2026-10-04

with first_order as (
    select
        customer_id,
        min(order_date) as first_order_date
    from orders
    group by customer_id
)
select
    f.customer_id,
    f.first_order_date,
    count(*) as campaign_orders
from first_order f
join orders o
    on o.customer_id = f.customer_id
where substr(f.first_order_date, 1, 7) = '2024-03'
  and substr(o.order_date, 1, 7) = '2024-03'
group by f.customer_id, f.first_order_date;
