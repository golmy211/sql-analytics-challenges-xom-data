-- Xom Data · Each branch's two slowest months
-- Problem: https://xomdata.com/practice/medium-topn-004
-- Solved: 2026-10-02

-- Write your SQL here
with top_lowest as (
    select
        branch,
        month,
        revenue,
        dense_rank()over(
            partition by branch
            order by revenue asc, month asc
        )as rn 
    from branch_monthly
)
select 
    branch,
    month,
    revenue
from top_lowest 
where rn <= 2 
order by branch, revenue asc, month asc
