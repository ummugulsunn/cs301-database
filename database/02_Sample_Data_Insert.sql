-- ============================================
-- CS301 Database Management Systems
-- 02: Sample Data Insertion (DML Examples)
-- ============================================

-- Make sure you're using the university database
USE university;

-- ============================================
-- DML: Data Manipulation Language Examples
-- ============================================

-- Insert Departments
INSERT INTO departments (department_name, department_code, head_of_department, building, phone) VALUES
('Computer Science', 'CS', 'Dr. Sarah Johnson', 'Engineering Building', '555-0101'),
('Mathematics', 'MATH', 'Dr. Robert Chen', 'Science Hall', '555-0102'),
('Physics', 'PHYS', 'Dr. Maria Garcia', 'Science Hall', '555-0103'),
('Business Administration', 'BUS', 'Dr. Michael Brown', 'Business Center', '555-0104'),
('English Literature', 'ENG', 'Dr. Emily Davis', 'Humanities Building', '555-0105'),
('Psychology', 'PSYC', 'Dr. David Wilson', 'Social Sciences', '555-0106');

-- Insert Instructors
INSERT INTO instructors (first_name, last_name, email, phone, department_id, hire_date, salary, title) VALUES
('Sarah', 'Johnson', 'sarah.johnson@university.edu', '555-1001', 1, '2018-08-15', 85000.00, 'Professor'),
('Robert', 'Chen', 'robert.chen@university.edu', '555-1002', 2, '2019-01-10', 75000.00, 'Associate Professor'),
('Maria', 'Garcia', 'maria.garcia@university.edu', '555-1003', 3, '2020-08-20', 70000.00, 'Assistant Professor'),
('Michael', 'Brown', 'michael.brown@university.edu', '555-1004', 4, '2017-09-01', 90000.00, 'Professor'),
('Emily', 'Davis', 'emily.davis@university.edu', '555-1005', 5, '2021-01-15', 65000.00, 'Assistant Professor'),
('David', 'Wilson', 'david.wilson@university.edu', '555-1006', 6, '2019-08-25', 72000.00, 'Associate Professor'),
('Lisa', 'Anderson', 'lisa.anderson@university.edu', '555-1007', 1, '2020-01-20', 68000.00, 'Assistant Professor'),
('James', 'Miller', 'james.miller@university.edu', '555-1008', 2, '2018-09-10', 78000.00, 'Associate Professor'),
('Anna', 'Taylor', 'anna.taylor@university.edu', '555-1009', 1, '2021-08-30', 62000.00, 'Lecturer'),
('Thomas', 'Moore', 'thomas.moore@university.edu', '555-1010', 4, '2019-02-14', 73000.00, 'Associate Professor');

-- Insert Courses
INSERT INTO courses (course_code, course_name, department_id, credit_hours, description, prerequisites) VALUES
-- Computer Science Courses
('CS101', 'Introduction to Programming', 1, 3, 'Basic programming concepts using Python', NULL),
('CS201', 'Data Structures', 1, 3, 'Arrays, linked lists, stacks, queues, trees', 'CS101'),
('CS301', 'Database Management Systems', 1, 3, 'Relational databases, SQL, normalization', 'CS201'),
('CS401', 'Software Engineering', 1, 3, 'Software development lifecycle, project management', 'CS301'),
('CS205', 'Computer Networks', 1, 3, 'Network protocols, TCP/IP, network security', 'CS201'),

-- Mathematics Courses
('MATH101', 'Calculus I', 2, 4, 'Limits, derivatives, applications of derivatives', NULL),
('MATH102', 'Calculus II', 2, 4, 'Integration, applications of integration', 'MATH101'),
('MATH201', 'Linear Algebra', 2, 3, 'Matrices, vector spaces, eigenvalues', 'MATH102'),
('MATH301', 'Statistics', 2, 3, 'Probability, hypothesis testing, regression', 'MATH201'),

-- Physics Courses
('PHYS101', 'Physics I', 3, 4, 'Mechanics, thermodynamics, waves', 'MATH101'),
('PHYS102', 'Physics II', 3, 4, 'Electricity, magnetism, optics', 'PHYS101'),

-- Business Courses
('BUS101', 'Introduction to Business', 4, 3, 'Business fundamentals, entrepreneurship', NULL),
('BUS201', 'Marketing Principles', 4, 3, 'Marketing mix, consumer behavior', 'BUS101'),
('BUS301', 'Financial Management', 4, 3, 'Corporate finance, investment analysis', 'BUS201'),

-- English Courses
('ENG101', 'English Composition', 5, 3, 'Academic writing, research methods', NULL),
('ENG201', 'World Literature', 5, 3, 'Global literary traditions', 'ENG101'),

-- Psychology Courses
('PSYC101', 'Introduction to Psychology', 6, 3, 'Basic psychological principles', NULL),
('PSYC201', 'Research Methods', 6, 3, 'Experimental design, statistical analysis', 'PSYC101');

-- Insert Students
INSERT INTO students (first_name, last_name, email, phone, birth_date, enrollment_date, gpa, status) VALUES
('John', 'Doe', 'john.doe@student.edu', '555-2001', '2002-05-15', '2021-08-25', 3.75, 'Active'),
('Jane', 'Smith', 'jane.smith@student.edu', '555-2002', '2001-12-03', '2020-08-20', 3.90, 'Active'),
('Bob', 'Johnson', 'bob.johnson@student.edu', '555-2003', '2002-08-22', '2021-08-25', 3.25, 'Active'),
('Alice', 'Williams', 'alice.williams@student.edu', '555-2004', '2000-11-10', '2019-08-15', 3.95, 'Active'),
('Charlie', 'Brown', 'charlie.brown@student.edu', '555-2005', '2002-03-18', '2021-01-15', 2.85, 'Active'),
('Diana', 'Davis', 'diana.davis@student.edu', '555-2006', '2001-07-25', '2020-08-20', 3.60, 'Active'),
('Eve', 'Miller', 'eve.miller@student.edu', '555-2007', '2002-01-30', '2021-08-25', 3.40, 'Active'),
('Frank', 'Wilson', 'frank.wilson@student.edu', '555-2008', '2001-09-12', '2020-01-20', 3.80, 'Active'),
('Grace', 'Moore', 'grace.moore@student.edu', '555-2009', '2002-06-08', '2021-08-25', 3.55, 'Active'),
('Henry', 'Taylor', 'henry.taylor@student.edu', '555-2010', '2000-04-14', '2019-08-15', 3.70, 'Active'),
('Ivy', 'Anderson', 'ivy.anderson@student.edu', '555-2011', '2001-10-28', '2020-08-20', 3.85, 'Active'),
('Jack', 'Thomas', 'jack.thomas@student.edu', '555-2012', '2002-02-19', '2021-01-15', 3.15, 'Active'),
('Kate', 'Jackson', 'kate.jackson@student.edu', '555-2013', '2001-08-05', '2020-08-20', 3.65, 'Active'),
('Leo', 'White', 'leo.white@student.edu', '555-2014', '2002-12-01', '2021-08-25', 3.30, 'Active'),
('Mia', 'Harris', 'mia.harris@student.edu', '555-2015', '2000-03-22', '2019-08-15', 3.88, 'Graduated');

-- Insert Course Schedules
INSERT INTO course_schedules (course_id, instructor_id, semester, year, days_of_week, start_time, end_time, classroom, max_capacity) VALUES
-- Fall 2024 Schedule
(1, 1, 'Fall', 2024, 'MWF', '09:00:00', '09:50:00', 'CS-101', 35),
(2, 7, 'Fall', 2024, 'TTh', '10:00:00', '11:15:00', 'CS-102', 30),
(3, 1, 'Fall', 2024, 'MWF', '11:00:00', '11:50:00', 'CS-103', 25),
(4, 7, 'Fall', 2024, 'TTh', '14:00:00', '15:15:00', 'CS-104', 20),
(5, 9, 'Fall', 2024, 'MWF', '13:00:00', '13:50:00', 'CS-105', 30),

(6, 2, 'Fall', 2024, 'MWF', '08:00:00', '08:50:00', 'MATH-201', 40),
(7, 8, 'Fall', 2024, 'TTh', '09:00:00', '10:15:00', 'MATH-202', 35),
(8, 2, 'Fall', 2024, 'MWF', '10:00:00', '10:50:00', 'MATH-203', 30),
(9, 8, 'Fall', 2024, 'TTh', '11:00:00', '12:15:00', 'MATH-204', 25),

(10, 3, 'Fall', 2024, 'MWF', '14:00:00', '14:50:00', 'PHYS-101', 30),
(11, 3, 'Fall', 2024, 'TTh', '15:00:00', '16:15:00', 'PHYS-102', 25),

(12, 4, 'Fall', 2024, 'MWF', '09:00:00', '09:50:00', 'BUS-201', 45),
(13, 10, 'Fall', 2024, 'TTh', '10:00:00', '11:15:00', 'BUS-202', 40),
(14, 4, 'Fall', 2024, 'MWF', '11:00:00', '11:50:00', 'BUS-203', 35),

(15, 5, 'Fall', 2024, 'MWF', '13:00:00', '13:50:00', 'ENG-101', 25),
(16, 5, 'Fall', 2024, 'TTh', '14:00:00', '15:15:00', 'ENG-102', 20),

(17, 6, 'Fall', 2024, 'MWF', '10:00:00', '10:50:00', 'PSYC-201', 35),
(18, 6, 'Fall', 2024, 'TTh', '11:00:00', '12:15:00', 'PSYC-202', 30);

-- Insert Enrollments (Fall 2024)
INSERT INTO enrollments (student_id, course_id, instructor_id, semester, year, enrollment_date, grade, grade_points, status) VALUES
-- John Doe's enrollments
(1, 1, 1, 'Fall', 2024, '2024-08-20', 'A', 4.00, 'Completed'),
(1, 6, 2, 'Fall', 2024, '2024-08-20', 'B+', 3.33, 'Completed'),
(1, 12, 4, 'Fall', 2024, '2024-08-20', 'A-', 3.67, 'Completed'),
(1, 15, 5, 'Fall', 2024, '2024-08-20', 'B', 3.00, 'Completed'),

-- Jane Smith's enrollments
(2, 2, 7, 'Fall', 2024, '2024-08-20', 'A', 4.00, 'Completed'),
(2, 7, 8, 'Fall', 2024, '2024-08-20', 'A', 4.00, 'Completed'),
(2, 10, 3, 'Fall', 2024, '2024-08-20', 'A-', 3.67, 'Completed'),
(2, 17, 6, 'Fall', 2024, '2024-08-20', 'A', 4.00, 'Completed'),

-- Bob Johnson's enrollments
(3, 1, 1, 'Fall', 2024, '2024-08-20', 'C+', 2.33, 'Completed'),
(3, 6, 2, 'Fall', 2024, '2024-08-20', 'B', 3.00, 'Completed'),
(3, 12, 4, 'Fall', 2024, '2024-08-20', 'B-', 2.67, 'Completed'),

-- Alice Williams's enrollments (Advanced student)
(4, 3, 1, 'Fall', 2024, '2024-08-20', 'A', 4.00, 'Completed'),
(4, 8, 2, 'Fall', 2024, '2024-08-20', 'A', 4.00, 'Completed'),
(4, 13, 10, 'Fall', 2024, '2024-08-20', 'A-', 3.67, 'Completed'),
(4, 16, 5, 'Fall', 2024, '2024-08-20', 'A', 4.00, 'Completed'),

-- Charlie Brown's enrollments
(5, 1, 1, 'Fall', 2024, '2024-08-20', 'D+', 1.33, 'Completed'),
(5, 6, 2, 'Fall', 2024, '2024-08-20', 'C', 2.00, 'Completed'),
(5, 15, 5, 'Fall', 2024, '2024-08-20', 'C+', 2.33, 'Completed'),

-- Diana Davis's enrollments
(6, 2, 7, 'Fall', 2024, '2024-08-20', 'B+', 3.33, 'Completed'),
(6, 7, 8, 'Fall', 2024, '2024-08-20', 'A-', 3.67, 'Completed'),
(6, 12, 4, 'Fall', 2024, '2024-08-20', 'B', 3.00, 'Completed'),
(6, 17, 6, 'Fall', 2024, '2024-08-20', 'B+', 3.33, 'Completed'),

-- More enrollments for other students
(7, 1, 1, 'Fall', 2024, '2024-08-20', 'B', 3.00, 'Completed'),
(7, 10, 3, 'Fall', 2024, '2024-08-20', 'B+', 3.33, 'Completed'),
(7, 15, 5, 'Fall', 2024, '2024-08-20', 'A-', 3.67, 'Completed'),

(8, 2, 7, 'Fall', 2024, '2024-08-20', 'A-', 3.67, 'Completed'),
(8, 8, 2, 'Fall', 2024, '2024-08-20', 'B+', 3.33, 'Completed'),
(8, 13, 10, 'Fall', 2024, '2024-08-20', 'A', 4.00, 'Completed'),

(9, 1, 1, 'Fall', 2024, '2024-08-20', 'B-', 2.67, 'Completed'),
(9, 6, 2, 'Fall', 2024, '2024-08-20', 'B', 3.00, 'Completed'),
(9, 17, 6, 'Fall', 2024, '2024-08-20', 'B+', 3.33, 'Completed'),

(10, 3, 1, 'Fall', 2024, '2024-08-20', 'A-', 3.67, 'Completed'),
(10, 9, 8, 'Fall', 2024, '2024-08-20', 'A', 4.00, 'Completed'),
(10, 14, 4, 'Fall', 2024, '2024-08-20', 'B+', 3.33, 'Completed'),

-- Spring 2025 Current Enrollments (in progress)
(1, 2, 7, 'Spring', 2025, '2025-01-15', NULL, NULL, 'Enrolled'),
(1, 7, 8, 'Spring', 2025, '2025-01-15', NULL, NULL, 'Enrolled'),
(1, 13, 10, 'Spring', 2025, '2025-01-15', NULL, NULL, 'Enrolled'),

(2, 3, 1, 'Spring', 2025, '2025-01-15', NULL, NULL, 'Enrolled'),
(2, 8, 2, 'Spring', 2025, '2025-01-15', NULL, NULL, 'Enrolled'),
(2, 14, 4, 'Spring', 2025, '2025-01-15', NULL, NULL, 'Enrolled'),

(3, 2, 7, 'Spring', 2025, '2025-01-15', NULL, NULL, 'Enrolled'),
(3, 7, 8, 'Spring', 2025, '2025-01-15', NULL, NULL, 'Enrolled'),
(3, 17, 6, 'Spring', 2025, '2025-01-15', NULL, NULL, 'Enrolled');

-- Insert some grade history records
INSERT INTO grades_history (enrollment_id, old_grade, new_grade, change_date, changed_by, reason) VALUES
(1, 'B+', 'A', '2024-12-15 14:30:00', 'Dr. Sarah Johnson', 'Extra credit project completed'),
(5, 'D', 'D+', '2024-12-10 16:45:00', 'Dr. Sarah Johnson', 'Grade correction after review'),
(12, 'B-', 'B', '2024-12-12 11:20:00', 'Dr. Robert Chen', 'Attendance bonus applied');

-- ============================================
-- Verification Queries
-- ============================================

-- Count records in each table
SELECT 'departments' AS table_name, COUNT(*) AS record_count FROM departments
UNION ALL
SELECT 'instructors', COUNT(*) FROM instructors
UNION ALL
SELECT 'courses', COUNT(*) FROM courses
UNION ALL
SELECT 'students', COUNT(*) FROM students
UNION ALL
SELECT 'course_schedules', COUNT(*) FROM course_schedules
UNION ALL
SELECT 'enrollments', COUNT(*) FROM enrollments
UNION ALL
SELECT 'grades_history', COUNT(*) FROM grades_history;

-- Sample data verification
SELECT 'Sample data inserted successfully!' AS Status;

-- Show some sample records
SELECT 'Sample Students:' AS Info;
SELECT student_id, first_name, last_name, email, gpa, status FROM students LIMIT 5;

SELECT 'Sample Courses:' AS Info;
SELECT course_id, course_code, course_name, credit_hours FROM courses LIMIT 5;

SELECT 'Sample Enrollments:' AS Info;
SELECT e.enrollment_id, s.first_name, s.last_name, c.course_code, e.grade, e.status 
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
LIMIT 10;


