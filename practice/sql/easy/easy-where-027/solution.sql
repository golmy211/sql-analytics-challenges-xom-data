-- Xom Data · Top-scoring players
-- Problem: https://xomdata.com/practice/easy-where-027
-- Solved: 2026-09-06

select full_name, goals_scored
from players
where goals_scored > 10
order by goals_scored desc
