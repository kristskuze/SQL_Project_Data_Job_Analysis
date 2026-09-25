WITH jobs_engineer AS(
    SELECT
        job_id,
        salary_year_avg
    FROM
        job_postings_fact
    WHERE
        job_title_short = 'Data Engineer' and
        salary_year_avg IS NOT NULL
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
    ROUND(AVG(salary_year_avg),2) AS average_salary
FROM
    jobs_engineer JOIN skills_combined ON
    jobs_engineer.job_id = skills_combined.job_id
GROUP BY
    skill_name
HAVING
    COUNT(*) > 10
ORDER BY
    average_salary desc
LIMIT 10
;

/*
Node.js and MongoDB stand out: They have the highest average salaries at about $182K and $179K, significantly above the other skills.
Distributed-data technologies are prominent: Cassandra, Scala, and Kafka suggest that high-paying data-engineering roles are strongly associated with scalable databases, streaming, and distributed systems.
The skill mix is broad: The list combines programming, databases, infrastructure, web development, and GDPR, showing that high-paying data engineers may need both technical and data-governance expertise.

[
  {
    "skill_name": "node",
    "average_salary": "181861.78"
  },
  {
    "skill_name": "mongo",
    "average_salary": "179402.54"
  },
  {
    "skill_name": "cassandra",
    "average_salary": "150255.30"
  },
  {
    "skill_name": "rust",
    "average_salary": "147770.73"
  },
  {
    "skill_name": "perl",
    "average_salary": "145539.92"
  },
  {
    "skill_name": "angular",
    "average_salary": "143318.96"
  },
  {
    "skill_name": "scala",
    "average_salary": "143161.07"
  },
  {
    "skill_name": "kafka",
    "average_salary": "143085.77"
  },
  {
    "skill_name": "gdpr",
    "average_salary": "142368.74"
  },
  {
    "skill_name": "shell",
    "average_salary": "141724.61"
  }
]
*/