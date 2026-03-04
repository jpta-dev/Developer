--Chained/Sequential CTE
-- Follow a funnel pattern but not a funnel idk

-- delete this later

--1. What are the top paying jobs for my choosen role (Data Analyst)
WITH top_paying_role_choosen AS (
    SELECT job_id, job_title_short, salary_year_avg
    FROM job_postings_fact
    WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
    
),

--2. What are the skills required for these top paying jobs (Data Analyst)
 skills_required AS ( 
    SELECT top_paying_role_choosen.job_title_short, top_paying_role_choosen.salary_year_avg, skills_dim.skills
    FROM top_paying_role_choosen
    LEFT JOIN skills_job_dim ON top_paying_role_choosen.job_id = skills_job_dim.job_id
    LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE skills_dim.skills IS NOT NULL
),

--3. What are the most in demand skills for my role (Data Analyst)
in_demand_skills AS ( 
    SELECT skills_dim.skills, COUNT(skills_dim.skills) AS skill_count
    FROM job_postings_fact
    LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_postings_fact.job_title_short = 'Data Analyst'
    GROUP BY skills

),

--4. What are the top skills based on my salary for my role (Data Analyst)
top_skills_based_salary_role AS (
    SELECT skills_dim.skills AS skills, ROUND(AVG(salary_year_avg), 0) AS avg_all 
    FROM job_postings_fact
    LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
    GROUP BY skills
),


/** what are the most optimal skills to learn
    a.) Optimal: High demand and High Paying
**/
optimal_skills_to_learn AS (
    SELECT
        in_demand_skills.skills, 
        in_demand_skills.skill_count AS High_demand, 
        top_skills_based_salary_role.avg_all AS High_paying
    FROM in_demand_skills
    JOIN top_skills_based_salary_role ON in_demand_skills.skills = top_skills_based_salary_role.skills

)
SELECT * FROM optimal_skills_to_learn
ORDER BY High_demand DESC, High_paying DESC;