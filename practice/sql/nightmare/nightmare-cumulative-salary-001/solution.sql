-- Xom Data · 3-month rolling payroll (excluding each employee's latest month)
-- Problem: https://xomdata.com/practice/nightmare-cumulative-salary-001
-- Solved: 2026-11-13

with s as(
    select 
        Id,
        Month,
        Salary,
        ROW_NUMBER()over(PARTITION BY Id ORDER BY month DESC) as rn
    from employee
), 
f as (
    select 
        Id,
        Month,
        SUM(salary)over(PARTITION BY Id ORDER BY month rows between 2 preceding and current row) as salary 
    from s 
    where rn <> 1 
)
SELECT * from f order by Id,Month desc
