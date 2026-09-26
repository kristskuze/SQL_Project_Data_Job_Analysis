WITH top_jobs AS (
    SELECT
        job_title_short,
        company_id,
        job_location,
        salary_year_avg
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
        AND job_country IN ('Estonia', 'Latvia', 'Lithuania')
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT
    name AS company_name,
    job_title_short,
    job_location,
    salary_year_avg
FROM top_jobs
LEFT JOIN company_dim
    ON top_jobs.company_id = company_dim.company_id;