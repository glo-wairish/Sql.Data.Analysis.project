/*
*Question:What are the most in demand skills for data scientists.
-Join job postings to inner join table similar to query 2
-Identify the top 5 in demand skills for a data scientist.
-Focus on all Job Postings
-Why?Retrieve the top 5 skills with the highest demand in the job market,
providing insights into the most valuable skills for Job seekers
*/
WITH data_scientist_jobs AS (
    SELECT
        j.job_id
    FROM 
        job_postings_fact j
    WHERE 
        j.job_title_short = 'Data Scientist'
    
)

SELECT
    s.skills,
    s.skill_id,
    COUNT(sj.job_id) AS skill_count
FROM 
    skills_dim s
JOIN 
    skills_job_dim sj ON s.skill_id = sj.skill_id
JOIN 
    data_scientist_jobs ds ON sj.job_id = ds.job_id
GROUP BY 
    s.skills, s.skill_id 
ORDER BY 
    skill_count DESC
LIMIT 5;