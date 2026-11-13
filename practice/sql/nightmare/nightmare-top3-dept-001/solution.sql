-- Xom Data · Top 3 salaries per department
-- Problem: https://xomdata.com/practice/nightmare-top3-dept-001
-- Solved: 2026-11-13

with s as (
    select 
        d.name as Department,
        e.name as Employee,
        e.salary as Salary,
        DENSE_RANK()over(
            partition by d.name
            order by e.salary desc 
        ) as rn 
    from employee e 
    join department d on e.departmentid = d.id 
)
SELECT 
    Department,
    Employee,
    Salary 
from s 
where rn <= 3
order by Department,Salary DESC, employee
