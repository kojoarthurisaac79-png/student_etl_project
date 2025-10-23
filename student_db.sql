CREATE DATABASE IF NOT EXISTS student_db;

-- Grant privileges without IDENTIFIED BY (new MySQL syntax)
-- GRANT ALL PRIVILEGES ON student_db.* TO 'root'@'localhost';

-- FLUSH PRIVILEGES;

USE student_db;
CREATE TABLE test_table (id INT);
DROP TABLE test_table;

USE student_db;

SELECT * FROM student_exam_scores LIMIT 10 ; 

SELECT AVG(exam_score) AS avg_exam_score FROM student_exam_scores;

SELECT MAX(exam_score) AS highest_exam_score, MIN(exam_score) AS lowest_exam_score
FROM student_exam_scores;

SELECT student_id, exam_score FROM student_exam_scores;

SELECT * FROM student_exam_scores
WHERE hours_studied > 3;

SELECT * FROM student_exam_scores
WHERE sleep_hours < 8;

SELECT * FROM student_exam_scores
WHERE attendance_percent > 90;

SELECT * FROM student_exam_scores
ORDER BY exam_score ASC;

SELECT * FROM student_exam_scores
ORDER BY exam_score DESC
LIMIT 20;

SELECT * FROM student_exam_scores
WHERE previous_scores < 50 OR exam_score > 70;

SELECT * FROM student_exam_scores
WHERE hours_studied BETWEEN 2 AND 9;

SELECT COUNT(*) AS total_students FROM student_exam_scores;

SELECT AVG(hours_studied) AS avg_hours_high_exam_scores
FROM student_exam_scores
WHERE exam_score > 65;

SELECT SUM(hours_studied) AS total_study_hours FROM student_exam_scores;

SELECT COUNT(*) AS low_attendance_students
FROM student_exam_scores
WHERE attendance_percent < 75;

SELECT AVG(previous_scores) AS avg_previous,
       AVG(exam_score) AS avg_exam
FROM student_exam_scores;

SELECT student_id, (exam_score - previous_scores) AS score_difference
FROM student_exam_scores;

SELECT * FROM student_exam_scores
WHERE (exam_score - previous_scores) >= 20;

SELECT
  CASE
    WHEN attendance_percent BETWEEN 0 AND 50 THEN '0-50%'
    WHEN attendance_percent BETWEEN 51 AND 80 THEN '51-80%'
    ELSE '81-100%'
  END AS attendance_range,
  AVG(exam_score) AS avg_exam_score
FROM student_exam_scores
GROUP BY attendance_range;

SELECT * FROM student_exam_scores
WHERE hours_studied > 6 AND sleep_hours > 7;

SELECT * FROM student_exam_scores
WHERE attendance_percent > (SELECT AVG(attendance_percent) FROM student_exam_scores);

SELECT * FROM student_exam_scores
WHERE exam_score < 50;

SELECT * FROM student_exam_scores
WHERE attendance_percent > 70 AND hours_studied > 8;

SELECT * FROM student_exam_scores
WHERE ABS(exam_score - previous_scores) <= 8;

SELECT student_id, ROUND(exam_score, 0) AS rounded_score
FROM student_exam_scores;

SELECT
  SUM((hours_studied - (SELECT AVG(hours_studied) FROM student_exam_scores)) *
      (exam_score - (SELECT AVG(exam_score) FROM student_exam_scores))) /
  (COUNT(*) - 1) AS covariance
FROM student_exam_scores;

SELECT student_id, exam_score,
  CASE
    WHEN exam_score >= 85 THEN 'Excellent'
    WHEN exam_score BETWEEN 70 AND 84 THEN 'Good'
    WHEN exam_score BETWEEN 50 AND 69 THEN 'Average'
    ELSE 'Poor'
  END AS performance_category
FROM student_exam_scores;

CREATE OR REPLACE VIEW student_performance_summary AS
SELECT
  student_id,
  hours_studied,
  sleep_hours,
  attendance_percent,
  previous_scores,
  exam_score,
  (exam_score - previous_scores) AS improvement
FROM student_exam_scores;


SELECT * FROM student_performance_summary LIMIT 10;