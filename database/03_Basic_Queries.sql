-- ============================================
-- CS301 Database Management Systems
-- 03: Basic Query Examples (DQL - Data Query Language)
-- ============================================

-- Make sure you're using the university database
USE university;

-- ============================================
-- BASIC SELECT Statements
-- ============================================

-- 1. Select all columns from a table
SELECT * FROM students;

-- 2. Select specific columns
SELECT first_name, last_name, email FROM students;

-- 3. Select with column aliases
SELECT 
    first_name AS "First Name",
    last_name AS "Last Name",
    email AS "Email Address",
    gpa AS "Grade Point Average"
FROM students;

-- 4. Select with calculated columns
SELECT 
    first_name,
    last_name,
    gpa,
    CASE 
        WHEN gpa >= 3.7 THEN 'Excellent'
        WHEN gpa >= 3.3 THEN 'Good'
        WHEN gpa >= 3.0 THEN 'Satisfactory'
        WHEN gpa >= 2.0 THEN 'Needs Improvement'
        ELSE 'Poor'
    END AS performance_level
FROM students;

-- ============================================
-- WHERE Clause Examples
-- ============================================

-- 5. Simple WHERE conditions
SELECT * FROM students WHERE gpa > 3.5;

SELECT * FROM students WHERE status = 'Active';

SELECT * FROM students WHERE first_name = 'John';

-- 6. Multiple conditions with AND/OR
SELECT * FROM students 
WHERE gpa > 3.0 AND status = 'Active';

SELECT * FROM students 
WHERE first_name = 'John' OR first_name = 'Jane';

SELECT * FROM students 
WHERE gpa > 3.5 AND (status = 'Active' OR status = 'Graduated');

-- 7. BETWEEN operator
SELECT * FROM students 
WHERE gpa BETWEEN 3.0 AND 3.8;

SELECT * FROM students 
WHERE birth_date BETWEEN '2000-01-01' AND '2002-12-31';

-- 8. IN operator
SELECT * FROM students 
WHERE first_name IN ('John', 'Jane', 'Alice', 'Bob');

SELECT * FROM courses 
WHERE credit_hours IN (3, 4);

-- 9. LIKE operator for pattern matching
SELECT * FROM students 
WHERE email LIKE '%@student.edu';

SELECT * FROM students 
WHERE first_name LIKE 'J%';

SELECT * FROM students 
WHERE last_name LIKE '%son';

SELECT * FROM courses 
WHERE course_name LIKE '%Introduction%';

-- 10. NULL checks
SELECT * FROM enrollments 
WHERE grade IS NULL;

SELECT * FROM enrollments 
WHERE grade IS NOT NULL;

-- ============================================
-- ORDER BY Examples
-- ============================================

-- 11. Order by single column
SELECT * FROM students ORDER BY last_name;

SELECT * FROM students ORDER BY gpa DESC;

-- 12. Order by multiple columns
SELECT first_name, last_name, gpa 
FROM students 
ORDER BY gpa DESC, last_name ASC;

-- 13. Order with LIMIT
SELECT first_name, last_name, gpa 
FROM students 
ORDER BY gpa DESC 
LIMIT 5;

-- 14. Order with OFFSET (pagination)
SELECT first_name, last_name, gpa 
FROM students 
ORDER BY student_id 
LIMIT 5 OFFSET 5; -- Skip first 5, get next 5

-- ============================================
-- DISTINCT Examples
-- ============================================

-- 15. Remove duplicates
SELECT DISTINCT status FROM students;

SELECT DISTINCT department_id FROM courses;

SELECT DISTINCT semester, year FROM enrollments;

-- 16. Count distinct values
SELECT COUNT(DISTINCT status) AS unique_statuses FROM students;

SELECT COUNT(DISTINCT department_id) AS departments_with_courses FROM courses;

-- ============================================
-- Aggregate Functions
-- ============================================

-- 17. COUNT
SELECT COUNT(*) AS total_students FROM students;

SELECT COUNT(*) AS active_students FROM students WHERE status = 'Active';

SELECT COUNT(grade) AS graded_enrollments FROM enrollments; -- Excludes NULLs

-- 18. SUM, AVG, MIN, MAX
SELECT 
    AVG(gpa) AS average_gpa,
    MIN(gpa) AS lowest_gpa,
    MAX(gpa) AS highest_gpa,
    COUNT(*) AS total_students
FROM students;

SELECT 
    SUM(credit_hours) AS total_credits,
    AVG(credit_hours) AS average_credits,
    MIN(credit_hours) AS min_credits,
    MAX(credit_hours) AS max_credits
FROM courses;

-- 19. Aggregate with conditions
SELECT AVG(gpa) AS active_student_avg_gpa 
FROM students 
WHERE status = 'Active';

SELECT COUNT(*) AS high_performers 
FROM students 
WHERE gpa > 3.7;

-- ============================================
-- GROUP BY Examples
-- ============================================

-- 20. Basic GROUP BY
SELECT status, COUNT(*) AS student_count
FROM students
GROUP BY status;

SELECT department_id, COUNT(*) AS course_count
FROM courses
GROUP BY department_id;

-- 21. GROUP BY with multiple columns
SELECT semester, year, COUNT(*) AS enrollment_count
FROM enrollments
GROUP BY semester, year
ORDER BY year DESC, semester;

-- 22. GROUP BY with aggregate functions
SELECT 
    status,
    COUNT(*) AS student_count,
    AVG(gpa) AS average_gpa,
    MIN(gpa) AS lowest_gpa,
    MAX(gpa) AS highest_gpa
FROM students
GROUP BY status;

-- ============================================
-- HAVING Clause Examples
-- ============================================

-- 23. HAVING with GROUP BY
SELECT status, COUNT(*) AS student_count
FROM students
GROUP BY status
HAVING COUNT(*) > 1;

SELECT department_id, COUNT(*) AS course_count
FROM courses
GROUP BY department_id
HAVING COUNT(*) >= 3;

-- 24. HAVING with aggregate conditions
SELECT 
    status,
    COUNT(*) AS student_count,
    AVG(gpa) AS average_gpa
FROM students
GROUP BY status
HAVING AVG(gpa) > 3.0;

-- ============================================
-- Date and Time Functions
-- ============================================

-- 25. Current date/time functions
SELECT 
    CURRENT_DATE() AS today,
    CURRENT_TIME() AS current_time,
    CURRENT_TIMESTAMP() AS now;

-- 26. Date calculations
SELECT 
    first_name,
    last_name,
    birth_date,
    TIMESTAMPDIFF(YEAR, birth_date, CURRENT_DATE()) AS age
FROM students;

SELECT 
    first_name,
    last_name,
    enrollment_date,
    DATEDIFF(CURRENT_DATE(), enrollment_date) AS days_enrolled
FROM students;

-- 27. Date formatting
SELECT 
    first_name,
    last_name,
    DATE_FORMAT(birth_date, '%M %d, %Y') AS formatted_birth_date,
    DATE_FORMAT(enrollment_date, '%W, %M %d, %Y') AS formatted_enrollment_date
FROM students;

-- ============================================
-- String Functions
-- ============================================

-- 28. String manipulation
SELECT 
    UPPER(first_name) AS first_name_upper,
    LOWER(last_name) AS last_name_lower,
    CONCAT(first_name, ' ', last_name) AS full_name,
    LENGTH(email) AS email_length,
    SUBSTRING(email, 1, LOCATE('@', email) - 1) AS username
FROM students;

-- 29. String functions in WHERE
SELECT * FROM students 
WHERE LENGTH(first_name) > 5;

SELECT * FROM students 
WHERE UPPER(first_name) = 'JOHN';

-- ============================================
-- Mathematical Functions
-- ============================================

-- 30. Math operations
SELECT 
    course_name,
    credit_hours,
    credit_hours * 15 AS estimated_contact_hours,
    ROUND(credit_hours * 1.5, 2) AS study_hours_per_week
FROM courses;

-- 31. Rounding and formatting numbers
SELECT 
    first_name,
    last_name,
    gpa,
    ROUND(gpa, 1) AS gpa_rounded,
    FORMAT(gpa, 2) AS gpa_formatted
FROM students;

-- ============================================
-- Conditional Logic (CASE)
-- ============================================

-- 32. Simple CASE statement
SELECT 
    first_name,
    last_name,
    gpa,
    CASE 
        WHEN gpa >= 3.7 THEN 'Dean\'s List'
        WHEN gpa >= 3.3 THEN 'Honor Roll'
        WHEN gpa >= 3.0 THEN 'Good Standing'
        WHEN gpa >= 2.0 THEN 'Academic Probation'
        ELSE 'Academic Suspension'
    END AS academic_status
FROM students;

-- 33. CASE in aggregate functions
SELECT 
    COUNT(CASE WHEN gpa >= 3.7 THEN 1 END) AS deans_list,
    COUNT(CASE WHEN gpa BETWEEN 3.3 AND 3.69 THEN 1 END) AS honor_roll,
    COUNT(CASE WHEN gpa BETWEEN 3.0 AND 3.29 THEN 1 END) AS good_standing,
    COUNT(CASE WHEN gpa < 3.0 THEN 1 END) AS needs_improvement
FROM students;

-- ============================================
-- Practical Query Examples
-- ============================================

-- 34. Find all courses with their department names
SELECT 
    c.course_code,
    c.course_name,
    c.credit_hours,
    d.department_name
FROM courses c
JOIN departments d ON c.department_id = d.department_id
ORDER BY d.department_name, c.course_code;

-- 35. Student enrollment summary
SELECT 
    s.first_name,
    s.last_name,
    s.gpa,
    COUNT(e.enrollment_id) AS total_enrollments,
    COUNT(CASE WHEN e.status = 'Completed' THEN 1 END) AS completed_courses,
    COUNT(CASE WHEN e.status = 'Enrolled' THEN 1 END) AS current_courses
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE s.status = 'Active'
GROUP BY s.student_id, s.first_name, s.last_name, s.gpa
ORDER BY s.gpa DESC;

-- 36. Course popularity analysis
SELECT 
    c.course_code,
    c.course_name,
    COUNT(e.enrollment_id) AS total_enrollments,
    ROUND(AVG(e.grade_points), 2) AS average_grade,
    COUNT(CASE WHEN e.grade IN ('A', 'A-') THEN 1 END) AS a_grades,
    COUNT(CASE WHEN e.grade IN ('B+', 'B', 'B-') THEN 1 END) AS b_grades,
    COUNT(CASE WHEN e.grade IN ('C+', 'C', 'C-') THEN 1 END) AS c_grades
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
WHERE e.status = 'Completed'
GROUP BY c.course_id, c.course_code, c.course_name
HAVING COUNT(e.enrollment_id) > 0
ORDER BY total_enrollments DESC;

-- 37. Instructor workload analysis
SELECT 
    i.first_name,
    i.last_name,
    i.title,
    d.department_name,
    COUNT(DISTINCT cs.schedule_id) AS courses_teaching,
    COUNT(e.enrollment_id) AS total_students,
    ROUND(AVG(e.grade_points), 2) AS avg_grade_given
FROM instructors i
JOIN departments d ON i.department_id = d.department_id
LEFT JOIN course_schedules cs ON i.instructor_id = cs.instructor_id
LEFT JOIN enrollments e ON i.instructor_id = e.instructor_id AND e.status = 'Completed'
GROUP BY i.instructor_id, i.first_name, i.last_name, i.title, d.department_name
ORDER BY total_students DESC;

-- ============================================
-- Data Quality Checks
-- ============================================

-- 38. Find students without enrollments
SELECT s.student_id, s.first_name, s.last_name, s.email
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

-- 39. Find courses without enrollments
SELECT c.course_id, c.course_code, c.course_name
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
WHERE e.course_id IS NULL;

-- 40. Check for duplicate emails
SELECT email, COUNT(*) as count
FROM students
GROUP BY email
HAVING COUNT(*) > 1;

SELECT 'Basic queries completed successfully!' AS Status;
