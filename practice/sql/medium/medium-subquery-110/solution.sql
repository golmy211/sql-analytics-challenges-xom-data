-- Xom Data · Employees paid above their department average
-- Problem: https://xomdata.com/practice/medium-subquery-110
-- Solved: 2026-09-30

with average as (
    select 
            d.id,
            d.dept_name,
            avg(e.salary) as avg_department
    from departments d 
    left join employees e on d.id = e.department_id 
    group by 1 
)

select 
    e.full_name,
    a.dept_name,
    e.salary,
    round(avg_department,0) as dept_avg_salary,
    round((e.salary - avg_department) * 100.00/avg_department,2) as premium_pct
from employees e 
join average a on a.id = e.department_id
where e.salary > avg_department 
group by 1,2,3
order by premium_pct desc , dept_name, full_name
