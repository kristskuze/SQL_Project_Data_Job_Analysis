SELECT
	CASE
		WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
		ELSE 'Onsite'
	END AS job_loc_class,
    COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    job_loc_class
;
-- Problem 1
SELECT 
    job_id,
    salary_hour_avg,
    CASE
        WHEN salary_hour_avg < 25 THEN 'Low'
        WHEN salary_hour_avg < 60 THEN 'Standard'
        ELSE 'High'
    END AS salary_range
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
    and salary_hour_avg IS NOT NULL
;