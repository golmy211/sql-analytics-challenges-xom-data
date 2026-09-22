-- Xom Data · Candidates not yet interviewed
-- Problem: https://xomdata.com/practice/medium-leftjoin-031
-- Solved: 2026-09-22

select 
    c.full_name,
    c.email,
    c.application_date,
    row_number() over (
        order by c.application_date asc, c.full_name asc
    ) as queue_position,
    round(percent_rank() over (
        order by c.application_date asc, c.full_name asc
    ) * 100,2) as older_than_pct

from candidates c
where not exists (
    select 1 
    from interviews i
    where c.id = i.candidate_id 
)
order by queue_position
