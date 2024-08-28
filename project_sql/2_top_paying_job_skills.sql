/*
Question: What skills are required for these top paying data analyst jobs?
-Use the top 10 highest paying Data Aanlyst roles from first query
-Add specific skills required for these roles
-Why? It provides a detailed look at which high paying jobs demand certain skills, helping job seekers understand which skills
to develop that align with top salaries
*/

WITH top_paying_jobs AS(
    SELECT
        job_postings_fact.job_id,
        job_title,
        name AS company_name,
        salary_year_avg
    FROM
        job_postings_fact
    LEFT JOIN
        company_dim ON company_dim.company_id = job_postings_fact.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        NOT salary_year_avg IS NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM 
    top_paying_jobs
INNER JOIN
    skills_job_dim ON skills_job_dim.job_id = top_paying_jobs.job_id
INNER JOIN
    skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY
    salary_year_avg DESC