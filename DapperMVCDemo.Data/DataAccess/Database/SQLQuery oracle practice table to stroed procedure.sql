--check more to explore
https://www.blackbox.ai/chat/jQygLkm

 CREATE TABLE DEPT
(
    DEPTNO INT CONSTRAINT PK_DEPT PRIMARY KEY,
    DNAME VARCHAR(14),
    LOC VARCHAR(13)
);

CREATE TABLE EMP
(
    EMPNO INT CONSTRAINT PK_EMP PRIMARY KEY,
    ENAME VARCHAR(10),
    JOB VARCHAR(9),
    MGR INT,
    HIREDATE DATE,
    SAL DECIMAL(7,2),
    COMM DECIMAL(7,2),
    DEPTNO INT CONSTRAINT FK_DEPTNO FOREIGN KEY REFERENCES DEPT(DEPTNO)
);

INSERT INTO DEPT VALUES
    (10, 'ACCOUNTING', 'NEW YORK'),
    (20, 'RESEARCH', 'DALLAS'),
    (30, 'SALES', 'CHICAGO'),
    (40, 'OPERATIONS', 'BOSTON');

INSERT INTO EMP VALUES
    (7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800.00, NULL, 20),
    (7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600.00, 300.00, 30),
    (7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250.00, 500.00, 30),
    (7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975.00, NULL, 20),
    (7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250.00, 1400.00, 30),
    (7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850.00, NULL, 30),
    (7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450.00, NULL, 10),
    (7788, 'SCOTT', 'ANALYST', 7566, '1987-07-13', 3000.00, NULL, 20),
    (7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000.00, NULL, 10),
    (7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500.00, 0.00, 30),
    (7876, 'ADAMS', 'CLERK', 7788, '1987-07-13', 1100.00, NULL, 20),
    (7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950.00, NULL, 30),
    (7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000.00, NULL, 20),
    (7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300.00, NULL, 10);

CREATE TABLE BONUS
(
    ENAME VARCHAR(10),
    JOB VARCHAR(9),
    SAL DECIMAL(7,2),
    COMM DECIMAL(7,2)
);

CREATE TABLE SALGRADE
(
    GRADE INT,
    LOSAL DECIMAL(7,2),
    HISAL DECIMAL(7,2)
);

INSERT INTO SALGRADE VALUES
    (1, 700.00, 1200.00),
    (2, 1201.00, 1400.00),
    (3, 1401.00, 2000.00),
    (4, 2001.00, 3000.00),
    (5, 3001.00, 9999.00);



	--Get all employees from the EMP table:

CREATE PROCEDURE GetAllEmployees
AS
SELECT * FROM EMP;
GO

--Get all departments from the DEPT table:
CREATE PROCEDURE GetAllDepartments
AS
SELECT * FROM DEPT;
GO

--Get the total number of employees in each department:
CREATE PROCEDURE GetEmployeeCountPerDept
AS
SELECT d.DEPTNO, d.DNAME, COUNT(e.EMPNO) AS EmployeeCount
FROM DEPT d
LEFT JOIN EMP e ON d.DEPTNO = e.DEPTNO
GROUP BY d.DEPTNO, d.DNAME;
GO


--Get the average salary of employees in each department:

CREATE PROCEDURE GetAvgSalaryPerDept
AS
SELECT d.DEPTNO, d.DNAME, AVG(e.SAL) AS AvgSalary
FROM DEPT d
LEFT JOIN EMP e ON d.DEPTNO = e.DEPTNO
GROUP BY d.DEPTNO, d.DNAME;
GO

--Get the minimum and maximum salaries in each department:

CREATE PROCEDURE GetMinMaxSalaryPerDept
AS
SELECT d.DEPTNO, d.DNAME, MIN(e.SAL) AS MinSalary, MAX(e.SAL) AS MaxSalary
FROM DEPT d
LEFT JOIN EMP e ON d.DEPTNO = e.DEPTNO
GROUP BY d.DEPTNO, d.DNAME;
GO


--Get the total salary paid to all employees in each department:
CREATE PROCEDURE GetTotalSalaryPerDept
AS
SELECT d.DEPTNO, d.DNAME, SUM(e.SAL) AS TotalSalary
FROM DEPT d
LEFT JOIN EMP e ON d.DEPTNO = e.DEPTNO
GROUP BY d.DEPTNO, d.DNAME;
GO

--Get the number of employees in each job category:

CREATE PROCEDURE GetEmployeeCountPerJob
AS
SELECT e.JOB, COUNT(e.EMPNO) AS EmployeeCount
FROM EMP e
GROUP BY e.JOB;
GO

--Get the average salary of employees in each job category:
CREATE PROCEDURE GetAvgSalaryPerJob
AS
SELECT e.JOB, AVG(e.SAL) AS AvgSalary
FROM EMP e
GROUP BY e.JOB;
GO

--Get the minimum and maximum salaries in each job category:

CREATE PROCEDURE GetMinMaxSalaryPerJob
AS
SELECT e.JOB, MIN(e.SAL) AS MinSalary, MAX(e.SAL) AS MaxSalary
FROM EMP e
GROUP BY e.JOB;
GO

--Get the total salary paid to all employees in each job category:

CREATE PROCEDURE GetTotalSalaryPerJob
AS
SELECT e.JOB, SUM(e.SAL) AS TotalSalary
FROM EMP e
GROUP BY e.JOB;
GO

--Get the number of employees who have a commission:

CREATE PROCEDURE GetEmployeeCountWithCommission
AS
SELECT COUNT(*) AS EmployeeCount
FROM EMP
WHERE COMM IS NOT NULL;
GO

--Get the total commission paid to all employees:
CREATE PROCEDURE GetTotalCommission
AS
SELECT SUM(COMM) AS TotalCommission
FROM EMP
WHERE COMM IS NOT NULL;
GO


--Get the average salary of employees who have a commission:
CREATE PROCEDURE GetAvgSalaryWithCommission
AS
SELECT AVG(SAL) AS AvgSalary
FROM EMP
WHERE COMM IS NOT NULL;
GO

 --calculates the average salary of employees in each department, grouped by their job category:
CREATE PROCEDURE GetAvgSalaryByDeptAndJob
AS
BEGIN
    SELECT 
        d.DNAME AS Department,
        e.JOB AS Job,
        AVG(e.SAL) AS AvgSalary
    FROM 
        DEPT d
    JOIN 
        EMP e ON d.DEPTNO = e.DEPTNO
    GROUP BY 
        d.DNAME, e.JOB;
END;

--You can execute this stored procedure using the following command:

EXEC GetAvgSalaryByDeptAndJob;


--elects the employee number, name, job, manager, hire date, salary, commission, and department name from the EMP and DEPT tables.
--Joins the EMP and DEPT tables on the DEPTNO column.
--Filters the results to only include employees in the specified department, with the specified job, and with a salary within the specified range.
--Orders the results by salary in descending order.

CREATE PROCEDURE GetEmployeeInfoByDeptAndJob
    @DeptNo int,
    @Job varchar(10),
    @MinSalary decimal(10, 2),
    @MaxSalary decimal(10, 2)
AS
BEGIN
    SELECT 
        e.EMPNO,
        e.ENAME,
        e.JOB,
        e.MGR,
        e.HIREDATE,
        e.SAL,
        e.COMM,
        d.DNAME AS Department
    FROM 
        EMP e
    JOIN 
        DEPT d ON e.DEPTNO = d.DEPTNO
    WHERE 
        e.DEPTNO = @DeptNo
        AND e.JOB = @Job
        AND e.SAL BETWEEN @MinSalary AND @MaxSalary
    ORDER BY 
        e.SAL DESC;
END;

--You can execute this stored procedure using the following command:
   
EXEC GetEmployeeInfoByDeptAndJob 10, 'MANAGER', 2000, 5000;


--Example 2: Get employees who report to a specific manager

CREATE PROCEDURE GetEmployeesByManager
    @ManagerEmpNo int
AS
BEGIN
    SELECT 
        e.EMPNO,
        e.ENAME,
        e.JOB,
        e.MGR,
        e.HIREDATE,
        e.SAL,
        e.COMM,
        d.DNAME AS Department
    FROM 
        EMP e
    JOIN 
        DEPT d ON e.DEPTNO = d.DEPTNO
    WHERE 
        e.MGR = @ManagerEmpNo;
END;

--Example 3: Get departments with a certain number of employees

CREATE PROCEDURE GetDepartmentsByEmployeeCount
    @MinEmployeeCount int,
    @MaxEmployeeCount int
AS
BEGIN
    SELECT 
        d.DEPTNO,
        d.DNAME,
        COUNT(e.EMPNO) AS EmployeeCount
    FROM 
        DEPT d
    LEFT JOIN 
        EMP e ON d.DEPTNO = e.DEPTNO
    GROUP BY 
        d.DEPTNO, d.DNAME
    HAVING 
        COUNT(e.EMPNO) BETWEEN @MinEmployeeCount AND @MaxEmployeeCount;
END;

--Example 4: Get employees who have a certain number of years of experience

CREATE PROCEDURE GetEmployeesByExperience
    @MinYearsExperience int,
    @MaxYearsExperience int
AS
BEGIN
    SELECT 
        e.EMPNO,
        e.ENAME,
        e.JOB,
        e.MGR,
        e.HIREDATE,
        e.SAL,
        e.COMM,
        d.DNAME AS Department,
        DATEDIFF(YEAR, e.HIREDATE, GETDATE()) AS YearsExperience
    FROM 
        EMP e
    JOIN 
        DEPT d ON e.DEPTNO = d.DEPTNO
    WHERE 
        DATEDIFF(YEAR, e.HIREDATE, GETDATE()) BETWEEN @MinYearsExperience AND @MaxYearsExperience;
END;

--another
CREATE PROCEDURE sp_Get_EmployeeInfoByDeptAndJob
    @DeptNo int,
    @Job varchar(10),
    @MinSalary decimal(10, 2),
    @MaxSalary decimal(10, 2),
    @Loc varchar(13),
    @Grade int,
    @EmpNo int
AS
BEGIN
    SELECT 
        e.EMPNO,
        e.ENAME,
        e.JOB,
        e.MGR,
        e.HIREDATE,
        e.SAL,
        e.COMM,
        d.DNAME AS Department,
        s.GRADE
    FROM 
        EMP e
    JOIN 
        DEPT d ON e.DEPTNO = d.DEPTNO
    JOIN 
        SALGRADE s ON e.SAL BETWEEN s.LOSAL AND s.HISAL
    WHERE 
        e.DEPTNO = @DeptNo
        AND e.JOB = @Job
        AND e.SAL BETWEEN @MinSalary AND @MaxSalary
        AND d.LOC = @Loc
        AND s.GRADE IN (@Grade)
        AND e.EMPNO = @EmpNo;
END;


--To execute this stored procedure, you can use the following code:

EXEC sp_Get_EmployeeInfoByDeptAndJob 20, 'SALESMAN', 1201, 1400, 'DALLAS', 3, 7499;
