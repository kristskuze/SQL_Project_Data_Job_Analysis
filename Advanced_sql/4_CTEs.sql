SELECT *
FROM (
        SELECT *
        FROM job_postings_fact
        WHERE EXTRACT(
                MONTH from job_posted_date
            ) = 1
    ) AS january_jobs;
--
WITH january_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(
            MONTH from job_posted_date
        ) = 1
)
SELECT *
FROM january_jobs;
--
SELECT 
    name AS company_name,
    company_id
FROM company_dim
WHERE company_id IN(
    SELECT company_id
    FROM job_postings_fact
    WHERE job_no_degree_mention = true
);
--
WITH company_job_count AS(
    SELECT
        company_id,
        count(*) AS job_postings
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT 
    name,
    job_postings
FROM 
    company_dim LEFT JOIN company_job_count ON
    company_dim.company_id = company_job_count.company_id
ORDER BY
    job_postings desc;

--------

WITH top_skills AS(
    SELECT count(*) AS skill_count,
    skill_id
    FROM skills_job_dim
    GROUP BY skill_id
)

SELECT skills,
    skill_count
FROM skills_dim LEFT JOIN top_skills ON
    skills_dim.skill_id = top_skills.skill_id
ORDER BY
    skill_count desc;

------

WITH company_jobs AS(
    SELECT
        count(*) AS job_count,
        company_id
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT
    name,
    job_count,
    CASE
        WHEN job_count < 10 THEN 'Small'
        WHEN job_count < 50 THEN 'Medium'
        ELSE 'Large'
    END AS job_count_category
FROM
    company_dim LEFT JOIN company_jobs ON
    company_dim.company_id = company_jobs.company_id;

----------

WITH remote_jobs AS(
    SELECT
        job_id
    FROM
        job_postings_fact
    WHERE
        job_work_from_home = true and
        job_title_short = 'Data Analyst'
),
remote_job_skills AS(
    SELECT
        count(*) AS remote_job_count,
        skill_id
    FROM
        remote_jobs INNER JOIN skills_job_dim ON
        remote_jobs.job_id = skills_job_dim.job_id
    GROUP BY
        skill_id
)

SELECT
    remote_job_skills.skill_id,
    skills AS skill_name,
    remote_job_count
FROM
    remote_job_skills LEFT JOIN skills_dim ON
    remote_job_skills.skill_id = skills_dim.skill_id
ORDER BY
    remote_job_count desc
LIMIT 5
;