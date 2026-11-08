-- Xom Data · Quarterly sales per employee (2024)
-- Problem: https://xomdata.com/practice/expert-final-agg-001
-- Solved: 2026-11-08

with s as (
    select 
        employee_id,
        sum(case when quarter = 1 then revenue else 0 end)as Q1, 
        sum(case when quarter = 2 then revenue else 0 end)as Q2, 
        sum(case when quarter = 3 then revenue else 0 end)as Q3, 
        sum(case when quarter = 4 then revenue else 0 end)as Q4
    FROM sales
    where year = 2024
    group by 1
)

select 
    employee_id,
    Q1,
    Q2,
    Q3,
    Q4
from s
order by employee_id
