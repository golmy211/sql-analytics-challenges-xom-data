-- Xom Data · Total payroll by org branch
-- Problem: https://xomdata.com/practice/hard-recursive-001
-- Solved: 2026-10-12

with recursive sub as (
    select id as root_id, id, salary
    from employees

    union all

    select s.root_id, e.id, e.salary
    from sub s
    join employees e on s.id = e.manager_id
),
agg as (
    select root_id,
           count(*)    as subtree_size,
           sum(salary) as subtree_salary
    from sub
    group by root_id
)
select m.id   as manager_id,
       m.name as manager_name,
       (select count(*) from employees d where d.manager_id = m.id) as direct_reports,
       a.subtree_size,
       a.subtree_salary
from agg a
join employees m on m.id = a.root_id
where exists (select 1 from employees d where d.manager_id = m.id)
order by a.subtree_salary desc, m.id asc;
