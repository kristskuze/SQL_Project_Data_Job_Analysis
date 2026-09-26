# Introduction

This project analyzes the **2023 data job market**, with the first two analyses focusing specifically on the **Baltic countries** and the remaining analyses covering the **global data job market**. The project explores job salaries, demand, roles, and skills using SQL.

The dataset is an excerpt from [Data Nerd](https://datanerd.tech/).

All SQL queries used in the analysis can be found in the [SQL Queries](./Project_sql/) folder.

# Background

The data job market is constantly evolving, with differences in salaries, job demand, roles, and required skills across regions and occupations. This project uses SQL to explore the **2023 data job market**, first examining trends in the Baltic countries and then expanding the analysis to the global market.

### Questions I Wanted to Answer

1. What are the highest-paying data roles in the Baltic countries?
2. Which skills are most commonly associated with high-paying data jobs in the Baltics?
3. Which skills are most in demand for data engineers
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools Used
The following tools were used to perform the analysis, write and manage the queries, and organize the project:
* **SQL** – Used to query, filter, aggregate, and analyze the data.
* **PostgreSQL** – Used as the database management system for running SQL queries.
* **Visual Studio Code** – Used to write, organize, and manage the SQL queries and project files.
* **Git & GitHub** – Used for version control and to store and showcase the project.

# The Analysis

The analysis explores the **2023 data job market** using SQL, beginning with the Baltic countries and then expanding to the global market. It examines **job salaries, role demand, and skill requirements**, with a focus on identifying patterns between the skills requested by employers, their demand, and associated salaries.


## 1. Top Paying Data Jobs in the Baltics

This analysis identifies the **10 highest-paying data job postings in Estonia, Latvia, and Lithuania** based on average yearly salary. The query also includes the company and job location to show where the highest-paying opportunities were found.

### SQL Code

```sql
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
```

### Findings

* **Machine Learning Engineer** at Bertelsmann had the highest listed salary at **$164,500 per year**, based in Latvia.
* **Data Engineer** was the most frequently represented role, appearing in **4 of the 10 highest-paying positions**, while Data Scientist appeared 4 times.
* All three Baltic countries were represented among the top-paying positions, with **Latvia, Estonia, and Lithuania** each having multiple high-paying opportunities.

![Top Paying Roles](assets\1_top_jobs.png)
## 2. Skills Associated With the Top-Paying Data Jobs

This analysis examines the skills listed for the **10 highest-paying data jobs in the Baltic countries**. By joining the job postings with the skills tables, the query shows which technical skills are associated with these high-paying positions.

### SQL Code

```sql
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
```

### Findings

* **Python and SQL** were among the most common skills across the highest-paying positions, particularly for Data Scientist and Data Engineer roles.
* The highest-paying **Machine Learning Engineer** position required a broad range of skills, including Python, PostgreSQL, MongoDB, AWS, Azure, Elasticsearch, and Power BI.
* **Data Engineering roles showed the broadest technical skill requirements**, with skills spanning programming, databases, cloud platforms, data tools, and infrastructure technologies such as Docker and Terraform.

![Top Paying Roles](assets\2_top_skills.png)
## 3. Most In-Demand Skills for Data Engineers

This analysis identifies the **10 most frequently requested skills in Data Engineer job postings**. The query counts how often each skill appears across Data Engineer positions to highlight the technical skills most commonly required by employers.

### SQL Code

```sql
WITH jobs_engineer AS (
    SELECT
        job_id
    FROM job_postings_fact
    WHERE job_title_short = 'Data Engineer'
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
    COUNT(*) AS skill_count
FROM jobs_engineer
JOIN skills_combined
    ON jobs_engineer.job_id = skills_combined.job_id
GROUP BY skills
ORDER BY skill_count DESC
LIMIT 10;
```


### Findings

* **SQL and Python** were the two most frequently requested skills, appearing in **113,375** and **108,265** Data Engineer postings respectively.
* **Cloud technologies were highly prominent**, with AWS and Azure appearing in over **60,000** postings each.
* The remaining top skills focused largely on **data processing and engineering infrastructure**, including Spark, Java, Kafka, Hadoop, Scala, and Databricks.

| Skill      |   Count |
| ---------- | ------: |
| SQL        | 113,375 |
| Python     | 108,265 |
| AWS        |  62,174 |
| Azure      |  60,823 |
| Spark      |  53,789 |
| Java       |  35,642 |
| Kafka      |  29,163 |
| Hadoop     |  28,883 |
| Scala      |  28,791 |
| Databricks |  27,532 |
## 4. Highest-Paying Skills for Data Engineers

This analysis examines the **average salary associated with different skills in Data Engineer job postings**. Skills with fewer than 10 job postings were excluded to reduce the impact of skills appearing only in a small number of positions.

### SQL Code

```sql
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
```

### Findings

* **Node and Mongo** had the highest average salaries among the analyzed skills, at approximately **$181,862** and **$179,403** respectively.
* Several **specialized technologies** appeared near the top, including Cassandra, Rust, Perl, Scala, and Kafka, suggesting that niche technical skills were associated with higher average salaries in the dataset.
* **Scala and Kafka**, which also appeared among the most frequently requested Data Engineer skills in the previous analysis, combined relatively high demand with average salaries above **$143,000**.

| Skill     | Average Salary |
| --------- | -------------: |
| Node      |    $181,861.78 |
| Mongo     |    $179,402.54 |
| Cassandra |    $150,255.30 |
| Rust      |    $147,770.73 |
| Perl      |    $145,539.92 |
| Angular   |    $143,318.96 |
| Scala     |    $143,161.07 |
| Kafka     |    $143,085.77 |
| GDPR      |    $142,368.74 |
| Shell     |    $141,724.61 |

## 5. Demand and Salary of Data Engineer Skills

### Summary

This analysis compares the **demand and average salary of the 20 most frequently requested Data Engineer skills**. By looking at both metrics together, it provides a broader view of which skills are widely requested and the average salaries associated with them.

### SQL Code

```sql
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
    ROUND(AVG(salary_year_avg), 2) AS average_salary,
    COUNT(*) AS skill_demand
FROM jobs_engineer
JOIN skills_combined
    ON jobs_engineer.job_id = skills_combined.job_id
GROUP BY skill_name
ORDER BY COUNT(*) DESC
LIMIT 20;
```

### Findings

| Skill      | Average Salary | Demand |
| ---------- | -------------: | -----: |
| SQL        |    $128,461.21 |  3,189 |
| Python     |    $132,107.06 |  3,041 |
| AWS        |    $134,072.43 |  2,000 |
| Spark      |    $136,135.77 |  1,587 |
| Azure      |    $129,152.29 |  1,459 |
| Java       |    $137,307.43 |  1,154 |
| Snowflake  |    $137,425.78 |  1,072 |
| Kafka      |    $143,085.77 |    872 |
| Hadoop     |    $135,678.76 |    839 |
| NoSQL      |    $136,546.81 |    822 |
| Scala      |    $143,161.07 |    794 |
| Redshift   |    $139,526.65 |    780 |
| Airflow    |    $137,261.53 |    737 |
| Databricks |    $128,179.81 |    653 |
| Tableau    |    $123,399.06 |    608 |
| SQL Server |    $119,234.63 |    506 |
| Git        |    $126,869.31 |    495 |
| GCP        |    $126,594.29 |    471 |
| MongoDB    |    $130,254.87 |    460 |
| Oracle     |    $120,759.48 |    460 |

* **SQL and Python had the highest demand**, appearing in 3,189 and 3,041 Data Engineer job postings respectively. They were also associated with average salaries above **$128,000**.
* **Kafka and Scala had some of the highest average salaries** among the 20 most demanded skills, at approximately **$143,086** and **$143,161**, despite appearing in fewer postings than SQL, Python, and the major cloud platforms.
* The results show that **higher demand does not necessarily correspond to the highest average salary**. For example, SQL had the highest demand but a lower average salary than several less frequently requested skills such as Kafka, Scala, and Redshift.

# What I Learned

Through this project, I strengthened my SQL skills by working with **CTEs, joins, filtering, aggregation, grouping, and sorting** to answer practical data analysis questions.

I also learned how to:

* Analyze relationships between **job demand, salaries, and skills**.
* Work with larger datasets and extract meaningful insights from raw job-posting data.
* Present SQL analysis in a clear and structured way to make findings easier to understand.
* Recognize that salary differences associated with specific skills do not necessarily imply that the skill itself causes higher salaries.

# Conclusion

### Insights

* **SQL and Python remain highly in-demand skills**, particularly for Data Engineer roles, appearing in more job postings than other analyzed skills.
* **Cloud and data engineering technologies** such as AWS, Azure, Spark, Kafka, and Databricks are also widely requested, highlighting the broad technical skill set expected in Data Engineering.
* **Higher demand does not always correspond to higher salaries.** Skills such as Kafka and Scala had lower demand than SQL and Python but were associated with higher average salaries in the dataset.
* In the **Baltic job market**, Data Engineer and Data Scientist roles appeared frequently among the highest-paying positions, with opportunities represented across Estonia, Latvia, and Lithuania.
* The analysis shows that **salary, demand, and skills are related but distinct factors**, providing different perspectives on the data job market.

### Closing toughts

This project provided an opportunity to apply SQL to a real-world dataset and explore how **job roles, salaries, demand, and skills** vary across the data job market. The analysis highlighted the importance of combining multiple perspectives rather than looking at salary or demand alone.

Overall, the project strengthened my ability to use SQL for **data exploration, analysis, and extracting actionable insights from large datasets**.
