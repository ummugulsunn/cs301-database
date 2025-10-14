-- ============================================
-- CS301 Database Management Systems
-- 04: Advanced Query Examples (Joins, Subqueries, Window Functions)
-- ============================================

-- Make sure you're using the university database
USE university;

-- ============================================
-- JOIN Operations
-- ============================================

-- 1. INNER JOIN - Students with their enrollments and course details
SELECT 
    s.first_name,
    s.last_name,
    c.course_code,
    c.course_name,
    e.grade,
    e.semester,
    e.year
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id
WHERE e.status = 'Completed'
ORDER BY s.last_name, s.first_name, e.year DESC, e.semester;

-- 2. LEFT JOIN - All students and their enrollments (including students with no enrollments)
SELECT 
    s.first_name,
    s.last_name,
    s.gpa,
    COUNT(e.enrollment_id) AS total_enrollments
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name, s.gpa
ORDER BY total_enrollments DESC;

-- 3. RIGHT JOIN - All courses and their enrollments (including courses with no enrollments)
SELECT 
    c.course_code,
    c.course_name,
    COUNT(e.enrollment_id) AS enrollment_count
FROM enrollments e
RIGHT JOIN courses c ON e.course_id = c.course_id
GROUP BY c.course_id, c.course_code, c.course_name
ORDER BY enrollment_count DESC;

-- 4. Multiple JOINs - Complete enrollment information
SELECT 
    s.first_name AS student_first_name,
    s.last_name AS student_last_name,
    c.course_code,
    c.course_name,
    i.first_name AS instructor_first_name,
    i.last_name AS instructor_last_name,
    d.department_name,
    e.grade,
    e.semester,
    e.year
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
JOIN instructors i ON e.instructor_id = i.instructor_id
JOIN departments d ON c.department_id = d.department_id
WHERE e.status = 'Completed'
ORDER BY d.department_name, c.course_code;

-- 5. Self JOIN - Students who share the same last name
SELECT 
    s1.first_name AS student1_first_name,
    s1.last_name AS shared_last_name,
    s2.first_name AS student2_first_name
FROM students s1
JOIN students s2 ON s1.last_name = s2.last_name AND s1.student_id < s2.student_id
ORDER BY s1.last_name;

-- ============================================
-- Subqueries
-- ============================================

-- 6. Subquery in WHERE clause - Students with above average GPA
SELECT first_name, last_name, gpa
FROM students
WHERE gpa > (SELECT AVG(gpa) FROM students)
ORDER BY gpa DESC;

-- 7. Subquery with IN - Students enrolled in CS courses
SELECT first_name, last_name, email
FROM students
WHERE student_id IN (
    SELECT DISTINCT e.student_id
    FROM enrollments e
    JOIN courses c ON e.course_id = c.course_id
    WHERE c.course_code LIKE 'CS%'
);

-- 8. Subquery with EXISTS - Students who have completed at least one course
SELECT s.first_name, s.last_name, s.gpa
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.student_id
    AND e.status = 'Completed'
);

-- 9. Subquery with NOT EXISTS - Students who haven't completed any courses
SELECT s.first_name, s.last_name, s.email
FROM students s
WHERE NOT EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.student_id
    AND e.status = 'Completed'
);

-- 10. Correlated subquery - Students with highest GPA in their enrollment year
SELECT 
    s.first_name,
    s.last_name,
    s.gpa,
    YEAR(s.enrollment_date) AS enrollment_year
FROM students s
WHERE s.gpa = (
    SELECT MAX(s2.gpa)
    FROM students s2
    WHERE YEAR(s2.enrollment_date) = YEAR(s.enrollment_date)
);

-- 11. Subquery in SELECT clause - Student with course count
SELECT 
    s.first_name,
    s.last_name,
    s.gpa,
    (SELECT COUNT(*) 
     FROM enrollments e 
     WHERE e.student_id = s.student_id) AS total_enrollments
FROM students s
ORDER BY total_enrollments DESC;

-- ============================================
-- Window Functions (Advanced)
-- ============================================

-- 12. ROW_NUMBER() - Rank students by GPA
SELECT 
    first_name,
    last_name,
    gpa,
    ROW_NUMBER() OVER (ORDER BY gpa DESC) AS rank_number
FROM students
WHERE status = 'Active';

-- 13. RANK() and DENSE_RANK() - Handle ties differently
SELECT 
    first_name,
    last_name,
    gpa,
    RANK() OVER (ORDER BY gpa DESC) AS rank_with_gaps,
    DENSE_RANK() OVER (ORDER BY gpa DESC) AS dense_rank
FROM students
WHERE status = 'Active';

-- 14. PARTITION BY - Rank students within each enrollment year
SELECT 
    first_name,
    last_name,
    gpa,
    YEAR(enrollment_date) AS enrollment_year,
    RANK() OVER (PARTITION BY YEAR(enrollment_date) ORDER BY gpa DESC) AS year_rank
FROM students
WHERE status = 'Active'
ORDER BY enrollment_year, year_rank;

-- 15. Running totals with SUM() OVER
SELECT 
    c.course_code,
    c.course_name,
    c.credit_hours,
    SUM(c.credit_hours) OVER (ORDER BY c.course_code) AS running_credit_total
FROM courses c
ORDER BY c.course_code;

-- 16. Moving average
SELECT 
    s.first_name,
    s.last_name,
    s.gpa,
    AVG(s.gpa) OVER (ORDER BY s.student_id ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_gpa
FROM students s
ORDER BY s.student_id;

-- ============================================
-- Common Table Expressions (CTEs)
-- ============================================

-- 17. Simple CTE - High performing students
WITH high_performers AS (
    SELECT student_id, first_name, last_name, gpa
    FROM students
    WHERE gpa >= 3.7
)
SELECT 
    hp.first_name,
    hp.last_name,
    hp.gpa,
    COUNT(e.enrollment_id) AS completed_courses
FROM high_performers hp
LEFT JOIN enrollments e ON hp.student_id = e.student_id AND e.status = 'Completed'
GROUP BY hp.student_id, hp.first_name, hp.last_name, hp.gpa
ORDER BY hp.gpa DESC;

-- 18. Multiple CTEs - Department statistics
WITH dept_courses AS (
    SELECT 
        d.department_id,
        d.department_name,
        COUNT(c.course_id) AS course_count
    FROM departments d
    LEFT JOIN courses c ON d.department_id = c.department_id
    GROUP BY d.department_id, d.department_name
),
dept_instructors AS (
    SELECT 
        d.department_id,
        COUNT(i.instructor_id) AS instructor_count
    FROM departments d
    LEFT JOIN instructors i ON d.department_id = i.department_id
    GROUP BY d.department_id
)
SELECT 
    dc.department_name,
    dc.course_count,
    di.instructor_count,
    ROUND(dc.course_count / NULLIF(di.instructor_count, 0), 2) AS courses_per_instructor
FROM dept_courses dc
JOIN dept_instructors di ON dc.department_id = di.department_id
ORDER BY courses_per_instructor DESC;

-- 19. Recursive CTE - Course prerequisites chain (if we had a prerequisites table)
-- This is a conceptual example - our current schema doesn't support recursive prerequisites
/*
WITH RECURSIVE prerequisite_chain AS (
    -- Base case: courses with no prerequisites
    SELECT course_id, course_code, course_name, 0 as level
    FROM courses
    WHERE prerequisites IS NULL
    
    UNION ALL
    
    -- Recursive case: courses that depend on others
    SELECT c.course_id, c.course_code, c.course_name, pc.level + 1
    FROM courses c
    JOIN prerequisite_chain pc ON c.prerequisites = pc.course_code
)
SELECT * FROM prerequisite_chain ORDER BY level, course_code;
*/

-- ============================================
-- Advanced Aggregation
-- ============================================

-- 20. ROLLUP - Hierarchical totals
SELECT 
    d.department_name,
    c.course_code,
    COUNT(e.enrollment_id) AS enrollments
FROM departments d
JOIN courses c ON d.department_id = c.department_id
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY d.department_name, c.course_code WITH ROLLUP
ORDER BY d.department_name, c.course_code;

-- 21. CUBE - All possible combinations of grouping
-- Note: MySQL doesn't support CUBE, but here's the concept
-- This would show totals for all combinations of department and semester
/*
SELECT 
    d.department_name,
    e.semester,
    COUNT(e.enrollment_id) AS enrollments
FROM departments d
JOIN courses c ON d.department_id = c.department_id
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY d.department_name, e.semester WITH CUBE;
*/

-- 22. GROUPING SETS - Specific grouping combinations
-- MySQL alternative using UNION ALL
SELECT department_name, NULL as semester, COUNT(*) as enrollments, 'By Department' as grouping_type
FROM departments d
JOIN courses c ON d.department_id = c.department_id
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY d.department_name

UNION ALL

SELECT NULL, semester, COUNT(*) as enrollments, 'By Semester' as grouping_type
FROM enrollments e
GROUP BY e.semester

UNION ALL

SELECT NULL, NULL, COUNT(*) as enrollments, 'Total' as grouping_type
FROM enrollments e

ORDER BY grouping_type, department_name, semester;

-- ============================================
-- Complex Query Examples
-- ============================================

-- 23. Student performance analysis across semesters
SELECT 
    s.first_name,
    s.last_name,
    e.semester,
    e.year,
    COUNT(e.enrollment_id) AS courses_taken,
    ROUND(AVG(e.grade_points), 2) AS semester_gpa,
    ROUND(AVG(AVG(e.grade_points)) OVER (
        PARTITION BY s.student_id 
        ORDER BY e.year, e.semester 
        ROWS UNBOUNDED PRECEDING
    ), 2) AS cumulative_gpa
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
WHERE e.status = 'Completed' AND e.grade_points IS NOT NULL
GROUP BY s.student_id, s.first_name, s.last_name, e.semester, e.year
ORDER BY s.last_name, s.first_name, e.year, e.semester;

-- 24. Course difficulty analysis (based on grade distribution)
SELECT 
    c.course_code,
    c.course_name,
    COUNT(e.enrollment_id) AS total_students,
    ROUND(AVG(e.grade_points), 2) AS avg_grade_points,
    COUNT(CASE WHEN e.grade_points >= 3.7 THEN 1 END) AS a_students,
    COUNT(CASE WHEN e.grade_points BETWEEN 3.3 AND 3.69 THEN 1 END) AS b_students,
    COUNT(CASE WHEN e.grade_points BETWEEN 3.0 AND 3.29 THEN 1 END) AS c_students,
    COUNT(CASE WHEN e.grade_points < 3.0 THEN 1 END) AS below_c_students,
    ROUND(
        COUNT(CASE WHEN e.grade_points < 3.0 THEN 1 END) * 100.0 / COUNT(e.enrollment_id), 
        1
    ) AS failure_rate_percent
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
WHERE e.status = 'Completed' AND e.grade_points IS NOT NULL
GROUP BY c.course_id, c.course_code, c.course_name
HAVING COUNT(e.enrollment_id) >= 3  -- Only courses with at least 3 students
ORDER BY failure_rate_percent DESC;

-- 25. Instructor effectiveness comparison
SELECT 
    i.first_name,
    i.last_name,
    i.title,
    COUNT(DISTINCT e.course_id) AS courses_taught,
    COUNT(e.enrollment_id) AS total_students_taught,
    ROUND(AVG(e.grade_points), 2) AS avg_grade_given,
    COUNT(CASE WHEN e.grade_points >= 3.7 THEN 1 END) AS a_grades_given,
    ROUND(
        COUNT(CASE WHEN e.grade_points >= 3.7 THEN 1 END) * 100.0 / COUNT(e.enrollment_id),
        1
    ) AS a_grade_percentage
FROM instructors i
JOIN enrollments e ON i.instructor_id = e.instructor_id
WHERE e.status = 'Completed' AND e.grade_points IS NOT NULL
GROUP BY i.instructor_id, i.first_name, i.last_name, i.title
HAVING COUNT(e.enrollment_id) >= 5  -- Only instructors with at least 5 students
ORDER BY avg_grade_given DESC;

-- 26. Department performance comparison
SELECT 
    d.department_name,
    COUNT(DISTINCT s.student_id) AS students_in_dept_courses,
    COUNT(e.enrollment_id) AS total_enrollments,
    ROUND(AVG(e.grade_points), 2) AS dept_avg_grade,
    COUNT(DISTINCT c.course_id) AS courses_offered,
    COUNT(DISTINCT i.instructor_id) AS instructors_count,
    ROUND(
        COUNT(e.enrollment_id) * 1.0 / COUNT(DISTINCT c.course_id), 
        1
    ) AS avg_enrollment_per_course
FROM departments d
JOIN courses c ON d.department_id = c.department_id
JOIN enrollments e ON c.course_id = e.course_id
JOIN students s ON e.student_id = s.student_id
JOIN instructors i ON d.department_id = i.department_id
WHERE e.status = 'Completed'
GROUP BY d.department_id, d.department_name
ORDER BY dept_avg_grade DESC;

-- 27. Find students who need academic intervention
SELECT 
    s.first_name,
    s.last_name,
    s.gpa,
    COUNT(e.enrollment_id) AS total_courses,
    COUNT(CASE WHEN e.grade_points < 2.0 THEN 1 END) AS failing_grades,
    COUNT(CASE WHEN e.status = 'Dropped' OR e.status = 'Withdrawn' THEN 1 END) AS dropped_courses,
    ROUND(
        COUNT(CASE WHEN e.grade_points < 2.0 THEN 1 END) * 100.0 / 
        NULLIF(COUNT(CASE WHEN e.status = 'Completed' THEN 1 END), 0),
        1
    ) AS failure_rate_percent
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE s.status = 'Active'
GROUP BY s.student_id, s.first_name, s.last_name, s.gpa
HAVING s.gpa < 3.0 OR failure_rate_percent > 20 OR dropped_courses > 1
ORDER BY s.gpa ASC, failure_rate_percent DESC;

-- ============================================
-- Data Mining Queries
-- ============================================

-- 28. Course recommendation based on student performance
-- Find courses that high-performing students in CS tend to take
SELECT 
    c.course_code,
    c.course_name,
    d.department_name,
    COUNT(*) AS high_performer_enrollments,
    ROUND(AVG(e.grade_points), 2) AS avg_grade_by_high_performers
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
JOIN departments d ON c.department_id = d.department_id
JOIN students s ON e.student_id = s.student_id
WHERE s.student_id IN (
    -- Students who performed well in CS courses
    SELECT DISTINCT e2.student_id
    FROM enrollments e2
    JOIN courses c2 ON e2.course_id = c2.course_id
    WHERE c2.course_code LIKE 'CS%' 
    AND e2.grade_points >= 3.7
    AND e2.status = 'Completed'
)
AND e.status = 'Completed'
AND c.course_code NOT LIKE 'CS%'  -- Recommend non-CS courses
GROUP BY c.course_id, c.course_code, c.course_name, d.department_name
HAVING COUNT(*) >= 2  -- At least 2 high performers took this course
ORDER BY high_performer_enrollments DESC, avg_grade_by_high_performers DESC;

-- 29. Identify course scheduling conflicts
SELECT 
    cs1.course_id AS course1_id,
    c1.course_code AS course1_code,
    cs2.course_id AS course2_id,
    c2.course_code AS course2_code,
    cs1.days_of_week,
    cs1.start_time,
    cs1.end_time,
    cs1.semester,
    cs1.year
FROM course_schedules cs1
JOIN course_schedules cs2 ON 
    cs1.schedule_id < cs2.schedule_id
    AND cs1.semester = cs2.semester
    AND cs1.year = cs2.year
    AND cs1.days_of_week = cs2.days_of_week
    AND (
        (cs1.start_time <= cs2.start_time AND cs1.end_time > cs2.start_time)
        OR
        (cs2.start_time <= cs1.start_time AND cs2.end_time > cs1.start_time)
    )
JOIN courses c1 ON cs1.course_id = c1.course_id
JOIN courses c2 ON cs2.course_id = c2.course_id
ORDER BY cs1.semester, cs1.year, cs1.days_of_week, cs1.start_time;

-- 30. Student retention analysis
SELECT 
    YEAR(s.enrollment_date) AS enrollment_year,
    COUNT(*) AS total_students,
    COUNT(CASE WHEN s.status = 'Active' THEN 1 END) AS still_active,
    COUNT(CASE WHEN s.status = 'Graduated' THEN 1 END) AS graduated,
    COUNT(CASE WHEN s.status = 'Inactive' THEN 1 END) AS inactive,
    ROUND(
        COUNT(CASE WHEN s.status IN ('Active', 'Graduated') THEN 1 END) * 100.0 / COUNT(*),
        1
    ) AS retention_rate_percent
FROM students s
GROUP BY YEAR(s.enrollment_date)
ORDER BY enrollment_year DESC;

SELECT 'Advanced queries completed successfully!' AS Status;


