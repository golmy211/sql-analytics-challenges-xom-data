-- Xom Data · Distance from the class average
-- Problem: https://xomdata.com/practice/medium-winagg-003
-- Solved: 2026-10-10

-- Write your SQL here
select 
    class_name,
    student_name,
    score,
    round(score - avg(score)over(partition by class_name),2) as diff_from_avg
from scores
order by class_name asc, student_name asc
