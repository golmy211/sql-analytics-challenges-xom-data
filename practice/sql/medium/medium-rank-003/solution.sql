-- Xom Data · Revenue rank of each category
-- Problem: https://xomdata.com/practice/medium-rank-003
-- Solved: 2026-10-03

-- Write your SQL here
select 
    category,
    sum(amount) as total_revenue,
    rank()over(
        order by sum(amount) desc
    ) as revenue_rank
from sales
group by 1
order by revenue_rank asc, category asc
