-- Xom Data · Detect anomalous days vs the average
-- Problem: https://xomdata.com/practice/hard-anomaly-001
-- Solved: 2026-11-17

with s as (
    select 
        date,
        value,
        round(avg(value)over(),2) as mean
    from daily_metrics
),
f as (
    select 
        date,
        round(sqrt(avg(power((value - mean),2))over()),2) as stddev
    from s 
)
select 
    s.date,
    s.value,
    s.mean,
    f.stddev,
    round(coalesce((s.value - s.mean)/nullif(f.stddev,0),0),2) as z_score,
    case 
        when round(coalesce((s.value - s.mean)/nullif(f.stddev,0),0),2) > 2 then 'high'
        when round(COALESCE((s.value - s.mean)/nullif(f.stddev,0),0),2) < -2 then 'low'
        else 'normal'
        end as flag
from f join s on s.date = f.date
order by 1
