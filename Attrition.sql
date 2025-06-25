-- Attrition Analysis Using SQL

-- Overall Attrition Rate

SELECT 
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS AttritionRate
FROM [Employee Attrition_Details];


-- Attrition By Gender

SELECT 
    COALESCE(d.Gender,'Male'),
    COUNT(*) AS TotalEmployees,
    COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS AttritionRate
FROM [Employee Attrition_Details] a
JOIN [Demographic information ] d 
ON a.EmployeeNumber = d.EmployeeNumber
GROUP BY COALESCE(d.Gender,'Male');

-- Attrition By Department

SELECT 
    j.Department,
    COUNT(*) AS TotalEmployees,
    COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS AttritionRate
FROM [Employee Attrition_Details] a
JOIN [Employee Job Info] j 
ON a.EmployeeNumber = j.EmployeeNumber
GROUP BY j.Department;

-- Average Years At Company By Attrition Status

SELECT 
    a.Attrition,
    ROUND(AVG(j.YearsAtCompany), 2) AS AvgYearsAtCompany
FROM [Employee Attrition_Details] a
JOIN [Employee Job Info] j 
ON a.EmployeeNumber = j.EmployeeNumber
GROUP BY a.Attrition;


-- Average Monthly Salary By Job Role

SELECT 
	COALESCE(NULLIF(JobRole, ' '), 'Unkown') JobRole,
	ROUND(AVG(MonthlySalary), 2) AS AvgMonthlySalary
FROM [Employee Job Info] 
GROUP BY COALESCE(NULLIF(JobRole, ' '), 'Unkown');

-- Attrition vs. OverTime

SELECT 
    j.OverTime,
    COUNT(*) AS TotalEmployees,
    COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS AttritionRate
FROM [Employee Attrition_Details] a
JOIN [Employee Job Info] j
    ON a.EmployeeNumber = j.EmployeeNumber
WHERE  j.OverTime != ' '
GROUP BY j.OverTime;

-- Job Satisfaction vs. Attrition

SELECT 
    js.JobSatisfaction,
    COUNT(*) AS TotalEmployees,
    COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS AttritionRate
FROM [Employee Attrition_Details] a
JOIN [Emp_Satisfaction_Survey_Info] js 
ON a.EmployeeNumber = js.EmployeeNumber
GROUP BY js.JobSatisfaction;

-- Attrition by Education Field

SELECT 
    COALESCE(di.EducationField, 'UNKNOWN'),
    COUNT(*) AS TotalEmployees,
    COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS AttritionRate
FROM [Employee Attrition_Details] a
JOIN [Demographic information ] di 
ON a.EmployeeNumber = di.EmployeeNumber
GROUP BY COALESCE(di.EducationField, 'UNKNOWN');

-- Training Times vs Attrition

SELECT 
    j.TrainingTimesLastYear,
    COUNT(*) AS TotalEmployees,
    COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS AttritionRate
FROM [Employee Attrition_Details] a
JOIN [Employee Job Info] j
ON a.EmployeeNumber = j.EmployeeNumber
GROUP BY j.TrainingTimesLastYear
ORDER BY j.TrainingTimesLastYear ;

-- Business Travel and Attrition

SELECT 
    j.BusinessTravel,
    COUNT(*) AS TotalEmployees,
    COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS AttritionRate
FROM [Employee Attrition_Details] a
JOIN [Employee Job Info] j 
ON a.EmployeeNumber = j.EmployeeNumber
GROUP BY j.BusinessTravel
ORDER BY AttritionRate DESC;

-- Top 5 Job Roles with Highest Attrition Rate (with minimum 10 employees)

SELECT 
    j.JobRole,
    COUNT(*) AS TotalEmployees,
    COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    ROUND(COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM [Employee Attrition_Details] a
JOIN [Employee Job Info] j ON a.EmployeeNumber = j.EmployeeNumber
GROUP BY j.JobRole
HAVING COUNT(*) >= 10
ORDER BY AttritionRate DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- Average Monthly Salary vs Attrition by Department

SELECT 
    j.Department,
    a.Attrition,
    ROUND(AVG(j.MonthlySalary), 2) AS AvgSalary,
    COUNT(*) AS NumEmployees
FROM [Employee Attrition_Details] a
JOIN [Employee Job Info] j 
ON a.EmployeeNumber = j.EmployeeNumber
GROUP BY j.Department, a.Attrition
ORDER BY j.Department;

-- Top Performing Employees Who Left (Performance Rating = 4 and Attrition = Yes and Years at comapny >10)

SELECT 
    d.EmployeeNumber,
    d.Gender,
    j.JobRole,
    j.MonthlySalary,
    j.PerformanceRating,
    j.YearsAtCompany
FROM [Employee Attrition_Details] a
JOIN [Demographic information ] d 
ON a.EmployeeNumber = d.EmployeeNumber
JOIN [Employee Job Info] j ON a.EmployeeNumber = j.EmployeeNumber
WHERE a.Attrition = 'Yes' AND j.PerformanceRating = 'Outstanding' AND j.YearsAtCompany >10
ORDER BY j.MonthlySalary DESC;

-- Attrition by Manager Relationship Satisfaction

SELECT 
    s.Manager_RelationshipSatisfaction ,
	COUNT(*) AS TotalEmployees,
    COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    ROUND(COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM [Employee Attrition_Details] a
JOIN [Emp_Satisfaction_Survey_Info] s 
ON a.EmployeeNumber = s.EmployeeNumber
GROUP BY s.Manager_RelationshipSatisfaction
ORDER BY AttritionRate DESC;

---- Attrition by  Work-Life Balance

SELECT 
    s.WorkLifeBalance ,
	COUNT(*) AS TotalEmployees,
    COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    ROUND(COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM [Employee Attrition_Details] a
JOIN [Emp_Satisfaction_Survey_Info] s 
ON a.EmployeeNumber = s.EmployeeNumber
GROUP BY s.WorkLifeBalance
ORDER BY AttritionRate DESC;


-- Attrition by Years Since Last Promotion (Binned)

SELECT 
    CASE 
        WHEN j.YearsSinceLastPromotion = 0 THEN '0'
        WHEN j.YearsSinceLastPromotion BETWEEN 1 AND 2 THEN '1-2'
        WHEN j.YearsSinceLastPromotion BETWEEN 3 AND 5 THEN '3-5'
        ELSE '6+' 
    END AS YearsSinceLastPromotion,
    COUNT(*) AS TotalEmployees,
    COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    ROUND(COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM [Employee Attrition_Details] a
JOIN [Employee Job Info] j ON a.EmployeeNumber = j.EmployeeNumber
GROUP BY 
    CASE 
        WHEN j.YearsSinceLastPromotion = 0 THEN '0'
        WHEN j.YearsSinceLastPromotion BETWEEN 1 AND 2 THEN '1-2'
        WHEN j.YearsSinceLastPromotion BETWEEN 3 AND 5 THEN '3-5'
        ELSE '6+' 
    END
ORDER BY AttritionRate DESC;

-- Attrition by Age Group and Job Involvement

SELECT 
    CASE 
        WHEN d.Age < 30 THEN '<30'
        WHEN d.Age BETWEEN 30 AND 40 THEN '30-40'
        WHEN d.Age BETWEEN 41 AND 50 THEN '41-50'
        ELSE '51+' 
    END AS AgeGroup,
    COUNT(*) AS TotalEmployees,
    COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    ROUND(COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM [Employee Attrition_Details] a
JOIN [Demographic information] d ON a.EmployeeNumber = d.EmployeeNumber
GROUP BY 
    CASE 
        WHEN d.Age < 30 THEN '<30'
        WHEN d.Age BETWEEN 30 AND 40 THEN '30-40'
        WHEN d.Age BETWEEN 41 AND 50 THEN '41-50'
        ELSE '51+' 
    END
ORDER BY AttritionRate DESC;

-- Attrition by Job Involvement

SELECT 
	s.JobInvolvement,
    COUNT(*) AS TotalEmployees,
    COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    ROUND(COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM [Employee Attrition_Details] a
JOIN [Emp_Satisfaction_Survey_Info] s 
ON a.EmployeeNumber = s.EmployeeNumber
GROUP BY s.JobInvolvement   
ORDER BY AttritionRate DESC;

-- Job Satisfaction vs Environment Satisfaction (High-Risk Employees Only)

SELECT 
    s.JobSatisfaction,
    s.EnvironmentSatisfaction,
    COUNT(*) AS HighRiskEmployeeCount
FROM [Employee Attrition_Details] a
JOIN [Emp_Satisfaction_Survey_info] s ON a.EmployeeNumber = s.EmployeeNumber
WHERE a.Attrition = 'Yes'
GROUP BY s.JobSatisfaction, s.EnvironmentSatisfaction
ORDER BY HighRiskEmployeeCount DESC;

-- Attrition by Marital Status and OverTime

SELECT 
    d.MaritalStatus,
    j.OverTime,
    COUNT(*) AS TotalEmployees,
    COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    ROUND(COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM [Employee Attrition_Details] a
JOIN [Employee Job Info] j ON a.EmployeeNumber = j.EmployeeNumber
JOIN [Demographic information] d ON a.EmployeeNumber = d.EmployeeNumber
WHERE MaritalStatus IS NOT NULL
GROUP BY d.MaritalStatus, j.OverTime
ORDER BY AttritionRate DESC;

-- Education Level and Performance Rating vs. Attrition

SELECT 
    d.Education,
    COUNT(*) AS TotalEmployees,
    COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    ROUND(COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM [Employee Attrition_Details] a
JOIN [Demographic information] d ON a.EmployeeNumber = d.EmployeeNumber
WHERE Education IS NOT NULL
GROUP BY d.Education
ORDER BY AttritionRate DESC;

-- Job Involvement and Manager Relationship Satisfaction Impact on Attrition

 SELECT 
    s.JobInvolvement,
    s.Manager_RelationshipSatisfaction,
    COUNT(*) AS TotalEmployees,
    COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    ROUND(COUNT(CASE WHEN a.Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM [Employee Attrition_Details] a
JOIN [Emp_Satisfaction_Survey_info] s ON a.EmployeeNumber = s.EmployeeNumber
GROUP BY s.JobInvolvement, s.Manager_RelationshipSatisfaction
ORDER BY AttritionRate DESC;















