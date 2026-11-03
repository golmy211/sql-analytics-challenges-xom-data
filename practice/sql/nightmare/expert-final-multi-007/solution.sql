-- Xom Data · Top 2 salespeople by sales each month
-- Problem: https://xomdata.com/practice/expert-final-multi-007
-- Solved: 2026-11-03

with s as (
    select 
        employee_id,
        month,
        sum(revenue) as total_sales

    from sales
    group by 1,2
), 
m as (
    select 
        s.month,
        DENSE_RANK()over(partition by s.month order by s.total_sales desc) as sales_rank,
        s.employee_id,
        e.full_name,
        s.total_sales
    from s 
    join employees e on s.employee_id = e.id
)

select * 
from m
where sales_rank <= 2 
order by month, sales_rank, employee_id
