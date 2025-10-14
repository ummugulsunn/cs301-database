# Database Management Fundamentals Guide
*A comprehensive reference for CS301 Database Management Systems*

## Table of Contents
1. [Database Fundamentals](#database-fundamentals)
2. [SQL Language Categories](#sql-language-categories)
3. [Data Definition Language (DDL)](#data-definition-language-ddl)
4. [Data Manipulation Language (DML)](#data-manipulation-language-dml)
5. [Data Query Language (DQL)](#data-query-language-dql)
6. [Data Control Language (DCL)](#data-control-language-dcl)
7. [Database Design Principles](#database-design-principles)
8. [Normalization](#normalization)
9. [Indexes and Performance](#indexes-and-performance)
10. [Transactions and ACID Properties](#transactions-and-acid-properties)
11. [DataGrip Tips and Shortcuts](#datagrip-tips-and-shortcuts)
12. [Common Patterns and Best Practices](#common-patterns-and-best-practices)

---

## Database Fundamentals

### Key Concepts
- **Database**: A structured collection of data
- **DBMS**: Database Management System - software that manages databases
- **Table**: A collection of related data organized in rows and columns
- **Schema**: The structure/blueprint of a database
- **Primary Key**: Unique identifier for each row in a table
- **Foreign Key**: A field that links to the primary key of another table
- **Relationship**: Connection between tables (One-to-One, One-to-Many, Many-to-Many)

### Database Models
- **Relational Model**: Data stored in tables with relationships
- **Entity-Relationship (ER) Model**: Conceptual representation of data
- **Hierarchical Model**: Tree-like structure
- **Network Model**: Graph-like structure

---

## SQL Language Categories

SQL commands are divided into four main categories:

| Category | Purpose | Commands |
|----------|---------|----------|
| **DDL** (Data Definition Language) | Define database structure | CREATE, ALTER, DROP, TRUNCATE |
| **DML** (Data Manipulation Language) | Manipulate data | INSERT, UPDATE, DELETE |
| **DQL** (Data Query Language) | Query data | SELECT |
| **DCL** (Data Control Language) | Control access | GRANT, REVOKE |

---

## Data Definition Language (DDL)

### CREATE TABLE
```sql
-- Basic table creation
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    birth_date DATE,
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table with foreign key
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
```

### ALTER TABLE
```sql
-- Add column
ALTER TABLE students ADD COLUMN phone VARCHAR(15);

-- Modify column
ALTER TABLE students MODIFY COLUMN email VARCHAR(150);

-- Drop column
ALTER TABLE students DROP COLUMN phone;

-- Add constraint
ALTER TABLE students ADD CONSTRAINT chk_email 
CHECK (email LIKE '%@%.%');
```

### DROP and TRUNCATE
```sql
-- Delete table structure and data
DROP TABLE students;

-- Delete all data but keep structure
TRUNCATE TABLE students;
```

---

## Data Manipulation Language (DML)

### INSERT
```sql
-- Insert single record
INSERT INTO students (student_id, first_name, last_name, email)
VALUES (1, 'John', 'Doe', 'john.doe@email.com');

-- Insert multiple records
INSERT INTO students (student_id, first_name, last_name, email)
VALUES 
    (2, 'Jane', 'Smith', 'jane.smith@email.com'),
    (3, 'Bob', 'Johnson', 'bob.johnson@email.com');

-- Insert from another table
INSERT INTO archived_students 
SELECT * FROM students WHERE graduation_year < 2020;
```

### UPDATE
```sql
-- Update single record
UPDATE students 
SET email = 'newemail@example.com' 
WHERE student_id = 1;

-- Update multiple records
UPDATE students 
SET enrollment_date = CURRENT_TIMESTAMP 
WHERE enrollment_date IS NULL;

-- Update with JOIN
UPDATE students s
JOIN enrollments e ON s.student_id = e.student_id
SET s.status = 'Active'
WHERE e.enrollment_date >= '2024-01-01';
```

### DELETE
```sql
-- Delete specific records
DELETE FROM students WHERE student_id = 1;

-- Delete with condition
DELETE FROM students WHERE enrollment_date < '2020-01-01';

-- Delete with subquery
DELETE FROM students 
WHERE student_id IN (
    SELECT student_id FROM enrollments 
    WHERE grade = 'F'
);
```

---

## Data Query Language (DQL)

### Basic SELECT
```sql
-- Select all columns
SELECT * FROM students;

-- Select specific columns
SELECT first_name, last_name, email FROM students;

-- Select with alias
SELECT 
    first_name AS "First Name",
    last_name AS "Last Name",
    email AS "Email Address"
FROM students;
```

### WHERE Clause
```sql
-- Basic conditions
SELECT * FROM students WHERE student_id = 1;
SELECT * FROM students WHERE first_name = 'John';
SELECT * FROM students WHERE enrollment_date > '2023-01-01';

-- Multiple conditions
SELECT * FROM students 
WHERE first_name = 'John' AND last_name = 'Doe';

SELECT * FROM students 
WHERE enrollment_date BETWEEN '2023-01-01' AND '2023-12-31';

SELECT * FROM students 
WHERE first_name IN ('John', 'Jane', 'Bob');

SELECT * FROM students 
WHERE email LIKE '%@gmail.com';
```

### JOIN Operations
```sql
-- INNER JOIN
SELECT s.first_name, s.last_name, c.course_name
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id;

-- LEFT JOIN
SELECT s.first_name, s.last_name, e.grade
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id;

-- RIGHT JOIN
SELECT s.first_name, s.last_name, c.course_name
FROM students s
RIGHT JOIN enrollments e ON s.student_id = e.student_id
RIGHT JOIN courses c ON e.course_id = c.course_id;

-- FULL OUTER JOIN
SELECT s.first_name, c.course_name
FROM students s
FULL OUTER JOIN enrollments e ON s.student_id = e.student_id
FULL OUTER JOIN courses c ON e.course_id = c.course_id;
```

### Aggregate Functions
```sql
-- COUNT
SELECT COUNT(*) FROM students;
SELECT COUNT(DISTINCT first_name) FROM students;

-- SUM, AVG, MIN, MAX
SELECT 
    AVG(grade_points) AS average_gpa,
    MIN(grade_points) AS lowest_gpa,
    MAX(grade_points) AS highest_gpa,
    SUM(credit_hours) AS total_credits
FROM enrollments;
```

### GROUP BY and HAVING
```sql
-- GROUP BY
SELECT course_id, COUNT(*) as enrollment_count
FROM enrollments
GROUP BY course_id;

-- GROUP BY with HAVING
SELECT course_id, AVG(grade_points) as avg_grade
FROM enrollments
GROUP BY course_id
HAVING AVG(grade_points) > 3.0;
```

### ORDER BY
```sql
-- Single column
SELECT * FROM students ORDER BY last_name;

-- Multiple columns
SELECT * FROM students 
ORDER BY last_name ASC, first_name ASC;

-- With LIMIT
SELECT * FROM students 
ORDER BY enrollment_date DESC 
LIMIT 10;
```

### Subqueries
```sql
-- Subquery in WHERE
SELECT * FROM students
WHERE student_id IN (
    SELECT student_id FROM enrollments 
    WHERE grade = 'A'
);

-- Correlated subquery
SELECT s.first_name, s.last_name
FROM students s
WHERE EXISTS (
    SELECT 1 FROM enrollments e 
    WHERE e.student_id = s.student_id 
    AND e.grade = 'A'
);
```

---

## Data Control Language (DCL)

### User Management
```sql
-- Create user
CREATE USER 'student_user'@'localhost' IDENTIFIED BY 'password123';

-- Grant privileges
GRANT SELECT, INSERT, UPDATE ON university.students TO 'student_user'@'localhost';
GRANT ALL PRIVILEGES ON university.* TO 'admin_user'@'localhost';

-- Revoke privileges
REVOKE INSERT, UPDATE ON university.students FROM 'student_user'@'localhost';

-- Drop user
DROP USER 'student_user'@'localhost';
```

---

## Database Design Principles

### Entity-Relationship Design
1. **Identify Entities**: Objects or concepts (Student, Course, Enrollment)
2. **Identify Attributes**: Properties of entities (Name, ID, Date)
3. **Identify Relationships**: How entities relate to each other
4. **Determine Cardinality**: One-to-One, One-to-Many, Many-to-Many

### Key Design Rules
- **Every table should have a primary key**
- **Use meaningful table and column names**
- **Avoid redundant data**
- **Maintain referential integrity**
- **Choose appropriate data types**

### Data Types (Common)
```sql
-- Numeric
INT, BIGINT, DECIMAL(10,2), FLOAT, DOUBLE

-- String
VARCHAR(255), CHAR(10), TEXT, LONGTEXT

-- Date/Time
DATE, TIME, DATETIME, TIMESTAMP

-- Boolean
BOOLEAN, TINYINT(1)

-- JSON (MySQL 5.7+)
JSON
```

---

## Normalization

### First Normal Form (1NF)
- Each column contains atomic (indivisible) values
- Each column contains values of the same type
- Each column has a unique name
- Order doesn't matter

### Second Normal Form (2NF)
- Must be in 1NF
- No partial dependencies on composite primary key

### Third Normal Form (3NF)
- Must be in 2NF
- No transitive dependencies

### Example of Normalization
```sql
-- Unnormalized table
CREATE TABLE student_courses (
    student_id INT,
    student_name VARCHAR(100),
    courses VARCHAR(500), -- "Math,Physics,Chemistry"
    instructor_names VARCHAR(500) -- "Dr.Smith,Dr.Jones,Dr.Brown"
);

-- Normalized tables
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    instructor_name VARCHAR(100)
);

CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
```

---

## Indexes and Performance

### Creating Indexes
```sql
-- Single column index
CREATE INDEX idx_student_email ON students(email);

-- Composite index
CREATE INDEX idx_enrollment_student_course ON enrollments(student_id, course_id);

-- Unique index
CREATE UNIQUE INDEX idx_student_email_unique ON students(email);

-- Drop index
DROP INDEX idx_student_email ON students;
```

### When to Use Indexes
- **Create indexes on**: Frequently queried columns, Foreign keys, WHERE clause columns
- **Avoid indexes on**: Small tables, Frequently updated columns, Columns with many NULL values

### Query Optimization Tips
```sql
-- Use EXPLAIN to analyze query performance
EXPLAIN SELECT * FROM students WHERE email = 'john@example.com';

-- Avoid SELECT *
SELECT student_id, first_name, last_name FROM students;

-- Use LIMIT for large result sets
SELECT * FROM students ORDER BY enrollment_date LIMIT 100;
```

---

## Transactions and ACID Properties

### ACID Properties
- **Atomicity**: All or nothing - transaction completes fully or not at all
- **Consistency**: Database remains in valid state
- **Isolation**: Transactions don't interfere with each other
- **Durability**: Committed changes are permanent

### Transaction Control
```sql
-- Start transaction
START TRANSACTION;

-- Example operations
INSERT INTO students (student_id, first_name, last_name) 
VALUES (100, 'Test', 'User');

UPDATE students SET email = 'test@example.com' 
WHERE student_id = 100;

-- Commit changes
COMMIT;

-- Or rollback if something goes wrong
-- ROLLBACK;
```

### Isolation Levels
```sql
-- Set isolation level
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
```

---

## DataGrip Tips and Shortcuts

### Essential Shortcuts
- **Ctrl+Enter**: Execute current statement
- **Ctrl+Shift+Enter**: Execute all statements
- **Ctrl+/**: Comment/uncomment line
- **Ctrl+D**: Duplicate line
- **Ctrl+Y**: Delete line
- **Ctrl+Space**: Auto-completion
- **F4**: Edit table data
- **Ctrl+B**: Navigate to declaration

### DataGrip Features
1. **Database Explorer**: Navigate your database structure
2. **Query Console**: Write and execute SQL
3. **Data Editor**: Edit table data directly
4. **Schema Comparison**: Compare database structures
5. **SQL Formatter**: Auto-format your SQL code
6. **Version Control**: Git integration for SQL scripts

### DataGrip Best Practices
- Use separate query consoles for different tasks
- Save frequently used queries as files
- Use the scratch files for temporary queries
- Set up database connections with appropriate permissions
- Use the data sources and drivers dialog for connection management

---

## Common Patterns and Best Practices

### Naming Conventions
```sql
-- Table names: plural, lowercase with underscores
CREATE TABLE students, course_enrollments, user_profiles;

-- Column names: lowercase with underscores
student_id, first_name, created_at, is_active;

-- Primary keys: table_name + _id
student_id, course_id, enrollment_id;

-- Foreign keys: referenced_table + _id
student_id (referencing students table)
```

### Common Query Patterns
```sql
-- Find duplicates
SELECT email, COUNT(*) 
FROM students 
GROUP BY email 
HAVING COUNT(*) > 1;

-- Rank students by GPA
SELECT student_id, gpa,
       RANK() OVER (ORDER BY gpa DESC) as rank
FROM students;

-- Running total
SELECT student_id, credit_hours,
       SUM(credit_hours) OVER (ORDER BY enrollment_date) as running_total
FROM enrollments;

-- Pagination
SELECT * FROM students 
ORDER BY student_id 
LIMIT 20 OFFSET 40; -- Page 3, 20 records per page
```

### Error Handling and Debugging
```sql
-- Check for NULL values
SELECT COUNT(*) FROM students WHERE email IS NULL;

-- Validate foreign key relationships
SELECT s.student_id 
FROM students s 
LEFT JOIN enrollments e ON s.student_id = e.student_id 
WHERE e.student_id IS NULL;

-- Check data types
DESCRIBE students;
SHOW CREATE TABLE students;
```

### Performance Monitoring
```sql
-- Show running processes
SHOW PROCESSLIST;

-- Show table sizes
SELECT 
    table_name,
    table_rows,
    data_length,
    index_length
FROM information_schema.tables 
WHERE table_schema = 'your_database_name';

-- Show slow queries (enable slow query log first)
SELECT * FROM mysql.slow_log ORDER BY start_time DESC LIMIT 10;
```

---

## Quick Reference Commands

### Database Operations
```sql
-- Show databases
SHOW DATABASES;

-- Create database
CREATE DATABASE university;

-- Use database
USE university;

-- Drop database
DROP DATABASE university;
```

### Table Information
```sql
-- Show tables
SHOW TABLES;

-- Describe table structure
DESCRIBE students;
SHOW CREATE TABLE students;

-- Show table status
SHOW TABLE STATUS LIKE 'students';
```

### Data Export/Import
```sql
-- Export data
SELECT * FROM students 
INTO OUTFILE '/path/to/students.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- Import data
LOAD DATA INFILE '/path/to/students.csv'
INTO TABLE students
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
```

---

## Study Tips for CS301

1. **Practice regularly**: Write SQL queries daily
2. **Understand concepts**: Don't just memorize syntax
3. **Use sample databases**: Practice with real-world-like data
4. **Draw ER diagrams**: Visualize relationships before coding
5. **Optimize queries**: Always think about performance
6. **Learn by examples**: Study existing database schemas
7. **Test edge cases**: What happens with NULL values, duplicates?
8. **Use DataGrip's features**: Leverage auto-completion and error detection

---

*This guide covers the fundamental concepts you'll need for database management. Keep practicing with DataGrip and refer back to this guide as needed. Good luck with CS301!*
