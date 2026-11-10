-- Xom Data · Customers active and purchasing 3 weeks in a row
-- Problem: https://xomdata.com/practice/nightmare-streak-001
-- Solved: 2026-11-10

with w as (
    select distinct
        user_id,
        extract(year from event_date::date)::int as yr,
        (extract(doy from event_date::date)::int
         + 7 - extract(isodow from event_date::date)::int) / 7 as wk
    from events
    where subtype = 'purchase'
),
g as (
    select
        user_id, yr, wk,
        wk - row_number() over (partition by user_id, yr order by wk) as grp
    from w
)
select
    user_id,
    yr::text || '-' || lpad(min(wk)::text, 2, '0') as streak_start_week,
    yr::text || '-' || lpad(max(wk)::text, 2, '0') as streak_end_week,
    count(*) as n_weeks
from g
group by user_id, yr, grp
having count(*) >= 3
order by user_id, streak_start_week;
