/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/


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


/*
Here's the breakdown of the most demanded skills for data analysts in 2023
SQL and Excel remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
Programming and Visualization Tools like Python, Tableau, and Power BI are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.
[
  {
    "skill_id": 8,
    "demand_count": "27",
    "skills": "go",
    "average_salary": "115320"
  },
  {
    "skill_id": 234,
    "demand_count": "11",
    "skills": "confluence",
    "average_salary": "114210"
  },
  {
    "skill_id": 97,
    "demand_count": "22",
    "skills": "hadoop",
    "average_salary": "113193"
  },
  {
    "skill_id": 80,
    "demand_count": "37",
    "skills": "snowflake",
    "average_salary": "112948"
  },
  {
    "skill_id": 74,
    "demand_count": "34",
    "skills": "azure",
    "average_salary": "111225"
  },
  {
    "skill_id": 77,
    "demand_count": "13",
    "skills": "bigquery",
    "average_salary": "109654"
  },
  {
    "skill_id": 76,
    "demand_count": "32",
    "skills": "aws",
    "average_salary": "108317"
  },
  {
    "skill_id": 4,
    "demand_count": "17",
    "skills": "java",
    "average_salary": "106906"
  },
  {
    "skill_id": 194,
    "demand_count": "12",
    "skills": "ssis",
    "average_salary": "106683"
  },
  {
    "skill_id": 233,
    "demand_count": "20",
    "skills": "jira",
    "average_salary": "104918"
  }
]
*/