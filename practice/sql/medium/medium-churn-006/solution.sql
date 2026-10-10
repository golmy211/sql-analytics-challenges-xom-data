-- Xom Data · A snapshot of the customer base at a point in time
-- Problem: https://xomdata.com/practice/medium-churn-006
-- Solved: 2026-10-10

with c as (
    select
        customer_id,
        min(order_date) as first_date,
        max(order_date) as last_date
    from orders
    where order_date <= '2024-06-30'
    group by customer_id
)
select
    segment,
    count(*) as customer_count
from (
    select
        case
            when strftime('%Y-%m', first_date) = '2024-06' then 'new'
            when julianday('2024-06-30') - julianday(last_date) > 90 then 'churned'
            else 'active'
        end as segment
    from c
)
group by segment
