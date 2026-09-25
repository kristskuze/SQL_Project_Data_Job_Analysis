WITH top_jobs AS(
    SELECT
        job_title_short,
        company_id,
        job_country,
        salary_year_avg,
        job_id
    FROM
        job_postings_fact
    WHERE
        salary_year_avg IS NOT NULL AND
        job_country IN ('Estonia', 'Latvia', 'Lithuania')
    ORDER BY
        salary_year_avg desc
    LIMIT 10
)

SELECT
    top_jobs.job_id,
    job_country,
    job_title_short,
    name AS company_name,
    salary_year_avg,
    skills
FROM
    top_jobs LEFT JOIN company_dim ON
    top_jobs.company_id = company_dim.company_id
    LEFT JOIN skills_job_dim
        JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    ON
    top_jobs.job_id = skills_job_dim.job_id
ORDER BY
    salary_year_avg desc
;

/*
Key insight

The clearest finding is:

Python is the most frequently requested skill, appearing in 9 out of 10 (90%) of the highest-paying data jobs, followed by SQL at 60%.

After these two, there is a significant drop-off. Azure appears in 40%, while Airflow, AWS and R each appear in 30%.

So the frequency distribution suggests a core → specialization structure:

Core skills

Python
SQL

Common supporting skills

Azure
AWS
Airflow
R

[
  {
    "job_id": 962791,
    "job_country": "Latvia",
    "job_title_short": "Machine Learning Engineer",
    "company_name": "Bertelsmann",
    "salary_year_avg": "164500.0",
    "skills": "python"
  },
  {
    "job_id": 962791,
    "job_country": "Latvia",
    "job_title_short": "Machine Learning Engineer",
    "company_name": "Bertelsmann",
    "salary_year_avg": "164500.0",
    "skills": "mongodb"
  },
  {
    "job_id": 962791,
    "job_country": "Latvia",
    "job_title_short": "Machine Learning Engineer",
    "company_name": "Bertelsmann",
    "salary_year_avg": "164500.0",
    "skills": "postgresql"
  },
  {
    "job_id": 962791,
    "job_country": "Latvia",
    "job_title_short": "Machine Learning Engineer",
    "company_name": "Bertelsmann",
    "salary_year_avg": "164500.0",
    "skills": "elasticsearch"
  },
  {
    "job_id": 962791,
    "job_country": "Latvia",
    "job_title_short": "Machine Learning Engineer",
    "company_name": "Bertelsmann",
    "salary_year_avg": "164500.0",
    "skills": "mongodb"
  },
  {
    "job_id": 962791,
    "job_country": "Latvia",
    "job_title_short": "Machine Learning Engineer",
    "company_name": "Bertelsmann",
    "salary_year_avg": "164500.0",
    "skills": "azure"
  },
  {
    "job_id": 962791,
    "job_country": "Latvia",
    "job_title_short": "Machine Learning Engineer",
    "company_name": "Bertelsmann",
    "salary_year_avg": "164500.0",
    "skills": "aws"
  },
  {
    "job_id": 962791,
    "job_country": "Latvia",
    "job_title_short": "Machine Learning Engineer",
    "company_name": "Bertelsmann",
    "salary_year_avg": "164500.0",
    "skills": "power bi"
  },
  {
    "job_id": 962791,
    "job_country": "Latvia",
    "job_title_short": "Machine Learning Engineer",
    "company_name": "Bertelsmann",
    "salary_year_avg": "164500.0",
    "skills": "flow"
  },
  {
    "job_id": 506488,
    "job_country": "Estonia",
    "job_title_short": "Data Scientist",
    "company_name": "Jobbatical",
    "salary_year_avg": "157500.0",
    "skills": "sql"
  },
  {
    "job_id": 506488,
    "job_country": "Estonia",
    "job_title_short": "Data Scientist",
    "company_name": "Jobbatical",
    "salary_year_avg": "157500.0",
    "skills": "python"
  },
  {
    "job_id": 506488,
    "job_country": "Estonia",
    "job_title_short": "Data Scientist",
    "company_name": "Jobbatical",
    "salary_year_avg": "157500.0",
    "skills": "node"
  },
  {
    "job_id": 506488,
    "job_country": "Estonia",
    "job_title_short": "Data Scientist",
    "company_name": "Jobbatical",
    "salary_year_avg": "157500.0",
    "skills": "looker"
  },
  {
    "job_id": 506488,
    "job_country": "Estonia",
    "job_title_short": "Data Scientist",
    "company_name": "Jobbatical",
    "salary_year_avg": "157500.0",
    "skills": "github"
  },
  {
    "job_id": 152373,
    "job_country": "Lithuania",
    "job_title_short": "Data Scientist",
    "company_name": "Hostinger",
    "salary_year_avg": "157500.0",
    "skills": "sql"
  },
  {
    "job_id": 152373,
    "job_country": "Lithuania",
    "job_title_short": "Data Scientist",
    "company_name": "Hostinger",
    "salary_year_avg": "157500.0",
    "skills": "python"
  },
  {
    "job_id": 152373,
    "job_country": "Lithuania",
    "job_title_short": "Data Scientist",
    "company_name": "Hostinger",
    "salary_year_avg": "157500.0",
    "skills": "pytorch"
  },
  {
    "job_id": 152373,
    "job_country": "Lithuania",
    "job_title_short": "Data Scientist",
    "company_name": "Hostinger",
    "salary_year_avg": "157500.0",
    "skills": "git"
  },
  {
    "job_id": 152373,
    "job_country": "Lithuania",
    "job_title_short": "Data Scientist",
    "company_name": "Hostinger",
    "salary_year_avg": "157500.0",
    "skills": "jira"
  },
  {
    "job_id": 403400,
    "job_country": "Lithuania",
    "job_title_short": "Data Scientist",
    "company_name": "Hostinger",
    "salary_year_avg": "155000.0",
    "skills": "python"
  },
  {
    "job_id": 403400,
    "job_country": "Lithuania",
    "job_title_short": "Data Scientist",
    "company_name": "Hostinger",
    "salary_year_avg": "155000.0",
    "skills": "r"
  },
  {
    "job_id": 403400,
    "job_country": "Lithuania",
    "job_title_short": "Data Scientist",
    "company_name": "Hostinger",
    "salary_year_avg": "155000.0",
    "skills": "bigquery"
  },
  {
    "job_id": 403400,
    "job_country": "Lithuania",
    "job_title_short": "Data Scientist",
    "company_name": "Hostinger",
    "salary_year_avg": "155000.0",
    "skills": "airflow"
  },
  {
    "job_id": 403400,
    "job_country": "Lithuania",
    "job_title_short": "Data Scientist",
    "company_name": "Hostinger",
    "salary_year_avg": "155000.0",
    "skills": "tableau"
  },
  {
    "job_id": 403400,
    "job_country": "Lithuania",
    "job_title_short": "Data Scientist",
    "company_name": "Hostinger",
    "salary_year_avg": "155000.0",
    "skills": "git"
  },
  {
    "job_id": 58965,
    "job_country": "Latvia",
    "job_title_short": "Data Engineer",
    "company_name": "Bertelsmann",
    "salary_year_avg": "154000.0",
    "skills": "sql"
  },
  {
    "job_id": 58965,
    "job_country": "Latvia",
    "job_title_short": "Data Engineer",
    "company_name": "Bertelsmann",
    "salary_year_avg": "154000.0",
    "skills": "python"
  },
  {
    "job_id": 58965,
    "job_country": "Latvia",
    "job_title_short": "Data Engineer",
    "company_name": "Bertelsmann",
    "salary_year_avg": "154000.0",
    "skills": "azure"
  },
  {
    "job_id": 58965,
    "job_country": "Latvia",
    "job_title_short": "Data Engineer",
    "company_name": "Bertelsmann",
    "salary_year_avg": "154000.0",
    "skills": "databricks"
  },
  {
    "job_id": 58965,
    "job_country": "Latvia",
    "job_title_short": "Data Engineer",
    "company_name": "Bertelsmann",
    "salary_year_avg": "154000.0",
    "skills": "aws"
  },
  {
    "job_id": 58965,
    "job_country": "Latvia",
    "job_title_short": "Data Engineer",
    "company_name": "Bertelsmann",
    "salary_year_avg": "154000.0",
    "skills": "gcp"
  },
  {
    "job_id": 58965,
    "job_country": "Latvia",
    "job_title_short": "Data Engineer",
    "company_name": "Bertelsmann",
    "salary_year_avg": "154000.0",
    "skills": "airflow"
  },
  {
    "job_id": 58965,
    "job_country": "Latvia",
    "job_title_short": "Data Engineer",
    "company_name": "Bertelsmann",
    "salary_year_avg": "154000.0",
    "skills": "dax"
  },
  {
    "job_id": 58965,
    "job_country": "Latvia",
    "job_title_short": "Data Engineer",
    "company_name": "Bertelsmann",
    "salary_year_avg": "154000.0",
    "skills": "github"
  },
  {
    "job_id": 118905,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Veriff",
    "salary_year_avg": "147500.0",
    "skills": "sql"
  },
  {
    "job_id": 118905,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Veriff",
    "salary_year_avg": "147500.0",
    "skills": "python"
  },
  {
    "job_id": 118905,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Veriff",
    "salary_year_avg": "147500.0",
    "skills": "r"
  },
  {
    "job_id": 118905,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Veriff",
    "salary_year_avg": "147500.0",
    "skills": "go"
  },
  {
    "job_id": 118905,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Veriff",
    "salary_year_avg": "147500.0",
    "skills": "redshift"
  },
  {
    "job_id": 118905,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Veriff",
    "salary_year_avg": "147500.0",
    "skills": "airflow"
  },
  {
    "job_id": 95929,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Proekspert",
    "salary_year_avg": "147500.0",
    "skills": "sql"
  },
  {
    "job_id": 95929,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Proekspert",
    "salary_year_avg": "147500.0",
    "skills": "python"
  },
  {
    "job_id": 95929,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Proekspert",
    "salary_year_avg": "147500.0",
    "skills": "nosql"
  },
  {
    "job_id": 95929,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Proekspert",
    "salary_year_avg": "147500.0",
    "skills": "scala"
  },
  {
    "job_id": 95929,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Proekspert",
    "salary_year_avg": "147500.0",
    "skills": "java"
  },
  {
    "job_id": 95929,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Proekspert",
    "salary_year_avg": "147500.0",
    "skills": "mongodb"
  },
  {
    "job_id": 95929,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Proekspert",
    "salary_year_avg": "147500.0",
    "skills": "mongodb"
  },
  {
    "job_id": 95929,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Proekspert",
    "salary_year_avg": "147500.0",
    "skills": "dynamodb"
  },
  {
    "job_id": 95929,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Proekspert",
    "salary_year_avg": "147500.0",
    "skills": "azure"
  },
  {
    "job_id": 95929,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Proekspert",
    "salary_year_avg": "147500.0",
    "skills": "aws"
  },
  {
    "job_id": 95929,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Proekspert",
    "salary_year_avg": "147500.0",
    "skills": "redshift"
  },
  {
    "job_id": 95929,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Proekspert",
    "salary_year_avg": "147500.0",
    "skills": "snowflake"
  },
  {
    "job_id": 95929,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Proekspert",
    "salary_year_avg": "147500.0",
    "skills": "kafka"
  },
  {
    "job_id": 95929,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Proekspert",
    "salary_year_avg": "147500.0",
    "skills": "express"
  },
  {
    "job_id": 95929,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Proekspert",
    "salary_year_avg": "147500.0",
    "skills": "linux"
  },
  {
    "job_id": 95929,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Proekspert",
    "salary_year_avg": "147500.0",
    "skills": "terraform"
  },
  {
    "job_id": 95929,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Proekspert",
    "salary_year_avg": "147500.0",
    "skills": "docker"
  },
  {
    "job_id": 95929,
    "job_country": "Estonia",
    "job_title_short": "Data Engineer",
    "company_name": "Proekspert",
    "salary_year_avg": "147500.0",
    "skills": "ansible"
  },
  {
    "job_id": 296387,
    "job_country": "Lithuania",
    "job_title_short": "Data Engineer",
    "company_name": "Baltic Amadeus",
    "salary_year_avg": "147500.0",
    "skills": "sql"
  },
  {
    "job_id": 296387,
    "job_country": "Lithuania",
    "job_title_short": "Data Engineer",
    "company_name": "Baltic Amadeus",
    "salary_year_avg": "147500.0",
    "skills": "python"
  },
  {
    "job_id": 296387,
    "job_country": "Lithuania",
    "job_title_short": "Data Engineer",
    "company_name": "Baltic Amadeus",
    "salary_year_avg": "147500.0",
    "skills": "r"
  },
  {
    "job_id": 296387,
    "job_country": "Lithuania",
    "job_title_short": "Data Engineer",
    "company_name": "Baltic Amadeus",
    "salary_year_avg": "147500.0",
    "skills": "azure"
  },
  {
    "job_id": 280904,
    "job_country": "Lithuania",
    "job_title_short": "Data Analyst",
    "company_name": "Wolt",
    "salary_year_avg": "125000.0",
    "skills": "go"
  },
  {
    "job_id": 280904,
    "job_country": "Lithuania",
    "job_title_short": "Data Analyst",
    "company_name": "Wolt",
    "salary_year_avg": "125000.0",
    "skills": "looker"
  },
  {
    "job_id": 280904,
    "job_country": "Lithuania",
    "job_title_short": "Data Analyst",
    "company_name": "Wolt",
    "salary_year_avg": "125000.0",
    "skills": "alteryx"
  },
  {
    "job_id": 36662,
    "job_country": "Estonia",
    "job_title_short": "Data Scientist",
    "company_name": "Workato",
    "salary_year_avg": "120000.0",
    "skills": "python"
  }
]
*/