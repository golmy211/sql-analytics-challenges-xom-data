-- Xom Data · Numbers appearing 3 times in a row in the log
-- Problem: https://xomdata.com/practice/nightmare-consecutive-001
-- Solved: 2026-11-12

with s as (
    select 
        num,
        id - ROW_NUMBER()over(PARTITION BY num order by id) as grp
    from logs 

)
select 
    distinct num as consecutive_num
from s 
group by num,grp 
having count(*) >= 3
order by 1
