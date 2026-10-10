-- Xom Data · Department total next to each person
-- Problem: https://xomdata.com/practice/medium-winagg-001
-- Solved: 2026-10-10

-- Write your SQL here
 select 
    department,
    rep_name,
    revenue,
    sum(revenue)over(
        partition by department 
    ) as dept_total
from deals
order by department, rep_name
