-- Xom Data · Estimating lifetime value with three building blocks
-- Problem: https://xomdata.com/practice/hard-ltv-005
-- Solved: 2026-11-18

with s as (
    select 
        sum(amount)::numeric/count(order_id) as AOV
    from orders
),
f as(
    select 
        customer_id,
        TO_CHAR(cast(order_date as date),'YYYY-MM') as month,
        count(order_id) as total_orders
    from orders
    group by 1,2
),
a as(
    select 
        sum(total_orders)::NUMERIC/count(*) as orders_per_active_month,
        count(*)::NUMERIC/count(distinct customer_id)  as avg_active_months
    from f
    
)
select 
    round(s.aov,2) as aov,
    round(a.orders_per_active_month,2) as orders_per_active_month,
    round(a.avg_active_months,2) as avg_active_months,
    round(s.aov *  a.orders_per_active_month * a.avg_active_months,2) as estimated_ltv
from a join s on true
