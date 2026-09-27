-- Xom Data · Players with 3 or more goals
-- Problem: https://xomdata.com/practice/medium-having-187
-- Solved: 2026-09-27

select 
    p.full_name,
    p.positions,
    t.team_name,
    count(g.id) as goal_count,
    count(distinct g.match_id) as scoring_matches,
    count(distinct pe.id) as cards_received,
    round(count(distinct g.id)::numeric / count(distinct g.match_id), 2)  as goals_per_match,
    dense_rank()over(
        order by round(count(g.id)/count(distinct g.match_id),2) desc
    ) as efficiency_rank,
    rank()over(
        order by count(g.id) desc
    ) as volume_rank
from teams t 
left join players p on t.id = p.team_id
left join goals g on g.player_id = p.id 
left join penalties pe on p.id = pe.player_id  
group by 1,2,3
having count(distinct g.id) >= 3 and count(distinct pe.id) < 5
order by efficiency_rank asc, full_name asc
