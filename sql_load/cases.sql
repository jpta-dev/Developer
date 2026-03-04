SELECT
    COUNT(job_id) AS no_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS job_location_category 
    FROM job_postings_fact
    WHERE
        job_title_short IN ('Data Analyst')
    GROUP BY 
        job_location_category;

