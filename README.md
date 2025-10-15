# CS301 Database Management Systems

**Course Materials and Practice Files**

This repository contains materials for CS301 Database Management Systems course.

## 📚 Course Info

- **Course Code**: CS301
- **Course Name**: Database Management Systems  
- **Academic Year**: 2025-2026
- **IDE**: DataGrip
- **Database**: MySQL/PostgreSQL

### 🎯 Course Goals

- Learn SQL basics
- Understand database design principles
- Practice with DataGrip
- Apply real-world scenarios

## 📁 File Structure

```
cs301-database/
├── 📚 docs/                          # Course documentation
│   ├── Database_Management_Fundamentals_Guide.md
│   └── README_How_to_Use.md
├── 🗄️ database/                      # SQL files
│   ├── 01_Database_Setup.sql         # Database creation
│   ├── 02_Sample_Data_Insert.sql     # Sample data
│   ├── 03_Basic_Queries.sql          # Basic SQL queries
│   ├── 04_Advanced_Queries.sql       # Advanced techniques
│   ├── 05_DML_Operations.sql         # Data manipulation
│   └── 06_DataGrip_Practice.sql      # Practice exercises
├── 📖 lectures/                      # Lecture notes
├── 🎯 exercises/                     # Exercises
├── 📊 projects/                      # Projects
└── 📝 notes/                         # Personal notes
```

## 🚀 Quick Start

### Requirements

- DataGrip IDE (Free for students)
- MySQL or PostgreSQL database server

### Setup Steps

1. **Clone repository**
   ```bash
   git clone https://github.com/your-username/cs301-database.git
   cd cs301-database
   ```

2. **Setup DataGrip**
   - Install DataGrip IDE
   - Create new database connection
   - Configure MySQL/PostgreSQL server

3. **Initialize database**
   ```sql
   -- Run setup script in DataGrip
   -- File: database/01_Database_Setup.sql
   ```

4. **Load sample data**
   ```sql
   -- Run data insertion script
   -- File: database/02_Sample_Data_Insert.sql
   ```

5. **Start practicing**
   ```sql
   -- Begin with basic queries
   -- File: database/03_Basic_Queries.sql
   ```

## 📖 Course Content

### Week 1: Database Fundamentals
- [ ] Database concepts and terminology
- [ ] Entity-Relationship modeling
- [ ] Database design principles
- [ ] Development environment setup

### Week 2: SQL Basics
- [ ] Data Definition Language (DDL)
- [ ] Data Manipulation Language (DML)
- [ ] Basic SELECT queries
- [ ] WHERE, ORDER BY, GROUP BY clauses

### Week 3: Advanced SQL
- [ ] JOIN operations (INNER, LEFT, RIGHT, FULL)
- [ ] Subqueries and correlated subqueries
- [ ] Window functions
- [ ] Common Table Expressions (CTEs)

### Week 4: Practical Applications
- [ ] Database optimization and indexing
- [ ] Transaction management
- [ ] Data integrity and constraints
- [ ] Real-world project implementation

## 🛠️ Tools and Technologies

| Tool | Purpose | Version |
|------|---------|---------|
| **DataGrip** | Database IDE | Latest |
| **MySQL** | Database Server | 8.0+ |
| **PostgreSQL** | Alternative DB | 13+ |
| **Git** | Version Control | Latest |

## 📊 Sample Database Schema

Our practice database includes a university management system:

```
🏛️ University Database Schema

Students (15 records)
├── Personal info (name, email, contact)
├── Academic data (GPA, enrollment date, status)
└── Course relationships via enrollments

Courses (18 records)
├── Course details (code, name, credits)
├── Department association
└── Prerequisite relationships

Departments (6 records)
├── Department info
├── Head of department
└── Building and contact details

Instructors (10 records)
├── Faculty info
├── Department association
└── Academic title and salary

Enrollments (50+ records)
├── Student-course relationships
├── Grade tracking
└── Semester and year info
```

## 🎯 Practice Exercises

### 📈 Difficulty Levels

| Level | Description | Files |
|-------|-------------|-------|
| **Beginner** | Basic SELECT, WHERE, ORDER BY | `03_Basic_Queries.sql` |
| **Intermediate** | JOINs, subqueries, aggregates | `04_Advanced_Queries.sql` |
| **Advanced** | Window functions, CTEs, optimization | `05_DML_Operations.sql` |
| **Expert** | Complex scenarios, performance tuning | `06_DataGrip_Practice.sql` |

### 🏆 Exercise Categories

- **Data Retrieval**: SELECT queries with various conditions
- **Data Manipulation**: INSERT, UPDATE, DELETE operations
- **Data Analysis**: Aggregations, grouping, and statistics
- **Database Design**: Schema optimization and normalization
- **Performance Tuning**: Indexing and query optimization

## 📚 Study Resources

### 📖 Recommended Reading
- **Textbook**: Database Management Systems by Raghu Ramakrishnan
- **SQL Reference**: W3Schools SQL Tutorial
- **Practice Platform**: HackerRank SQL Challenges

### 🔗 Useful Links
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [DataGrip User Guide](https://www.jetbrains.com/help/datagrip/)
- [SQL Fiddle](http://sqlfiddle.com/) - Online SQL testing


---

⭐ **Star this repository** if you found it helpful for your database studies!

📚 **Happy Learning!** Keep practicing SQL!
