-- Xom Data · Salary by department and title
-- Problem: https://xomdata.com/practice/medium-join-126
-- Solved: 2026-09-30

select 
    d.department_name,
    p.position_name,
    count(e.id) as employee_count,
    avg(pa.net_salary) as avg_salary,
    min(pa.net_salary) as min_salary,
    max(pa.net_salary) as max_salary,
    max(pa.net_salary) - min(pa.net_salary) as salary_spread,
    rank()over(
        partition by d.department_name
        order by avg(pa.net_salary) desc
    ) as rank_in_dept
from employees e 
right join departments d on e.department_id = d.id 
right join positions p on e.position_id = p.id
left join payroll pa on e.id = pa.employee_id 
group by 1,2 
order by department_name asc, rank_in_dept asc, position_name asc
