-- ============================================
-- CS301 Database Management Systems
-- 05: DML Operations (INSERT, UPDATE, DELETE)
-- ============================================

-- Make sure you're using the university database
USE university;

-- ============================================
-- INSERT Operations
-- ============================================

-- 1. Basic INSERT with all columns specified
INSERT INTO students (first_name, last_name, email, phone, birth_date, enrollment_date, gpa, status)
VALUES ('Alex', 'Rodriguez', 'alex.rodriguez@student.edu', '555-2020', '2003-01-15', '2025-01-20', 0.00, 'Active');

-- 2. INSERT with some columns (others will use defaults)
INSERT INTO students (first_name, last_name, email, birth_date)
VALUES ('Maria', 'Gonzalez', 'maria.gonzalez@student.edu', '2002-11-08');

-- 3. Multiple row INSERT
INSERT INTO students (first_name, last_name, email, birth_date, gpa, status) VALUES
('David', 'Kim', 'david.kim@student.edu', '2003-03-22', 0.00, 'Active'),
('Sarah', 'Ahmed', 'sarah.ahmed@student.edu', '2002-09-14', 0.00, 'Active'),
('Michael', 'O\'Connor', 'michael.oconnor@student.edu', '2003-05-30', 0.00, 'Active');

-- 4. INSERT with subquery - Copy graduated students to an archive table
-- First create the archive table
CREATE TABLE IF NOT EXISTS archived_students AS
SELECT * FROM students WHERE 1 = 0; -- Creates table structure with no data

-- Insert graduated students into archive
INSERT INTO archived_students
SELECT * FROM students WHERE status = 'Graduated';

-- 5. INSERT ... ON DUPLICATE KEY UPDATE (MySQL specific)
-- This will insert or update if the unique key already exists
INSERT INTO students (student_id, first_name, last_name, email, birth_date)
VALUES (1, 'John', 'Doe', 'john.doe.new@student.edu', '2002-05-15')
ON DUPLICATE KEY UPDATE 
    email = VALUES(email),
    updated_at = CURRENT_TIMESTAMP;

-- ============================================
-- UPDATE Operations
-- ============================================

-- 6. Basic UPDATE - Single record
UPDATE students 
SET phone = '555-9999'
WHERE student_id = 1;

-- 7. UPDATE multiple columns
UPDATE students 
SET 
    phone = '555-8888',
    updated_at = CURRENT_TIMESTAMP
WHERE email = 'jane.smith@student.edu';

-- 8. UPDATE with calculations
UPDATE students 
SET gpa = gpa + 0.1
WHERE gpa < 4.0 AND gpa > 0;

-- 9. UPDATE with CASE statement
UPDATE students
SET status = CASE
    WHEN gpa < 2.0 THEN 'Academic Probation'
    WHEN gpa >= 3.7 THEN 'Dean\'s List'
    ELSE status
END
WHERE status = 'Active';

-- Reset status for demonstration
UPDATE students SET status = 'Active' WHERE status IN ('Academic Probation', 'Dean\'s List');

-- 10. UPDATE with JOIN - Update student GPA based on completed enrollments
UPDATE students s
SET s.gpa = (
    SELECT ROUND(AVG(e.grade_points), 2)
    FROM enrollments e
    WHERE e.student_id = s.student_id 
    AND e.status = 'Completed'
    AND e.grade_points IS NOT NULL
)
WHERE s.student_id IN (
    SELECT DISTINCT e.student_id
    FROM enrollments e
    WHERE e.status = 'Completed'
    AND e.grade_points IS NOT NULL
);

-- 11. UPDATE with subquery - Increase salary for instructors teaching popular courses
UPDATE instructors
SET salary = salary * 1.05
WHERE instructor_id IN (
    SELECT e.instructor_id
    FROM enrollments e
    WHERE e.semester = 'Fall' AND e.year = 2024
    GROUP BY e.instructor_id
    HAVING COUNT(e.enrollment_id) > 5
);

-- 12. Conditional UPDATE - Only update if condition is met
UPDATE courses
SET credit_hours = 4
WHERE course_code LIKE 'PHYS%' 
AND credit_hours = 3
AND EXISTS (
    SELECT 1 FROM enrollments e
    WHERE e.course_id = courses.course_id
);

-- ============================================
-- DELETE Operations
-- ============================================

-- 13. Basic DELETE - Remove specific record
-- First, let's add a test record to delete
INSERT INTO students (first_name, last_name, email, birth_date, status)
VALUES ('Test', 'Student', 'test.student@student.edu', '2003-01-01', 'Inactive');

-- Get the ID of the test student for demonstration
SET @test_student_id = LAST_INSERT_ID();

-- Delete the test student
DELETE FROM students WHERE student_id = @test_student_id;

-- 14. DELETE with condition
-- Remove students who never enrolled in any courses and are inactive
DELETE FROM students
WHERE status = 'Inactive'
AND student_id NOT IN (
    SELECT DISTINCT student_id FROM enrollments
);

-- 15. DELETE with JOIN (MySQL syntax)
-- Remove enrollments for dropped courses
-- First, let's mark a course as dropped for demonstration
UPDATE courses SET course_name = 'DROPPED - Introduction to Basket Weaving' 
WHERE course_id = (SELECT MAX(course_id) FROM (SELECT course_id FROM courses) AS temp);

-- Delete enrollments for dropped courses
DELETE e FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name LIKE 'DROPPED%';

-- Clean up the test
DELETE FROM courses WHERE course_name LIKE 'DROPPED%';

-- 16. DELETE with subquery - Remove old grade history records
DELETE FROM grades_history
WHERE change_date < DATE_SUB(CURRENT_DATE, INTERVAL 2 YEARS);

-- 17. DELETE with LIMIT - Remove only a specific number of records
-- Add some test records first
INSERT INTO grades_history (enrollment_id, old_grade, new_grade, changed_by, reason) VALUES
(1, 'B', 'B+', 'System', 'Test record 1'),
(2, 'C', 'C+', 'System', 'Test record 2'),
(3, 'A-', 'A', 'System', 'Test record 3');

-- Delete only 2 test records
DELETE FROM grades_history 
WHERE changed_by = 'System' 
ORDER BY history_id DESC 
LIMIT 2;

-- ============================================
-- Transaction Examples
-- ============================================

-- 18. Transaction with COMMIT
START TRANSACTION;

-- Add a new student
INSERT INTO students (first_name, last_name, email, birth_date)
VALUES ('Transaction', 'Test', 'transaction.test@student.edu', '2003-06-15');

SET @new_student_id = LAST_INSERT_ID();

-- Enroll them in a course
INSERT INTO enrollments (student_id, course_id, instructor_id, semester, year)
VALUES (@new_student_id, 1, 1, 'Spring', 2025);

-- Commit the transaction
COMMIT;

-- 19. Transaction with ROLLBACK
START TRANSACTION;

-- Try to make some changes
UPDATE students SET gpa = 5.0 WHERE student_id = @new_student_id; -- Invalid GPA
INSERT INTO enrollments (student_id, course_id, instructor_id, semester, year)
VALUES (@new_student_id, 999, 1, 'Spring', 2025); -- Invalid course_id

-- Rollback because we made invalid changes
ROLLBACK;

-- Verify the rollback worked
SELECT gpa FROM students WHERE student_id = @new_student_id;

-- ============================================
-- Bulk Operations
-- ============================================

-- 20. Bulk INSERT using INSERT ... SELECT
-- Create a temporary table for bulk operations
CREATE TEMPORARY TABLE temp_students (
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    birth_date DATE
);

-- Insert test data
INSERT INTO temp_students VALUES
('Bulk1', 'Student', 'bulk1@test.edu', '2003-01-01'),
('Bulk2', 'Student', 'bulk2@test.edu', '2003-02-01'),
('Bulk3', 'Student', 'bulk3@test.edu', '2003-03-01');

-- Bulk insert from temporary table
INSERT INTO students (first_name, last_name, email, birth_date, status)
SELECT first_name, last_name, email, birth_date, 'Active'
FROM temp_students;

-- 21. Bulk UPDATE
-- Update all students enrolled in Spring 2025 to set enrollment status
UPDATE enrollments 
SET status = 'In Progress'
WHERE semester = 'Spring' AND year = 2025 AND status = 'Enrolled';

-- 22. Bulk DELETE - Clean up test data
DELETE FROM students 
WHERE email LIKE '%@test.edu' OR email LIKE 'bulk%@test.edu';

-- ============================================
-- Advanced DML Patterns
-- ============================================

-- 23. UPSERT pattern (INSERT ... ON DUPLICATE KEY UPDATE)
-- Update course enrollment counts or insert if not exists
CREATE TEMPORARY TABLE course_enrollment_summary (
    course_id INT PRIMARY KEY,
    total_enrollments INT,
    active_enrollments INT,
    completed_enrollments INT
);

-- Calculate and insert/update enrollment summaries
INSERT INTO course_enrollment_summary (course_id, total_enrollments, active_enrollments, completed_enrollments)
SELECT 
    c.course_id,
    COUNT(e.enrollment_id) AS total_enrollments,
    COUNT(CASE WHEN e.status IN ('Enrolled', 'In Progress') THEN 1 END) AS active_enrollments,
    COUNT(CASE WHEN e.status = 'Completed' THEN 1 END) AS completed_enrollments
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id
ON DUPLICATE KEY UPDATE
    total_enrollments = VALUES(total_enrollments),
    active_enrollments = VALUES(active_enrollments),
    completed_enrollments = VALUES(completed_enrollments);

-- 24. Conditional INSERT - Only insert if condition is met
INSERT INTO enrollments (student_id, course_id, instructor_id, semester, year)
SELECT 1, 2, 7, 'Summer', 2025
WHERE NOT EXISTS (
    SELECT 1 FROM enrollments
    WHERE student_id = 1 AND course_id = 2 AND semester = 'Summer' AND year = 2025
);

-- 25. Multi-table UPDATE using JOIN
UPDATE students s
JOIN (
    SELECT 
        student_id,
        AVG(grade_points) as calculated_gpa
    FROM enrollments
    WHERE status = 'Completed' AND grade_points IS NOT NULL
    GROUP BY student_id
) calc ON s.student_id = calc.student_id
SET s.gpa = ROUND(calc.calculated_gpa, 2);

-- ============================================
-- Data Archiving and Cleanup
-- ============================================

-- 26. Archive old enrollments
CREATE TABLE IF NOT EXISTS archived_enrollments LIKE enrollments;

-- Move old completed enrollments to archive
INSERT INTO archived_enrollments
SELECT * FROM enrollments
WHERE status = 'Completed' AND year < 2024;

-- Remove archived records from main table
DELETE FROM enrollments
WHERE status = 'Completed' AND year < 2024;

-- 27. Cleanup orphaned records
-- Remove course schedules that have no corresponding course
DELETE FROM course_schedules
WHERE course_id NOT IN (SELECT course_id FROM courses);

-- Remove enrollments for non-existent students
DELETE FROM enrollments
WHERE student_id NOT IN (SELECT student_id FROM students);

-- ============================================
-- Performance Considerations
-- ============================================

-- 28. Batch processing for large updates
-- Update records in batches to avoid locking issues
SET @batch_size = 1000;
SET @affected_rows = 1;

-- Example: Update student records in batches
WHILE @affected_rows > 0 DO
    UPDATE students 
    SET updated_at = CURRENT_TIMESTAMP 
    WHERE updated_at < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY)
    LIMIT @batch_size;
    
    SET @affected_rows = ROW_COUNT();
END WHILE;

-- 29. Use indexes for better DML performance
-- Show current indexes
SHOW INDEX FROM students;
SHOW INDEX FROM enrollments;

-- Create indexes if they don't exist (they should from our setup script)
-- CREATE INDEX idx_students_status ON students(status);
-- CREATE INDEX idx_enrollments_status ON enrollments(status);

-- ============================================
-- Data Validation and Constraints
-- ============================================

-- 30. INSERT with validation
-- Add a check constraint (MySQL 8.0+)
-- ALTER TABLE students ADD CONSTRAINT chk_gpa CHECK (gpa >= 0.0 AND gpa <= 4.0);

-- Insert with manual validation
INSERT INTO students (first_name, last_name, email, birth_date, gpa)
SELECT 'Valid', 'Student', 'valid.student@student.edu', '2003-01-01', 3.5
WHERE 3.5 BETWEEN 0.0 AND 4.0;

-- 31. UPDATE with validation
UPDATE students 
SET gpa = CASE 
    WHEN 3.8 BETWEEN 0.0 AND 4.0 THEN 3.8 
    ELSE gpa 
END
WHERE student_id = 1;

-- ============================================
-- Verification and Cleanup
-- ============================================

-- Show row counts after operations
SELECT 'students' AS table_name, COUNT(*) AS row_count FROM students
UNION ALL
SELECT 'enrollments', COUNT(*) FROM enrollments
UNION ALL
SELECT 'courses', COUNT(*) FROM courses
UNION ALL
SELECT 'instructors', COUNT(*) FROM instructors;

-- Clean up any remaining test data
DELETE FROM students WHERE email LIKE '%@test.edu';
DELETE FROM students WHERE first_name = 'Transaction';

-- Drop temporary tables
DROP TEMPORARY TABLE IF EXISTS temp_students;
DROP TEMPORARY TABLE IF EXISTS course_enrollment_summary;

-- Drop archive table if you don't need it
-- DROP TABLE IF EXISTS archived_students;
-- DROP TABLE IF EXISTS archived_enrollments;

SELECT 'DML operations completed successfully!' AS Status;


