-- Xom Data · The Silence Between Two Consecutive Purchases
-- Problem: https://xomdata.com/practice/medium-gap-001
-- Solved: 2026-10-08

with ranked as (
    select
        customer_id,
        order_date,
        cast(
            julianday(order_date) - julianday(
                lag(order_date) over (
                    partition by customer_id
                    order by order_date, order_id
                )
            ) as integer
        ) as days_since_prev
    from orders
)
select customer_id, order_date, days_since_prev
from ranked
where days_since_prev is not null
order by customer_id, order_date, days_since_prev;
