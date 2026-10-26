-- Xom Data · Daily revenue including zero-sale days
-- Problem: https://xomdata.com/practice/hard-gapfill-001
-- Solved: 2026-10-26

WITH date_range AS (
    -- Bước 1 & 2: Tạo chuỗi ngày liên tục từ min đến max
    SELECT generate_series(
        (SELECT MIN(date::DATE) FROM daily_revenue),
        (SELECT MAX(date::DATE) FROM daily_revenue),
        '1 day'::interval
    )::DATE AS full_date
)
-- Bước 3: LEFT JOIN chuỗi ngày với bảng doanh thu thực tế và tính tổng
SELECT
    TO_CHAR(d.full_date, 'YYYY-MM-DD') AS date,
    COALESCE(SUM(r.amount), 0) AS revenue
FROM date_range d
LEFT JOIN daily_revenue r
    ON TO_CHAR(d.full_date, 'YYYY-MM-DD') = r.date
GROUP BY 
    d.full_date
ORDER BY 
    date ASC;
