WITH jobs_engineer AS (
    SELECT
        job_id,
        salary_year_avg
    FROM job_postings_fact
    WHERE job_title_short = 'Data Engineer'
        AND salary_year_avg IS NOT NULL
),
skills_combined AS (
    SELECT
        job_id,
        skills_job_dim.skill_id,
        skills
    FROM skills_job_dim
    JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
)
SELECT
    skills AS skill_name,
    ROUND(AVG(salary_year_avg), 2) AS average_salary
FROM jobs_engineer
JOIN skills_combined
    ON jobs_engineer.job_id = skills_combined.job_id
GROUP BY skill_name
HAVING COUNT(*) > 10
ORDER BY average_salary DESC
LIMIT 10;