-- Xom Data · Low-activity users
-- Problem: https://xomdata.com/practice/medium-subquery-160
-- Solved: 2026-09-27

with base as (
    select
        u.user_name,
        count(o.id) as order_count,
        sum(o.value) as total_value,
        avg(o.value) as avg_order_value,
        case
            when count(o.id) = 0 then 'Inactive'
            when sum(o.value) < avg(sum(o.value)) over() then 'Low'
            else 'Normal'
        end as tier
    from users u
    left join orders o on u.id = o.user_id
    group by 1
),
filtered as (
    select *
    from base
    where tier != 'Normal'
)
select
    user_name,
    order_count,
    total_value,
    avg_order_value,
    tier,
    rank() over (order by total_value asc nulls first) as activity_rank,
    round(percent_rank() over (order by total_value asc nulls first)::numeric * 100, 2) as pct_above_peers
from filtered
order by activity_rank asc, user_name asc
