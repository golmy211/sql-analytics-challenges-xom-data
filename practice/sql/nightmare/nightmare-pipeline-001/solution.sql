-- Xom Data · Top 3 campaigns by month-over-month growth
-- Problem: https://xomdata.com/practice/nightmare-pipeline-001
-- Solved: 2026-11-11

with d as (
    select campaign_id, spend_date, max(amount) as amount
    from campaign_spend
    group by 1, 2
),
s as (
    select
        to_char(cast(spend_date as date), 'YYYY-MM') as month,
        campaign_id,
        sum(amount) as total_spend
    from d
    group by 1, 2
),
f as (
    select
        month,
        campaign_id,
        total_spend,
        lag(total_spend) over (partition by campaign_id order by month) as prev_spend
    from s
),
a as (
    select
        month,
        campaign_id,
        total_spend,
        round((total_spend - prev_spend) * 100.0 / prev_spend, 2) as growth_pct
    from f
    where prev_spend > 0
),
c as (
select 
    *,
    DENSE_RANK()over(PARTITION BY month order by growth_pct desc,campaign_id ) as rank_in_month
from a 
)

select * from c where rank_in_month <= 3 order by month,rank_in_month
