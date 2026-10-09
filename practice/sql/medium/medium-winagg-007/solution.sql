-- Xom Data · Above or below the department norm
-- Problem: https://xomdata.com/practice/medium-winagg-007
-- Solved: 2026-10-09

-- Write your SQL here
select 
    department,
    full_name,
    salary,
    case 
        when salary > avg(salary)over(partition by department) then 'Above'
        when salary < avg(salary)over(partition by department) then 'Below'
        else 'Equal'
        end as position_label
from employees
order by department, full_name
