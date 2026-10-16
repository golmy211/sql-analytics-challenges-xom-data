-- Xom Data · Total sales by org branch
-- Problem: https://xomdata.com/practice/hard-hierarchical-001
-- Solved: 2026-10-16

with recursive sub as (
    select id as root_id, id, name, direct_sales 
    from agents 
 
    union all 

    select s.root_id, a.id, a.name, a.direct_sales
    from agents a 
    join sub s on a.manager_id = s.id
),
agg as (
    select 
        root_id as agent_id,
        sum(direct_sales) as direct_sales
    from sub 
    group by 1 
)

select 
    g.agent_id,
    a.name as agent_name,
    a.direct_sales,
    g.direct_sales as team_total
from agents a 
join agg g on a.id = g.agent_id 
order by team_total desc, agent_id asc
