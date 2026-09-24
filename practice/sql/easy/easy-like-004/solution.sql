-- Xom Data · PDF documents in the attachment store
-- Problem: https://xomdata.com/practice/easy-like-004
-- Solved: 2026-09-24

-- Write your SQL here
select
    file_name,
    uploaded_by 
from attachments
where file_name like '%pdf'
