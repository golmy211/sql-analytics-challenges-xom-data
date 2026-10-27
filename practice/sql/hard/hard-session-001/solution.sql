-- Xom Data · Sessionize logins with a 30-minute gap
-- Problem: https://xomdata.com/practice/hard-session-001
-- Solved: 2026-10-27

with e as (
    select
        id,
        user_id,
        event_at,
        cast(event_at as timestamp) as ts,
        lag(cast(event_at as timestamp)) over (
            partition by user_id
            order by cast(event_at as timestamp), id
        ) as prev_ts
    from events
),
f as (
    select
        *,
        case
            when prev_ts is null
              or extract(epoch from (ts - prev_ts)) / 60 > 30
            then 1 else 0
        end as is_new_session
    from e
),
g as (
    select
        *,
        sum(is_new_session) over (
            partition by user_id
            order by ts, id
            rows between unbounded preceding and current row
        ) as session_seq
    from f
)
select
    user_id,
    session_seq,
    count(*) as n_events,
    min(event_at) as session_start,
    max(event_at) as session_end,
    round(cast(extract(epoch from (max(ts) - min(ts))) / 60 as numeric), 1) as duration_min
from g
group by user_id, session_seq
order by user_id, session_seq;
