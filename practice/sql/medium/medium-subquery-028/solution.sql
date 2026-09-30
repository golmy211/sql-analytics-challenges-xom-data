-- Xom Data · Students above the subject average
-- Problem: https://xomdata.com/practice/medium-subquery-028
-- Solved: 2026-09-30

with avg_subject as (
select 
    s.id,
    s.subject_name,
    avg(g.final_score) as subject_avg
from subjects s 
left join grades g on s.id = g.subject_id
group by 1,2
)

select 
    s.full_name,
    av.subject_name,
    g.final_score,
    round(av.subject_avg,2) as subject_avg,
    round(g.final_score - av.subject_avg,2) as diff_from_avg
from students s
left join grades g on s.id = g.student_id
left join avg_subject av on g.subject_id = av.id
where g.final_score > av.subject_avg 
order by diff_from_avg desc, full_name asc
