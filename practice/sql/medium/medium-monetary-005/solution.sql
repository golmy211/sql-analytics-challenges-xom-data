-- Xom Data · Each Customer's Slice of Revenue
-- Problem: https://xomdata.com/practice/medium-monetary-005
-- Solved: 2026-09-25

with total_revenue as (
    select 
        sum(amount) as total_revenue 
    from orders 
),
customer_revenue as (
    select 
        customer_id,
        sum(amount) as customer_rev
    from orders
    group by 1 
)
select 
    customer_id,
    customer_rev as total_spent,
    round(customer_rev * 100.00/total_revenue,2) as revenue_share_pct
from customer_revenue join total_revenue on true 
order by revenue_share_pct desc, customer_id
