-- Xom Data · Median salary per department
-- Problem: https://xomdata.com/practice/sql-nightmare-002
-- Solved: 2026-11-12

with s as (
    select 
        dept,
        percentile_cont(0.5) within group (order by salary) as median_salary
    from employees
    GROUP BY 1 
)

select * from s
