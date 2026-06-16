/*
Question:What are the top skills based on salary?
-Look at the average salary associated with each skill for Data Scientist position.
-Focuses on roles with specified salaries,regardless of location.
-Why?It reveals how different skills impact salary levels for data scientists and 
helps identify the most financially rewarding skills to acquire or improve .
*/
SELECT
    j.job_id,
    j.job_title_short,
    ROUND(AVG(j.salary_year_avg),2) AS average_salary,
    j.job_location,
    s.skills,
    s.skill_id 
FROM job_postings_fact j
JOIN skills_job_dim sj ON j.job_id = sj.job_id
JOIN skills_dim s ON sj.skill_id = s.skill_id
WHERE 
    j.salary_year_avg IS NOT NULL AND
    job_title_short = 'Data Scientist'
GROUP BY 
    s.skill_id,
    s.skills,
    j.job_id
ORDER BY average_salary DESC
LIMIT 25;


