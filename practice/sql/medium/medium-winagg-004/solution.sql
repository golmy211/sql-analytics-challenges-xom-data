-- Xom Data · How far from the server's top
-- Problem: https://xomdata.com/practice/medium-winagg-004
-- Solved: 2026-10-10

-- Write your SQL here
select 
    server,
    player_name,
    points,
    abs(points - max(points)over(partition by server)) as gap_to_top
from players
order by server asc, points desc, player_name asc
