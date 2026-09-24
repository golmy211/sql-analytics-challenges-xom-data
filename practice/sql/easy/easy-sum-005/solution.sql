-- Xom Data · Total spend for one budget category
-- Problem: https://xomdata.com/practice/easy-sum-005
-- Solved: 2026-09-24

-- Write your SQL here
select
    sum(amount) as total_spent
from expenses
where category = 'Marketing'
