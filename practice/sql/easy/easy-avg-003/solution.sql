-- Xom Data · Average score in Math
-- Problem: https://xomdata.com/practice/easy-avg-003
-- Solved: 2026-09-21

-- Write your SQL here
select 
    avg(score) as avg_score
from exam_scores
where subject = 'Math'
