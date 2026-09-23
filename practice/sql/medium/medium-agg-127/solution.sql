-- Xom Data · Top 10 highest-paid employees and their leave days
-- Problem: https://xomdata.com/practice/medium-agg-127
-- Solved: 2026-09-23

with emp_salary as (
    select employee_id, sum(net_salary) as total_received_salary
    from payroll
    group by employee_id
),
avg_dep as (
    select
        d.department_name,
        avg(s.total_received_salary) as avg_department_salary
    from departments d
    join employees e on d.id = e.department_id
    left join emp_salary s on e.id = s.employee_id
    group by 1
),
emp_leave as (
    select employee_id, count(id) as leave_count
    from leaves
    where status = 'approved'
    group by employee_id
)
select
    e.full_name,
    e.employee_code,
    d.department_name,
    coalesce(s.total_received_salary,0) as total_received_salary,
    coalesce(l.leave_count,0) as leave_count,
    round((coalesce(s.total_received_salary,0) - a.avg_department_salary) / a.avg_department_salary * 100.00, 2) as pct_above_dept_avg
from departments d
join employees e on d.id = e.department_id
left join emp_salary s on e.id = s.employee_id
left join emp_leave l on e.id = l.employee_id
join avg_dep a on a.department_name = d.department_name
order by total_received_salary desc, employee_code asc
limit 10
