WITH jobs_engineer AS(
    SELECT
        job_id
    FROM
        job_postings_fact
    WHERE
        job_title_short = 'Data Engineer'
),
skills_combined AS(
    SELECT
        job_id,
        skills_job_dim.skill_id,
        skills
    FROM skills_job_dim JOIN skills_dim ON
    skills_job_dim.skill_id = skills_dim.skill_id
)

SELECT
    skills AS skill_name,
    count(*) AS skill_count
FROM
    jobs_engineer JOIN skills_combined ON
    jobs_engineer.job_id = skills_combined.job_id
GROUP BY
    skills
ORDER BY
    skill_count DESC
LIMIT 10
;