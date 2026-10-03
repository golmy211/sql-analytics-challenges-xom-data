-- Xom Data · Sales rank within each region
-- Problem: https://xomdata.com/practice/medium-rank-002
-- Solved: 2026-10-03

-- Write your SQL he

select 
    region,
    rank()over(
        partition by region
        order by sales_amount desc
    ) as region_rank,
    rep_name,
    sales_amount
from reps
order by region asc, region_rank asc, rep_name asc
