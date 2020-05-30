/*
	DROP TABLES IF THEY ALREADY EXIST IN DATABASE.
	MAKE SURE THAT OUR SCHEMA EXISTS AND IF IT DOESN'T CREATE IT
*/

CREATE SCHEMA IF NOT EXISTS emp;

DROP TABLE IF EXISTS emp.TITLES;
DROP TABLE IF EXISTS emp.SALARIES;
DROP TABLE IF EXISTS emp.DEPT_MANAGER;
DROP TABLE IF EXISTS emp.DEPT_EMP;
DROP TABLE IF EXISTS emp.DEPARTMENT;
DROP TABLE IF EXISTS emp.EMPLOYEES;
---------------------------------------------------------------------------
/*
	CREATING TABLES
*/

CREATE TABLE emp.department (
    dept_no VARCHAR(8) CONSTRAINT PK_DEPARTMENT PRIMARY KEY,
    dept_name VARCHAR(100)  NOT NULL
);

CREATE TABLE emp.dept_emp (
    id_dept_emp SERIAL CONSTRAINT PK_DEPT_EMP PRIMARY KEY,
    emp_no VARCHAR(8) NOT NULL,
    dept_no VARCHAR(8) NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL
);

CREATE TABLE emp.employees (
    emp_no VARCHAR(8)  CONSTRAINT PK_EMPLOYEES PRIMARY KEY,
    brith_date DATE   NOT NULL,
    first_name VARCHAR(50)   NOT NULL,
    last_name VARCHAR(50)  NOT NULL,
    gender VARCHAR(1)   NOT NULL,
    hired_date DATE   NOT NULL
);

CREATE TABLE emp.dept_manager (
    id_dept_manager SERIAL   CONSTRAINT PK_DEPT_MANAGER PRIMARY KEY,
    dept_no VARCHAR(8)   NOT NULL,
    emp_no VARCHAR(8)   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL
);

CREATE TABLE emp.salaries (
    id_salary SERIAL     CONSTRAINT PK_SALARIES PRIMARY KEY,
    emp_no VARCHAR(8)   NOT NULL,
    salary NUMERIC(12,4)   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL
);

CREATE TABLE emp.titles (
    id_titles SERIAL    CONSTRAINT PK_TITLES PRIMARY KEY,
    emp_no VARCHAR(8)   NOT NULL,
    title VARCHAR(80)  NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL
);
---------------------------------------------------------------------------
/*
	ADDING RELATIONSHIPS (FK CONSTRAINTS)
*/
ALTER TABLE emp.dept_emp ADD CONSTRAINT fk_dept_emp_emp_no FOREIGN KEY(emp_no)
REFERENCES emp.employees (emp_no);

ALTER TABLE emp.dept_emp ADD CONSTRAINT fk_dept_emp_dept_no FOREIGN KEY(dept_no)
REFERENCES emp.department (dept_no);

ALTER TABLE emp.dept_manager ADD CONSTRAINT fk_dept_manager_dept_no FOREIGN KEY(dept_no)
REFERENCES emp.department (dept_no);

ALTER TABLE emp.dept_manager ADD CONSTRAINT fk_dept_manager_emp_no FOREIGN KEY(emp_no)
REFERENCES emp.employees (emp_no);

ALTER TABLE emp.salaries ADD CONSTRAINT fk_salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES emp.employees ("emp_no");

ALTER TABLE emp.titles ADD CONSTRAINT fk_titles_emp_no FOREIGN KEY(emp_no)
REFERENCES emp.employees (emp_no);

---------------------------------------------------------------------------
/*
	IMPORTING DATA FROM SOURCE CSV
	MUST CHANGE PATH TO THE LOCATION OF YOUR FILES  )
*/

COPY emp.department FROM '/home/mario/Descargas/data/departments.csv' HEADER CSV;
COPY emp.employees FROM '/home/mario/Descargas/data/employees.csv' HEADER CSV;
COPY emp.dept_emp (emp_no, dept_no, from_date, to_date) FROM '/home/mario/Descargas/data/dept_emp.csv' HEADER CSV;
COPY emp.dept_manager (dept_no, emp_no, from_date, to_date) FROM '/home/mario/Descargas/data/dept_manager.csv' HEADER CSV;
COPY emp.salaries (emp_no, salary, from_date, to_date) FROM '/home/mario/Descargas/data/salaries.csv' HEADER CSV;
COPY emp.titles (emp_no, title, from_date, to_date) FROM '/home/mario/Descargas/data/titles.csv' HEADER CSV;
---------------------------------------------------------------------------
/*
	VALIDATING THAT DATA WAS INSERTED CORRECTLY
*/
SELECT * FROM emp.department LIMIT 10;
SELECT * FROM emp.employees LIMIT 10;
SELECT * FROM emp.dept_emp LIMIT 10;
SELECT * FROM emp.dept_manager LIMIT 10;
SELECT * FROM emp.salaries LIMIT 10;
SELECT * FROM emp.titles LIMIT 10;

SELECT COUNT(*) FROM emp.department;
SELECT COUNT(*) FROM emp.employees;
SELECT COUNT(*) FROM emp.dept_emp;
SELECT COUNT(*) FROM emp.dept_manager;
SELECT COUNT(*) FROM emp.salaries;
SELECT COUNT(*) FROM emp.titles;




