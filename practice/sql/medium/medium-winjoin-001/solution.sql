-- Xom Data · Sales rankings with department names
-- Problem: https://xomdata.com/practice/medium-winjoin-001
-- Solved: 2026-10-03

-- Write your SQL here
with top_department as (
    select 
        d.id,
        d.dept_name,
        s.staff_name,
        s.sales_amount,
        rank()over(
            partition by d.dept_name
            order by s.sales_amount desc
        ) as dept_rank
    from departments d
    join staff s on d.id = s.dept_id
) 
select 
    dept_name,
    dept_rank,
    staff_name,
    sales_amount
from top_department
order by dept_name asc, dept_rank asc, staff_name asc
