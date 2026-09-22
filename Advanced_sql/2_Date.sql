-- date
SELECT extract(
        month
        from job_posted_date at time zone 'UTC' at time zone 'America/New_York'
    ) as month,
    count(job_id) as total_jobs
from job_postings_fact
where extract(
        year
        from job_posted_date
    ) = '2023'
GROUP BY month
ORDER BY month;
--
SELECT company_dim.name
from job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
where job_health_insurance = 'TRUE'
    and extract(
        quarter
        from job_posted_date
    ) = '2'
    and extract(
        year
        from job_posted_date
    ) = '2023'
Group by company_dim.name;
SELECT *
FROM job_postings_fact
LIMIT 10;