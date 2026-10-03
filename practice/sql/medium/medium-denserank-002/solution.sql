-- Xom Data · Salary bands within each department
-- Problem: https://xomdata.com/practice/medium-denserank-002
-- Solved: 2026-10-03

-- Write your SQL here
with top_salary as(
    select 
        department,
        full_name,
        salary,
        dense_rank()over(
            partition by department
            order by salary desc
        )as rn
    from employees
)
select 
    department,
    rn as salary_tier,
    full_name,
    salary
from top_salary
order by department asc, salary_tier asc, full_name asc
