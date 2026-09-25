-- Xom Data · Sales division employees
-- Problem: https://xomdata.com/practice/easy-like-002
-- Solved: 2026-09-25

-- Write your SQL here
select
    employee_code,
    full_name
from employees
where employee_code like 'SAL-%'
