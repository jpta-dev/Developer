-- CREATE TABLE job_applied
CREATE TABLE job_applied (
    id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
);

-- INSERT INTO job_applied
INSERT INTO job_applied (id, application_sent_date, custom_resume, resume_file_name, cover_letter_sent, cover_letter_file_name, status)
VALUES (1, '2026-08-10', TRUE, 'resume_john_doe.pdf', TRUE, 'cover_letter_john_doe.pdf', 'Under Review'),
       (2, '2025-10-10', FALSE, 'resume_jane_smith.pdf', FALSE, NULL, 'Applied'),
       (3, '2024-12-01', TRUE, 'resume_alex_jones.pdf', TRUE, 'cover_letter_alex_jones.pdf', 'Interview Scheduled'),
       (4, '2023-11-15', FALSE, 'resume_emma_brown.pdf', FALSE, NULL, 'Rejected'),
       (5, '2022-09-20', TRUE, 'resume_michael_white.pdf', TRUE, 'cover_letter_michael_white.pdf', 'Offer Extended');
-- SELECT all records from job_applied
SELECT * FROM job_applied;