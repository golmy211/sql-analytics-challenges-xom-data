-- Xom Data · Latest readings and over-limit alerts
-- Problem: https://xomdata.com/practice/medium-dedup-003
-- Solved: 2026-10-03

with latest_Date as (
    select 
        sensor_id,
        max(reading_date) as reading_date
    from readings
    group by 1
)
select 
    s.sensor_name,
    d.reading_date,
    r.temp_c,
    s.max_temp,
    case 
        when r.temp_c > s.max_temp then 'Alert'
        else 'Normal'
        end as status 
from sensors s 
join latest_date d on s.id = d.sensor_id
join readings r on s.id = r.sensor_id and r.reading_date = d.reading_date 
order by sensor_name asc
