-- Xom Data · Instructor teaching load
-- Problem: https://xomdata.com/practice/medium-join-029
-- Solved: 2026-09-30

select 
    l.full_name,
    l.academic_degree,
    coalesce(count(s.id),0) as subjects_taught,
    rank()over(
        order by coalesce(count(s.id),0) desc 
    ) as workload_rank,
    sum(coalesce(count(s.id),0))over(
        order by coalesce(count(s.id),0) desc 
        rows between unbounded preceding and current row
    )as cumulative_subjects
from lecturers l
left join subjects s on l.id = s.lecturer_id
group by 1,2
order by workload_rank asc, full_name asc
