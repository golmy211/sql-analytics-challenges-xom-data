-- Xom Data · Ward headcount next to each nurse
-- Problem: https://xomdata.com/practice/medium-winagg-005
-- Solved: 2026-10-09

-- Write your SQL here
select
    ward,
    nurse_name,
    count(id)over(
        partition by ward
    ) as team_size
from roster
order by ward, nurse_name
