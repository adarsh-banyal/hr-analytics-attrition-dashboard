-- Query 1: Overall Attrition Rate 

SELECT
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS EmployeesLeft,
    ROUND(
        100.0 *
        SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS AttritionRate
FROM hr_cleaned;

-- Query 2: Attrition by Department

SELECT
    Department,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS EmployeesLeft,
    ROUND(
        100.0 *
        SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS AttritionRate
FROM hr_cleaned
GROUP BY Department
ORDER BY AttritionRate DESC;

-- Query 3: Attrition by Job Role

SELECT
    JobRole,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS EmployeesLeft,
    ROUND(
        100.0 *
        SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS AttritionRate
FROM hr_cleaned
GROUP BY JobRole
ORDER BY AttritionRate DESC;

-- Query 4 Attrition by Demographic & Compensation Factors

-- 1. Attrition by Gender

SELECT
    Gender,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS EmployeesLeft,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS AttritionRate
FROM hr_cleaned
GROUP BY Gender;


-- 2. Attrition by Overtime

SELECT
    OverTime,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS EmployeesLeft,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS AttritionRate
FROM hr_cleaned
GROUP BY OverTime
ORDER BY AttritionRate DESC;


-- 3. Attrition by Income Group

SELECT
    Income_Group,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS EmployeesLeft,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS AttritionRate
FROM hr_cleaned
GROUP BY Income_Group
ORDER BY AttritionRate DESC;


-- 4. Attrition by Tenure Group

SELECT
    Tenure_Group,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS EmployeesLeft,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS AttritionRate
FROM hr_cleaned
GROUP BY Tenure_Group
ORDER BY AttritionRate DESC;


-- Query 5: Department Workforce Ranking

SELECT
    JobRole,
    COUNT(*) AS EmployeeCount,
    RANK() OVER (
        ORDER BY COUNT(*) DESC
    ) AS WorkforceRank
FROM hr_cleaned
GROUP BY JobRole;

-- Query 6: Top Attrition Roles

WITH RoleAttrition AS
(
    SELECT
        JobRole,
        COUNT(*) AS TotalEmployees,
        SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) AS EmployeesLeft
    FROM hr_cleaned
    GROUP BY JobRole
)

SELECT
    JobRole,
    TotalEmployees,
    EmployeesLeft,
    ROUND(
        100.0 * EmployeesLeft / TotalEmployees,
        2
    ) AS AttritionRate
FROM RoleAttrition
ORDER BY AttritionRate DESC;