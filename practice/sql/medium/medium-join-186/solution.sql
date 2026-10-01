-- Xom Data · Goals and cards by team
-- Problem: https://xomdata.com/practice/medium-join-186
-- Solved: 2026-10-01

with player_counts as (
    select 
        team_id,
        count(*) as player_counts
    from players 
    group by 1 
),
team_goal as(
    select
        t.id,
        count(g.*) as team_goals
    from teams t 
    left join players p on t.id = p.team_id 
    left join goals g on p.id = g.player_id
    group by 1
),
team_pen as(
    select
        t.id,
        count(pe.*) as team_pens
    from teams t 
    left join players p on t.id = p.team_id 
    left join penalties pe on p.id = pe.player_id
    group by 1
),
base as (
    select 
            t.team_name as team_name,
            t.city as city,
            coalesce(tg.team_goals,0) as total_goals_scored,
            coalesce(tp.team_pens,0) as penalty_count,
            coalesce(pc.player_counts, 0) as player_count
    from teams t 
    left join team_goal tg on t.id = tg.id
    left join team_pen tp on  tg.id = tp.id
    left join player_counts pc on pc.team_id = t.id
)
select 
    team_name,
    city,
    player_count,
    total_goals_scored,
    penalty_count,
    round(total_goals_scored::numeric/player_count,2) as goals_per_player,
    round(penalty_count::numeric/player_count,2) as cards_per_player,
    rank()over(
        order by total_goals_scored desc
    ) as scoring_rank,
    sum(total_goals_scored)over(
        order by total_goals_scored desc
    ) as cumulative_goals
from base 
order by scoring_rank asc, team_name asc
