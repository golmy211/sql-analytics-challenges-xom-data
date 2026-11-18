-- Xom Data · Monthly recurring revenue (MRR) by subscription plan
-- Problem: https://xomdata.com/practice/hard-mrr-001
-- Solved: 2026-11-18

with bounds as (
    select
        date_trunc('month', min(started_at::date))::date as first_month,
        date_trunc('month', max(started_at::date))::date as last_month
    from subscriptions
),
months as (
    select (gs + interval '1 month - 1 day')::date as month_end
    from bounds,
         generate_series(first_month, last_month, interval '1 month') as gs
)
select
    to_char(m.month_end, 'YYYY-MM')  as month,
    count(s.user_id)                 as active_subs,
    coalesce(sum(s.mrr), 0)          as total_mrr
from months m
left join subscriptions s
    on  s.started_at::date <= m.month_end
    and (s.ended_at is null or s.ended_at::date > m.month_end)
group by m.month_end
order by m.month_end;
