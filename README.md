# Introduction

📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [project_sql folder](https://github.com/rachidlabsir/SQL_DATA_ANALYTICS_folder/tree/main/data_jobs/project_sql)

# Background

Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

Data hails from my SQL Course. It's packed with insights on job titles, salaries, locations, and essential skills.
The questions I wanted to answer through my SQL queries were:

    1-What are the top-paying data analyst jobs?
    2-What skills are required for these top-paying jobs?
    3-What skills are most in demand for data analysts?
    4-Which skills are associated with higher salaries?
    5-What are the most optimal skills to learn?

# Tools I Used

For my deep dive into the data analyst job market, I harnessed the power of several key tools:

**SQL**: The backbone of my analysis, allowing me to query the database and unearth critical insights.
    
**PostgreSQL**: The chosen database management system, ideal for handling the job posting data.

**Visual Studio Code**: My go-to for database management and executing SQL queries.
    
**Git & GitHub**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis

Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

## 1. Top Paying Data Analyst Jobs

To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.
```sql
SELECT 
    job_id,
    job_title,
    name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM 
    job_postings_fact
LEFT JOIN 
    company_dim 
ON 
    job_postings_fact.company_id = company_dim.company_id
WHERE 
    salary_year_avg IS NOT NULL 
    AND job_title_short = 'Data Analyst' 
    AND job_location = 'Anywhere'
ORDER BY 
    salary_year_avg DESC
LIMIT 10;
```
Here’s a snapshot of the top data analyst jobs in 2023:

  **Wide Salary Range** : The top 10 highest-paying data analyst roles offer salaries ranging from $184,000 to $650,000, highlighting the substantial earning potential in the field.
  
  **Diverse Employers** : Companies such as SmartAsset, Meta, and AT&T are offering competitive salaries, demonstrating interest across various industries.
  
  **Varied Job Titles**: There is a broad spectrum of job titles, from Data Analyst to Director of Analytics, showcasing the diverse roles and specializations within data analytics.
  
## 2. Skills for Top-Paying Jobs

To determine the skills needed for the highest-paying roles, I merged job postings with skills data. This analysis reveals the key competencies employers prioritize for high-compensation positions.
```sql

WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        name AS company_name,
        job_schedule_type,
        salary_year_avg
    FROM 
        job_postings_fact
    LEFT JOIN 
        company_dim 
    ON 
        job_postings_fact.company_id = company_dim.company_id
    WHERE 
        salary_year_avg IS NOT NULL 
        AND job_title_short = 'Data Analyst' 
        AND job_location = 'Anywhere'
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
)
SELECT 
    top_paying_jobs.*, 
    skills_dim.skills
FROM 
    top_paying_jobs
INNER JOIN  
    skills_job_dim 
ON 
    top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim
ON 
    skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    top_paying_jobs.salary_year_avg DESC;

```

### Key Takeaways:

**SQL and Python** are consistently in demand across the top-paying positions, highlighting their importance in the data analysis field.

**Tableau** is also highly sought after, making it a valuable skill for data analysts aiming for high salaries.

Other skills like **R**, **Snowflake**, **Pandas**, and **Excel** are valuable but less frequently required compared to SQL and Python.

## 3. In-Demand Skills for Data Analysts

This query pinpointed the skills most commonly sought in job postings, highlighting areas with the highest demand.

```sql
SELECT
    skills_job_dim.skill_id,
    COUNT(skills_job_dim.job_id) AS demand_count
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
GROUP BY 
    skills_job_dim.skill_id
LIMIT 5;
```

Here’s a breakdown of the most in-demand skills for data analysts in 2023:

**SQL and Excel**: These remain core competencies, underscoring the importance of strong foundational skills in data processing and spreadsheet management.

**Programming and Visualization Tools**: Skills in Python, Tableau, and Power BI are increasingly vital, reflecting the growing need for technical expertise in data visualization and decision-making support.

## 4. Skills Based on Salary

Analyzing the average salaries linked to various skills highlighted which competencies command the highest pay.
```sql
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
```

**High Demand for Big Data & Machine Learning Skills**: Analysts proficient in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy) command the highest salaries. This reflects the industry’s strong valuation of data processing and predictive modeling expertise.

**Software Development & Deployment Proficiency**: Expertise in development and deployment tools (GitLab, Kubernetes, Airflow) shows a lucrative overlap between data analysis and engineering. Skills that support automation and efficient data pipeline management are highly rewarded.

**Cloud Computing Expertise**: Knowledge of cloud and data engineering tools (Elasticsearch, Databricks, GCP) highlights the increasing importance of cloud-based analytics environments, indicating that cloud proficiency significantly enhances earning potential in data analytics.

## 5. Most Optimal Skills to Learn

By integrating insights from demand and salary data, this query identified skills that are both highly sought after and well-compensated, providing a strategic focus for skill development.

```sql
WITH demand_count AS (
    SELECT
        skills_job_dim.skill_id,
        COUNT(skills_job_dim.job_id) AS demand_count
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
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY 
        skills_job_dim.skill_id
    ORDER BY 
        demand_count DESC
),
average_salary_skills AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(salary_year_avg), 0) AS average_salary
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
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL 
        AND job_work_from_home = TRUE
    GROUP BY 
        skills_dim.skill_id
)
SELECT
    demand_count.skill_id,
    demand_count.demand_count,
    average_salary_skills.skills,
    average_salary_skills.average_salary
FROM 
    demand_count
JOIN 
    average_salary_skills
ON 
    demand_count.skill_id = average_salary_skills.skill_id
WHERE 
    demand_count.demand_count > 10
ORDER BY 
    average_salary_skills.average_salary DESC,
    demand_count.demand_count DESC
LIMIT 10;
```
Here’s a breakdown of the most optimal skills for data analysts in 2023:

**High-Demand Programming Languages**: Python and R are in high demand, with counts of 236 and 148, respectively. Despite their high demand, the average salaries are approximately $101,397 for Python and $100,499 for R, indicating that while these languages are highly valued, they are also commonly used.

**Cloud Tools and Technologies**: Skills in cloud technologies such as Snowflake, Azure, AWS, and BigQuery are in significant demand and offer relatively high average salaries. This underscores the growing importance of cloud platforms and big data technologies in the field of data analysis.

**Business Intelligence and Visualization Tools**: Tableau and Looker, with demand counts of 230 and 49, respectively, and average salaries of around $99,288 and $103,795, highlight the essential role of data visualization and business intelligence in generating actionable insights.

**Database Technologies**: Skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) show strong demand, with average salaries ranging from $97,786 to $104,534. This reflects the ongoing need for expertise in data storage, retrieval, and management.

# What I Learned

Throughout this journey, I've significantly enhanced my SQL skills:

  🧩 **Complex Query Crafting**: Mastered advanced SQL techniques, including table joins and the use of WITH clauses for sophisticated temporary table management.

  📊 **Data Aggregation**: Became adept with GROUP BY and aggregate functions like COUNT() and AVG(), transforming them into essential tools for summarizing data.

  💡 **Analytical Wizardry**: Improved my ability to tackle real-world problems by crafting actionable and insightful SQL queries from complex questions.

# Conclusions & Insights

From the analysis, several key insights emerged:

**Top-Paying Data Analyst Jobs**: Remote data analyst positions offer a broad salary range, with the highest reaching up to $650,000.

**Skills for Top-Paying Jobs**: Advanced proficiency in SQL is crucial for securing high-paying data analyst roles, making it a critical skill for top salaries.

**Most In-Demand Skills**: SQL is the most sought-after skill in the data analyst job market, highlighting its essential role for job seekers.

**Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are linked to the highest average salaries, indicating that niche expertise commands a premium.

**Optimal Skills for Market Value**: SQL stands out for both its demand and high average salary, making it one of the most valuable skills for data analysts to learn in order to enhance their market value.

