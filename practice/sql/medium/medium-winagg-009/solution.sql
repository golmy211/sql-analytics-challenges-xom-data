-- Xom Data · Each category's slice of revenue
-- Problem: https://xomdata.com/practice/medium-winagg-009
-- Solved: 2026-10-08

with revenue_category as (
    select 
        category,
        sum(amount) as total_revenue
    from sales
    group by 1
),
total_revenue as (
    select 
         sum(amount) as revenue
    from sales
)
select 
    category,
    total_revenue,
    round(100.00* total_revenue/revenue,2) as pct_share
from revenue_category 
join total_revenue on true 
order by total_revenue desc, category asc
