WITH top_jobs AS (
    SELECT
        job_title_short,
        company_id,
        job_country,
        salary_year_avg,
        job_id
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
        AND job_country IN ('Estonia', 'Latvia', 'Lithuania')
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT
    top_jobs.job_id,
    job_country,
    job_title_short,
    name AS company_name,
    salary_year_avg,
    skills
FROM top_jobs
LEFT JOIN company_dim
    ON top_jobs.company_id = company_dim.company_id
LEFT JOIN skills_job_dim
    JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    ON top_jobs.job_id = skills_job_dim.job_id
ORDER BY salary_year_avg DESC;