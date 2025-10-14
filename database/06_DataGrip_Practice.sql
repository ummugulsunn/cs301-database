-- ============================================
-- CS301 Database Management Systems
-- 06: DataGrip Practice Exercises
-- ============================================

-- Make sure you're using the university database
USE university;

-- ============================================
-- DATAGRIP FEATURES DEMONSTRATION
-- ============================================

-- DataGrip Tip: Use Ctrl+Enter to execute the current statement
-- DataGrip Tip: Use Ctrl+Shift+Enter to execute all statements
-- DataGrip Tip: Use Ctrl+/ to comment/uncomment lines

-- ============================================
-- PRACTICE EXERCISES - BASIC LEVEL
-- ============================================

-- Exercise 1: Basic Data Retrieval
-- TODO: Write a query to find all students with GPA above 3.5
-- Your code here:


-- Solution:
-- SELECT * FROM students WHERE gpa > 3.5 ORDER BY gpa DESC;

-- Exercise 2: String Functions
-- TODO: Create a query that shows student full names in uppercase
-- Your code here:


-- Solution:
-- SELECT 
--     UPPER(CONCAT(first_name, ' ', last_name)) AS full_name_upper,
--     email
-- FROM students;

-- Exercise 3: Date Functions
-- TODO: Find all students who enrolled in the last 3 years
-- Your code here:


-- Solution:
-- SELECT first_name, last_name, enrollment_date
-- FROM students
-- WHERE enrollment_date >= DATE_SUB(CURRENT_DATE, INTERVAL 3 YEAR);

-- Exercise 4: Aggregation
-- TODO: Count how many students are in each status
-- Your code here:


-- Solution:
-- SELECT status, COUNT(*) as student_count
-- FROM students
-- GROUP BY status;

-- Exercise 5: Pattern Matching
-- TODO: Find all courses that contain the word "Introduction"
-- Your code here:


-- Solution:
-- SELECT course_code, course_name FROM courses 
-- WHERE course_name LIKE '%Introduction%';

-- ============================================
-- PRACTICE EXERCISES - INTERMEDIATE LEVEL
-- ============================================

-- Exercise 6: JOIN Practice
-- TODO: Show all enrollments with student names and course codes
-- Your code here:


-- Solution:
-- SELECT 
--     s.first_name,
--     s.last_name,
--     c.course_code,
--     c.course_name,
--     e.grade,
--     e.semester,
--     e.year
-- FROM students s
-- JOIN enrollments e ON s.student_id = e.student_id
-- JOIN courses c ON e.course_id = c.course_id;

-- Exercise 7: Subquery Practice
-- TODO: Find students who have never enrolled in any course
-- Your code here:


-- Solution:
-- SELECT first_name, last_name, email
-- FROM students
-- WHERE student_id NOT IN (
--     SELECT DISTINCT student_id FROM enrollments
-- );

-- Exercise 8: Group By with Having
-- TODO: Find courses that have more than 2 enrollments
-- Your code here:


-- Solution:
-- SELECT 
--     c.course_code,
--     c.course_name,
--     COUNT(e.enrollment_id) as enrollment_count
-- FROM courses c
-- JOIN enrollments e ON c.course_id = e.course_id
-- GROUP BY c.course_id, c.course_code, c.course_name
-- HAVING COUNT(e.enrollment_id) > 2;

-- Exercise 9: Complex WHERE clause
-- TODO: Find active students with GPA between 3.0 and 3.7 who enrolled after 2020
-- Your code here:


-- Solution:
-- SELECT first_name, last_name, gpa, enrollment_date
-- FROM students
-- WHERE status = 'Active'
-- AND gpa BETWEEN 3.0 AND 3.7
-- AND enrollment_date > '2020-12-31';

-- Exercise 10: UPDATE Practice
-- TODO: Update phone number for student with email 'john.doe@student.edu'
-- Your code here:


-- Solution:
-- UPDATE students 
-- SET phone = '555-NEW-PHONE'
-- WHERE email = 'john.doe@student.edu';

-- ============================================
-- PRACTICE EXERCISES - ADVANCED LEVEL
-- ============================================

-- Exercise 11: Window Functions
-- TODO: Rank students by GPA within each enrollment year
-- Your code here:


-- Solution:
-- SELECT 
--     first_name,
--     last_name,
--     gpa,
--     YEAR(enrollment_date) as enrollment_year,
--     RANK() OVER (PARTITION BY YEAR(enrollment_date) ORDER BY gpa DESC) as gpa_rank
-- FROM students
-- WHERE status = 'Active';

-- Exercise 12: CTE Practice
-- TODO: Use CTE to find the average GPA of students in each department's courses
-- Your code here:


-- Solution:
-- WITH dept_student_gpa AS (
--     SELECT 
--         d.department_name,
--         s.gpa
--     FROM departments d
--     JOIN courses c ON d.department_id = c.department_id
--     JOIN enrollments e ON c.course_id = e.course_id
--     JOIN students s ON e.student_id = s.student_id
--     WHERE e.status = 'Completed'
-- )
-- SELECT 
--     department_name,
--     ROUND(AVG(gpa), 2) as avg_student_gpa,
--     COUNT(*) as student_count
-- FROM dept_student_gpa
-- GROUP BY department_name
-- ORDER BY avg_student_gpa DESC;

-- Exercise 13: Complex JOIN
-- TODO: Show instructor details with their department and number of students taught
-- Your code here:


-- Solution:
-- SELECT 
--     i.first_name,
--     i.last_name,
--     i.title,
--     d.department_name,
--     COUNT(DISTINCT e.student_id) as students_taught,
--     COUNT(DISTINCT c.course_id) as courses_taught
-- FROM instructors i
-- JOIN departments d ON i.department_id = d.department_id
-- LEFT JOIN enrollments e ON i.instructor_id = e.instructor_id
-- LEFT JOIN courses c ON e.course_id = c.course_id
-- GROUP BY i.instructor_id, i.first_name, i.last_name, i.title, d.department_name
-- ORDER BY students_taught DESC;

-- Exercise 14: Data Analysis
-- TODO: Create a semester-wise enrollment trend analysis
-- Your code here:


-- Solution:
-- SELECT 
--     year,
--     semester,
--     COUNT(*) as total_enrollments,
--     COUNT(DISTINCT student_id) as unique_students,
--     COUNT(DISTINCT course_id) as courses_offered,
--     ROUND(AVG(CASE WHEN grade_points IS NOT NULL THEN grade_points END), 2) as avg_grade_points
-- FROM enrollments
-- GROUP BY year, semester
-- ORDER BY year DESC, 
--          CASE semester 
--              WHEN 'Spring' THEN 1 
--              WHEN 'Summer' THEN 2 
--              WHEN 'Fall' THEN 3 
--          END;

-- Exercise 15: Performance Analysis
-- TODO: Find courses with the highest and lowest average grades
-- Your code here:


-- Solution:
-- SELECT 
--     c.course_code,
--     c.course_name,
--     COUNT(e.enrollment_id) as total_enrollments,
--     ROUND(AVG(e.grade_points), 2) as avg_grade_points,
--     MIN(e.grade_points) as min_grade_points,
--     MAX(e.grade_points) as max_grade_points
-- FROM courses c
-- JOIN enrollments e ON c.course_id = e.course_id
-- WHERE e.status = 'Completed' AND e.grade_points IS NOT NULL
-- GROUP BY c.course_id, c.course_code, c.course_name
-- HAVING COUNT(e.enrollment_id) >= 3
-- ORDER BY avg_grade_points DESC;

-- ============================================
-- DATAGRIP SPECIFIC EXERCISES
-- ============================================

-- Exercise 16: Using DataGrip's Database Explorer
-- TODO: Practice navigating the database structure
-- 1. Open the Database Explorer (usually on the left side)
-- 2. Expand the university database
-- 3. Browse through tables, columns, indexes, and foreign keys
-- 4. Right-click on a table and select "Edit Data" to see the data editor

-- Exercise 17: Using DataGrip's Query History
-- TODO: Practice with query history
-- 1. Run several different queries
-- 2. Use Ctrl+Shift+H to open query history
-- 3. Re-run previous queries from history

-- Exercise 18: DataGrip Auto-completion
-- TODO: Practice with auto-completion
-- Start typing these queries and use Ctrl+Space for suggestions:

-- SELECT * FROM st   -- Should suggest 'students'
-- SELECT first_name, la   -- Should suggest 'last_name'
-- SELECT * FROM students WHERE   -- Should suggest column names

-- Exercise 19: DataGrip Code Formatting
-- TODO: Practice code formatting
-- Write a messy query and use Ctrl+Alt+L to format it:

select first_name,last_name,gpa from students where gpa>3.5 and status='Active' order by gpa desc;

-- After formatting, it should look like:
-- SELECT first_name,
--        last_name,
--        gpa
-- FROM students
-- WHERE gpa > 3.5
--   AND status = 'Active'
-- ORDER BY gpa DESC;

-- Exercise 20: Using DataGrip's Explain Plan
-- TODO: Practice with query execution plans
-- 1. Write a complex query
-- 2. Use Ctrl+Shift+Alt+X to see the execution plan
-- 3. Analyze which indexes are being used

EXPLAIN SELECT 
    s.first_name,
    s.last_name,
    c.course_name,
    e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE s.gpa > 3.5;

-- ============================================
-- CHALLENGE EXERCISES
-- ============================================

-- Challenge 1: Student Academic Standing Report
-- TODO: Create a comprehensive academic standing report
-- Requirements:
-- - Show student name, current GPA, total credits attempted
-- - Calculate academic standing (Excellent: 3.7+, Good: 3.3-3.69, etc.)
-- - Include total number of A's, B's, C's, etc.
-- - Sort by GPA descending

-- Your solution here:


-- Challenge 2: Department Performance Dashboard
-- TODO: Create a department performance summary
-- Requirements:
-- - Department name and total courses offered
-- - Average GPA of students in department courses
-- - Number of instructors in the department
-- - Most popular course in the department
-- - Department with highest student satisfaction (highest avg grade)

-- Your solution here:


-- Challenge 3: Course Prerequisite Analysis
-- TODO: Analyze course prerequisites and student success
-- Requirements:
-- - Show courses and their prerequisites
-- - Calculate success rate (% of students getting C or better)
-- - Compare success rates between students who took prerequisites vs. those who didn't
-- - Identify courses that might need prerequisite adjustments

-- Your solution here:


-- Challenge 4: Instructor Workload Balancing
-- TODO: Create an instructor workload analysis
-- Requirements:
-- - Show each instructor's teaching load (courses and students)
-- - Calculate average class size per instructor
-- - Identify over-loaded and under-loaded instructors
-- - Suggest workload redistribution

-- Your solution here:


-- Challenge 5: Student Retention Prediction
-- TODO: Identify students at risk of dropping out
-- Requirements:
-- - Calculate risk factors: low GPA, course drops, irregular enrollment
-- - Create a risk score for each student
-- - Identify students needing academic intervention
-- - Suggest intervention strategies based on patterns

-- Your solution here:


-- ============================================
-- DATAGRIP TIPS AND TRICKS
-- ============================================

/*
DataGrip Keyboard Shortcuts (Essential):
- Ctrl+Enter: Execute current statement
- Ctrl+Shift+Enter: Execute all statements
- Ctrl+/: Comment/uncomment line
- Ctrl+Shift+/: Block comment
- Ctrl+D: Duplicate line
- Ctrl+Y: Delete line
- Ctrl+Space: Auto-completion
- Ctrl+P: Parameter info
- Ctrl+Q: Quick documentation
- F4: Edit table data
- Ctrl+B: Navigate to declaration
- Ctrl+Alt+L: Format code
- Ctrl+Shift+H: Query history
- Ctrl+Shift+Alt+X: Explain plan

DataGrip Features to Explore:
1. Database Explorer - Browse schema visually
2. Data Editor - Edit table data directly
3. Query Console - Multiple console tabs
4. Schema Comparison - Compare database structures
5. SQL Formatter - Auto-format your code
6. Version Control - Git integration
7. Export/Import - Various formats
8. Database Diagrams - Visual ER diagrams
9. SQL Log - See all executed statements
10. Performance Monitoring - Query performance

DataGrip Best Practices:
1. Use separate consoles for different tasks
2. Save important queries as .sql files
3. Use scratch files for temporary queries
4. Set up proper database connections
5. Use the data sources panel effectively
6. Take advantage of auto-completion
7. Use the formatter to keep code clean
8. Leverage the database explorer
9. Use version control for your SQL scripts
10. Practice keyboard shortcuts for efficiency
*/

-- ============================================
-- FINAL VERIFICATION
-- ============================================

-- Run this to verify your database is working correctly
SELECT 
    'Database Status' AS info,
    'All tables accessible' AS status
FROM dual

UNION ALL

SELECT 
    'Total Students',
    CAST(COUNT(*) AS CHAR)
FROM students

UNION ALL

SELECT 
    'Total Courses',
    CAST(COUNT(*) AS CHAR)
FROM courses

UNION ALL

SELECT 
    'Total Enrollments',
    CAST(COUNT(*) AS CHAR)
FROM enrollments;

SELECT 'DataGrip practice exercises loaded successfully!' AS Status;

-- ============================================
-- HOMEWORK ASSIGNMENTS
-- ============================================

/*
Week 1 Homework:
1. Complete exercises 1-5 (Basic Level)
2. Practice using DataGrip's auto-completion feature
3. Create 3 original queries using different WHERE conditions

Week 2 Homework:
1. Complete exercises 6-10 (Intermediate Level)
2. Practice JOINs with all table combinations
3. Write 5 different subqueries

Week 3 Homework:
1. Complete exercises 11-15 (Advanced Level)
2. Practice window functions and CTEs
3. Create a mini data analysis report

Week 4 Homework:
1. Complete at least 2 challenge exercises
2. Create your own complex query scenarios
3. Practice DataGrip shortcuts and features

Final Project Ideas:
1. Student Information System Dashboard
2. Course Enrollment Optimization System
3. Academic Performance Analysis Tool
4. Instructor Workload Management System
5. Student Success Prediction Model
*/


