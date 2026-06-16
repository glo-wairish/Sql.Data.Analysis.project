/*What skills are required for top -paying data scientist jobs.
-Use the top 10 highest paying data scientist jobs from 1st query.
-Add specific skills required for these roles.
-Why?It provides a detailed look at which high paying jobs demand certain skills,
helping the job seekers to understand which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS (
    SELECT
        j.job_id,
        j.job_title,
        j.job_location,
        j.job_schedule_type,
        j.salary_year_avg,
        j.job_posted_date,
        c.company_id,
        c.name AS company_name
    FROM 
        job_postings_fact j
    LEFT JOIN company_dim c ON j.company_id = c.company_id
    WHERE 
        j.job_title_short = 'Data Scientist' AND
        j.salary_year_avg IS NOT NULL AND
        j.job_location = 'Anywhere'
    ORDER BY 
        j.salary_year_avg DESC
    LIMIT 10 
)

SELECT 
    tp.job_title,
    tp.company_name,
    tp.salary_year_avg,
    s.skills,
    s.skill_id
FROM 
    top_paying_jobs tp
JOIN 
    skills_job_dim sj ON tp.job_id = sj.job_id
JOIN 
    skills_dim s ON sj.skill_id = s.skill_id
ORDER BY 
    tp.salary_year_avg DESC;