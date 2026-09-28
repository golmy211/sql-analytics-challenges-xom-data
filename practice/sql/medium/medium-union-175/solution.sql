-- Xom Data · Summary of issues to handle
-- Problem: https://xomdata.com/practice/medium-union-175
-- Solved: 2026-09-28

with complaints as (
    select
        'Complaint' as type,  
        count(id) as quantity
    from complaints
    where status = 'Pending'
),
orders as (
    select
        'Cancelled Order' as type, 
        count(id) as quantity
    from orders 
    where status = 'Cancelled'
),
products as (
    select
        'Out of Stock Product' as type, 
        count(id) as quantity
    from products
    where status = 'Out of Stock'
),
full_table as (
select * 
from complaints 
union all 
select * 
from orders 
union all 
select * 
from products 
) 
, calc as (
    select
        type,
        quantity,
        quantity * 100.0 / nullif(sum(quantity) over (), 0) as pct_raw,
        rank() over (order by quantity desc) as rank_pos
    from full_table
)
select
    type,
    quantity,
    round(pct_raw, 2) as pct_of_total,
    rank_pos,
    round(sum(pct_raw) over (
        order by quantity desc, type asc
        rows between unbounded preceding and current row
        ), 2) as cumulative_pct
from calc
order by rank_pos asc, type asc
