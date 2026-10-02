-- Xom Data · Three Freshness Circles of the Customer Base
-- Problem: https://xomdata.com/practice/medium-recency-004
-- Solved: 2026-10-02

with last_order as (
    select
        customer_id,
        julianday('2024-06-30') - julianday(max(order_date)) as days_idle
    from orders
    group by customer_id
)
select
    case
        when days_idle <= 30 then 'hot'
        when days_idle <= 90 then 'warm'
        else 'cold'
    end as freshness_bucket,
    count(*) as customer_count
from last_order
group by freshness_bucket
order by min(days_idle);
