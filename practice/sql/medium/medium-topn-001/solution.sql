-- Xom Data · Sales champion of each region
-- Problem: https://xomdata.com/practice/medium-topn-001
-- Solved: 2026-10-02

with top_region as (
    select 
        region,
        rep_name,
        sales_amount,
        row_number()over(
            partition by region 
            order by sales_amount desc, rep_name asc
        ) as rn 
    from reps
)
select 
    region,
    rep_name,
    coalesce(sales_amount,0) as sales_amount 
from top_region
where rn = 1 
order by region asc, rep_name asc
