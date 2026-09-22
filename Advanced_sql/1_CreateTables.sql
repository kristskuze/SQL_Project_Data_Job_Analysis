drop TABLE job_applied;

--jan
CREATE table january_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH from job_posted_date) = 1;
--feb
CREATE table february_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH from job_posted_date) = 2;
--mar
CREATE table march_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH from job_posted_date) = 3;
--
SELECT *
FROM january_jobsš
LIMIT 100;