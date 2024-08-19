/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/


SELECT
    skills_dim.skills,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS average_salary
FROM
    job_postings_fact
INNER JOIN 
    skills_job_dim 
ON 
    job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim 
ON 
    skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_postings_fact.job_title_short = 'Data Analyst' 
    AND job_postings_fact.salary_year_avg IS NOT NULL 
    AND job_postings_fact.job_work_from_home = TRUE
GROUP BY 
    skills_dim.skills
ORDER BY 
    average_salary DESC
LIMIT 25;

/*
Here's a breakdown of the results for top paying skills for Data Analysts:
- High Demand for Big Data & ML Skills: Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.
- Software Development & Deployment Proficiency: Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation and efficient data pipeline management.
- Cloud Computing Expertise: Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analytics.
[
  {
    "skills": "pyspark",
    "average_salary": "208172"
  },
  {
    "skills": "bitbucket",
    "average_salary": "189155"
  },
  {
    "skills": "couchbase",
    "average_salary": "160515"
  },
  {
    "skills": "watson",
    "average_salary": "160515"
  },
  {
    "skills": "datarobot",
    "average_salary": "155486"
  },
  {
    "skills": "gitlab",
    "average_salary": "154500"
  },
  {
    "skills": "swift",
    "average_salary": "153750"
  },
  {
    "skills": "jupyter",
    "average_salary": "152777"
  },
  {
    "skills": "pandas",
    "average_salary": "151821"
  },
  {
    "skills": "elasticsearch",
    "average_salary": "145000"
  },
  {
    "skills": "golang",
    "average_salary": "145000"
  },
  {
    "skills": "numpy",
    "average_salary": "143513"
  },
  {
    "skills": "databricks",
    "average_salary": "141907"
  },
  {
    "skills": "linux",
    "average_salary": "136508"
  },
  {
    "skills": "kubernetes",
    "average_salary": "132500"
  },
  {
    "skills": "atlassian",
    "average_salary": "131162"
  },
  {
    "skills": "twilio",
    "average_salary": "127000"
  },
  {
    "skills": "airflow",
    "average_salary": "126103"
  },
  {
    "skills": "scikit-learn",
    "average_salary": "125781"
  },
  {
    "skills": "jenkins",
    "average_salary": "125436"
  },
  {
    "skills": "notion",
    "average_salary": "125000"
  },
  {
    "skills": "scala",
    "average_salary": "124903"
  },
  {
    "skills": "postgresql",
    "average_salary": "123879"
  },
  {
    "skills": "gcp",
    "average_salary": "122500"
  },
  {
    "skills": "microstrategy",
    "average_salary": "121619"
  }
]
/*