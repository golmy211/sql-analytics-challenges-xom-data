-- Xom Data · Employees averaging over 5 overtime hours
-- Problem: https://xomdata.com/practice/medium-having-128
-- Solved: 2026-09-27

select 
    e.full_name,
    e.employee_code,
    avg(a.work_days) as avg_work_days,
    avg(a.overtime_hours) as avg_overtime_hours,
    avg(p.net_salary) as avg_salary,
    round(avg(a.overtime_hours)/avg(a.work_days),4) as overtime_intensity,
    rank()over(
        order by round(avg(a.overtime_hours)/avg(a.work_days),4) desc
    ) as intensity_rank,
    ntile(4)over(
        order by round(avg(a.overtime_hours)/avg(a.work_days),4) desc
    ) as workload_quartile

from employees e 
left join attendance a on e.id = a.employee_id
left join payroll p on e.id = p.employee_id
group by 1,2 
having avg(a.overtime_hours) > 5 and avg(a.work_days) >= 18
order by intensity_rank asc, employee_code asc
