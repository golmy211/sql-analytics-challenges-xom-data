-- Xom Data · Regional payroll with shares
-- Problem: https://xomdata.com/practice/medium-winagg-010
-- Solved: 2026-10-08

-- Write your SQL here
select 
    region,
    staff_name,
    salary,
    sum(salary)over(
        partition by region
    ) as region_total,
    round(salary * 100.00/ sum(salary)over(
        partition by region
    ),2) as pct_of_region
from payroll
group by 1,2,3
order by region asc, salary desc, staff_name
