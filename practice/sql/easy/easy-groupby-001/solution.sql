-- Xom Data · Headcount per membership plan
-- Problem: https://xomdata.com/practice/easy-groupby-001
-- Solved: 2026-09-23

-- Write your SQL here
select 
    plan,
    count(id) as num_members
from members
group by 1
order by 1 asc
