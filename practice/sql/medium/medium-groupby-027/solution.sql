-- Xom Data · Average score per subject
-- Problem: https://xomdata.com/practice/medium-groupby-027
-- Solved: 2026-09-22

select 
    s.subject_name,
    s.credits,
    count(g.id) as student_count,
    round(avg(g.final_score),2) as avg_score,
    round(avg(case 
            when g.final_score >= 5 then 1 
            else 0
            end) * 100.00,2            
    ) as pass_rate,
    rank()over(
        order by round(avg(g.final_score),2) desc
    ) as rank_by_avg,
    ntile(4)over(
        order by round(avg(g.final_score),2) desc, s.subject_name asc
    ) as difficulty_quartile
from subjects s 
left join grades g on s.id = g.subject_id
group by 1,2
order by rank_by_avg asc , s.subject_name asc
