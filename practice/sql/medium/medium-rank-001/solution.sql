-- Xom Data · Grand final leaderboard
-- Problem: https://xomdata.com/practice/medium-rank-001
-- Solved: 2026-10-03

-- Write your SQL here
select 
    rank()over(
        order by points desc 
    ) as final_rank,
    player_name,
    points
from players
order by final_rank asc, player_name asc
