SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs;

--------------------------------------------------

WITH q1_high_jobs AS(
    SELECT
        job_id
    FROM(
        SELECT *
        FROM january_jobs
        UNION ALL
        SELECT *
        FROM february_jobs
        UNION ALL
        SELECT *
        FROM march_jobs
    )
    WHERE
        salary_year_avg > 70000
),
q1_job_skills AS (
    SELECT
        skills_job_dim.job_id,
        skill_id
    FROM 
        q1_high_jobs LEFT JOIN skills_job_dim ON
        q1_high_jobs.job_id = skills_job_dim.job_id
)
SELECT
    job_id,
    skills,
    type
FROM
    q1_job_skills LEFT JOIN skills_dim ON
    q1_job_skills.skill_id = skills_dim.skill_id;

--------------------------------------------------

SELECT
    job_title_short,
    job_location,
    job_via,
    job_posted_date::date,
    salary_year_avg
FROM(
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS qtr1_job_postings
WHERE
    salary_year_avg > 70000 and
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg desc