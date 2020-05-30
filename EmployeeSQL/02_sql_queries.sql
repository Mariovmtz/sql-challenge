------------------------------------------------------------------------------
/*
	1 - LIST THE EMPLOYEE NUMBER, LAST NAME, FIRST NAME, GENDER AND SALARY
*/
------------------------------------------------------------------------------
SELECT emp.emp_no, emp.last_name, emp.first_name, emp.gender, sal.salary
FROM emp.employees as emp
INNER JOIN emp.salaries as sal ON
	emp.emp_no = sal.emp_no
ORDER BY emp.emp_no
------------------------------------------------------------------------------
/*
	2 - LIST EMPLOYEES WHO WERE HIRED IN 1986
*/
------------------------------------------------------------------------------
SELECT * 
FROM emp.Employees
WHERE hired_date BETWEEN '1986-01-01' AND '1986-12-31'
------------------------------------------------------------------------------
/*
	3 - LIST THE MANAGER OF EACH DEPARTMENT WITH THE FOLLOWING INFORMATION:
		DEPARTMENT NUMBER, DEPARTMENT NAME, MANAGER'S EMPLOYEE NUMBER, LAST NAME,
		FIRST NAME AND START AND END EMPLOYMENT DATES
*/
------------------------------------------------------------------------------
SELECT dptMng.dept_no, dept.dept_name, dptMng.emp_no, emp.last_name, emp.first_name, dptMng.from_date, dptMng.to_date
FROM emp.dept_manager as dptMng
INNER JOIN emp.employees as emp ON
dptMng.emp_no = emp.emp_no
INNER JOIN emp.department as dept ON
dptMng.dept_no = dept.dept_no
ORDER BY dptMng.dept_no, dptMng.from_date
------------------------------------------------------------------------------
/*
	4 - LIST THE DEPARTMENT OF EACH EMPLOYEE WITH THE FOLLOWING INFORMATION:
		EMPLOYEE NUMBER, LAST NAME, FIRST NAME AND DEPARTMENT NAME
		
		NOTE: BELOW QUERY WILL OUTPUT ONLY THE LAST DEPARTMENT BY DATE IN WHICH 
		OUR EMPLOYEE WAS WORKING (USING 2 CTE, THEY WORKS AS SUBQUERIES)
*/
------------------------------------------------------------------------------
WITH CTE_MAX_DATE AS (
	SELECT emp_no, MAX(to_date) as max_to_date
	FROM emp.dept_emp
	GROUP BY emp_no
),
	CTE_FILTER AS (
	
	SELECT * 
	FROM emp.dept_emp as a 
		WHERE EXISTS (SELECT * FROM CTE_MAX_DATE as b WHERE a.emp_no = b.emp_no AND a.to_date = b.max_to_date)
	)
SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM emp.employees as emp
INNER JOIN CTE_FILTER as deptEmp
ON emp.emp_no = deptEmp.emp_no
INNER JOIN emp.department as dept
ON deptEmp.Dept_no = dept.dept_no
ORDER BY emp_no
------------------------------------------------------------------------------
/*
	5 - LIST ALL EMPLOYEES WHOSE FIRST NAME IS HERCULES AND LAST NAMES BEGIN WITH B
*/
------------------------------------------------------------------------------
SELECT * 
FROM emp.employees as emp
WHERE emp.first_name = 'Hercules' AND emp.last_name LIKE 'B%'
------------------------------------------------------------------------------
/*
	6 - LIST ALL EMPLOYEES IN SALES DEPARTMENT, INCLUIDING THEIR EMPLOYEE NUMBER
		LAST NAME, FIRST NAME AND DEPARTMENT NAME.
*/
------------------------------------------------------------------------------
SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM emp.employees as emp
INNER JOIN emp.dept_emp as deptEmp
ON emp.emp_no = deptEmp.emp_no
INNER JOIN emp.department as dept
ON deptEmp.Dept_no = dept.dept_no
WHERE dept.dept_name = 'Sales'
ORDER BY emp_no
------------------------------------------------------------------------------
/*
	7 - LIST ALL EMPLOYEES IN SALES AND DEVELOPMENT DEPARTMENTS, INCLUIDING
	THER EMPLOYEE NUMBER, LAST NAME, FIRST NAME AND DEPARTMENT NAME
*/
------------------------------------------------------------------------------
SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM emp.employees as emp
INNER JOIN emp.dept_emp as deptEmp
ON emp.emp_no = deptEmp.emp_no
INNER JOIN emp.department as dept
ON deptEmp.Dept_no = dept.dept_no
WHERE dept.dept_name = 'Sales' OR dept.dept_name = 'Development'
ORDER BY emp_no
------------------------------------------------------------------------------
/*
	8 - IN DESCENDING ORDER, LIST THE FREQUENCY COUNT OF EMPLOYEE LAST NAMES,
	I.E, HOW MANY EMPLOYEES SHARE EACH LAST NAME
*/
------------------------------------------------------------------------------
SELECT emp.last_name, COUNT(*) as lastNameCount
FROM emp.employees as emp
GROUP BY emp.last_name
ORDER BY COUNT(*) DESC
------------------------------------------------------------------------------
/*
	9 - SEARCHING FOR MY EMPLOYEE NUMBER OUTPUTS APRILS FOOLSDAY =(
*/
------------------------------------------------------------------------------
SELECT * FROM emp.employees WHERE emp_no = '499942'






