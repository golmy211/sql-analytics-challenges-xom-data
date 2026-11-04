-- Xom Data · 4-step onboarding conversion rate
-- Problem: https://xomdata.com/practice/hard-funnel-001
-- Solved: 2026-11-04

with s as (
    select 
        'signup' as step,
        count(distinct case when event_name = 'signup' then user_id end) as n_users
    from events 

    union all
        select 
        'verify_email' as step,
        count(distinct case when event_name = 'verify_email' then user_id end) as n_users
    from events 

    union all 
        select 
        'first_login' as step,
        count(distinct case when event_name = 'first_login' then user_id end) as n_users
    from events 

    union all 
        select 
        'first_purchase' as step,
        count(distinct case when event_name = 'first_purchase' then user_id end) as n_users
    from events 
),
f as (
    select 
           step,
            n_users,
            case when step = 'signup' then 1 
                 when step = 'verify_email' then 2
                 when step = 'first_login' then 3 
                 when step = 'first_purchase' then 4 
                 end as erd 
    from s
)
    select 
        step,
        COALESCE(n_users,0) as n_users,
        round(coalesce(100.0 * n_users / nullif(first_value(n_users) over (order by erd), 0), 0), 2) AS conversion_pct
    from f
