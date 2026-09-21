-- Xom Data · Safety training results
-- Problem: https://xomdata.com/practice/easy-case-001
-- Solved: 2026-09-21

-- Write your SQL here
select 
    trainee_name,
    score,
    case 
        when score >= 70 then 'Pass'
        else 'Fail'
        end as result
from trainees
