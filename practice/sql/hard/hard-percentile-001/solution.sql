-- Xom Data · Median and percentile salary by department
-- Problem: https://xomdata.com/practice/hard-percentile-001
-- Solved: 2026-11-12

with ranked as (
    select
        department,
        salary,
        percent_rank() over (partition by department order by salary) as pr 
    from employees
),
picked as (
    select
        department,
        salary,
        row_number() over (partition by department order by abs(pr - 0.25), salary) as rn25,
        row_number() over (partition by department order by abs(pr - 0.50), salary) as rn50,
        row_number() over (partition by department order by abs(pr - 0.75), salary) as rn75
    from ranked
)
select
    department,
    max(salary) filter (where rn25 = 1) as p25,
    max(salary) filter (where rn50 = 1) as p50,
    max(salary) filter (where rn75 = 1) as p75
from picked
group by department
order by department;
