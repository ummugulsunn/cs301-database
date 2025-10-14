-- ============================================
-- CS301 Database Management Systems
-- 01: Database Setup and Schema Creation
-- ============================================

-- Create the university database
-- Note: Comment out the DROP DATABASE line after first run
-- DROP DATABASE IF EXISTS university;
CREATE DATABASE IF NOT EXISTS university;
USE university;

-- ============================================
-- DDL: Data Definition Language Examples
-- ============================================

-- Create Students table
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    birth_date DATE,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    gpa DECIMAL(3,2) DEFAULT 0.00,
    status ENUM('Active', 'Inactive', 'Graduated', 'Suspended') DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    department_code VARCHAR(10) NOT NULL UNIQUE,
    head_of_department VARCHAR(100),
    building VARCHAR(50),
    phone VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Courses table
CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_code VARCHAR(10) NOT NULL UNIQUE,
    course_name VARCHAR(100) NOT NULL,
    department_id INT,
    credit_hours INT NOT NULL CHECK (credit_hours > 0 AND credit_hours <= 6),
    description TEXT,
    prerequisites VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE SET NULL
);

-- Create Instructors table
CREATE TABLE instructors (
    instructor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    department_id INT,
    hire_date DATE,
    salary DECIMAL(10,2),
    title ENUM('Lecturer', 'Assistant Professor', 'Associate Professor', 'Professor') DEFAULT 'Lecturer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE SET NULL
);

-- Create Enrollments table (Many-to-Many relationship between students and courses)
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    instructor_id INT,
    semester VARCHAR(20) NOT NULL,
    year INT NOT NULL,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    grade CHAR(2) DEFAULT NULL,
    grade_points DECIMAL(3,2) DEFAULT NULL,
    status ENUM('Enrolled', 'Completed', 'Dropped', 'Withdrawn') DEFAULT 'Enrolled',
    UNIQUE KEY unique_enrollment (student_id, course_id, semester, year),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE,
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id) ON DELETE SET NULL
);

-- Create Course_Schedules table
CREATE TABLE course_schedules (
    schedule_id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL,
    instructor_id INT,
    semester VARCHAR(20) NOT NULL,
    year INT NOT NULL,
    days_of_week VARCHAR(10) NOT NULL, -- e.g., 'MWF', 'TTh'
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    classroom VARCHAR(20),
    max_capacity INT DEFAULT 30,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE,
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id) ON DELETE SET NULL
);

-- Create Grades_History table (for tracking grade changes)
CREATE TABLE grades_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    enrollment_id INT NOT NULL,
    old_grade CHAR(2),
    new_grade CHAR(2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    changed_by VARCHAR(100),
    reason TEXT,
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id) ON DELETE CASCADE
);

-- ============================================
-- Add Indexes for Performance
-- ============================================

-- Indexes on foreign keys
CREATE INDEX idx_courses_department ON courses(department_id);
CREATE INDEX idx_instructors_department ON instructors(department_id);
CREATE INDEX idx_enrollments_student ON enrollments(student_id);
CREATE INDEX idx_enrollments_course ON enrollments(course_id);
CREATE INDEX idx_enrollments_instructor ON enrollments(instructor_id);

-- Indexes on commonly queried columns
CREATE INDEX idx_students_email ON students(email);
CREATE INDEX idx_students_status ON students(status);
CREATE INDEX idx_enrollments_semester_year ON enrollments(semester, year);
CREATE INDEX idx_enrollments_grade ON enrollments(grade);
CREATE INDEX idx_courses_code ON courses(course_code);

-- Composite indexes for common query patterns
CREATE INDEX idx_enrollments_student_semester ON enrollments(student_id, semester, year);
CREATE INDEX idx_course_schedules_semester ON course_schedules(semester, year);

-- ============================================
-- Show Created Tables
-- ============================================

-- Display all tables in the database
SHOW TABLES;

-- Show the structure of each table
DESCRIBE students;
DESCRIBE departments;
DESCRIBE courses;
DESCRIBE instructors;
DESCRIBE enrollments;
DESCRIBE course_schedules;
DESCRIBE grades_history;

-- ============================================
-- Verify Table Creation
-- ============================================

-- Check table creation statements
SHOW CREATE TABLE students;
SHOW CREATE TABLE enrollments;

-- Check indexes
SHOW INDEX FROM students;
SHOW INDEX FROM enrollments;

SELECT 'Database schema created successfully!' AS Status;
