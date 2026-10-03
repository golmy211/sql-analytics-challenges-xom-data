-- Xom Data · National rank and province rank
-- Problem: https://xomdata.com/practice/medium-rank-004
-- Solved: 2026-10-03

-- Write your SQL here
select 
    student_name,
    province,
    exam_score,
    rank()over(
        order by exam_score desc
    ) as national_rank,
    rank()over(
        partition by province
        order by exam_score desc
    ) as province_rank
from students
order by national_rank asc, student_name asc
