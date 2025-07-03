-- Joiners
SELECT 
substr(StartDate, 8, 2) || ' - ' || substr(StartDate, 4,3) ||'-' ||'20'|| substr(StartDate, -2) AS Parsed_StartDate,
substr(StartDate, 4,3) || '-20'|| substr(StartDate, -2) AS StartMonth,
count(*) AS Joiners
FROM employee_data
Group by StartMonth
Order BY StartMonth;

-- Gender Ratio
SELECT 
GenderCode,
count(*) as Gender_Count
FROM employee_data
WHERE ExitDate IS NULL 
Group by GenderCode;

-- Department-Wise Headcount
SELECT
DepartmentType, 
count(*) as Headcount
FROM employee_data
WHERE ExitDate is NULL
group by DepartmentType
Order by Headcount DESC;

-- Attrition Rate 
-- Approx Headcount month wise
SELECT 
substr(StartDate,4,3) || '-20' || substr(StartDate, -2) AS Month,
count(*) AS Headcount
FROM employee_data
WHERE ExitDate is null OR substr(ExitDate, 4,3) || '-20' || substr(ExitDate, -2) >= substr(StartDate, 4,3)|| '-20'|| substr(StartDate, -2)
Group by Month;

-- Monthly Leavers
WITH Monthly_Leavers AS (
    SELECT
        substr(ExitDate, 4,3) || '-20' || substr(ExitDate, -2) AS Month,
        COUNT(*) AS Leavers
    FROM employee_data
    WHERE ExitDate IS NOT NULL
    GROUP BY Month
),

-- Monthly Approximate Headcount
Monthly_Headcount AS (
    SELECT 
        substr(StartDate,4,3) || '-20' || substr(StartDate, -2) AS Month,
        COUNT(*) AS Headcount
    FROM employee_data
    WHERE ExitDate IS NULL 
       OR substr(ExitDate, 4,3) || '-20' || substr(ExitDate, -2) >= substr(StartDate, 4,3)|| '-20'|| substr(StartDate, -2)
    GROUP BY Month
)

-- Final Select to Calculate Attrition
SELECT
    L.Month,
    L.Leavers,
    H.Headcount,
    ROUND(CAST(L.Leavers AS REAL) * 100.0 / H.Headcount, 2) AS Attrition_Rate
FROM Monthly_Leavers L
JOIN Monthly_Headcount H ON L.Month = H.Month
ORDER BY L.Month;

-- TOP 5 Departments by Attrition
SELECT
DepartmentType,
count(*) AS LEAVERS
FROM employee_data
WHERE ExitDate IS NOT NULL 
GROUP BY DepartmentType
ORDER BY Leavers DESC
LIMIT 5;

-- Turnover Rate
WITH Monthly_Leavers AS (
    SELECT
        substr(ExitDate, 4,3) || '-20' || substr(ExitDate, -2) AS Month,
        COUNT(*) AS Leavers
    FROM employee_data
    WHERE ExitDate IS NOT NULL
    GROUP BY Month
),
Monthly_Headcount AS (
    SELECT 
        substr(StartDate,4,3) || '-20' || substr(StartDate, -2) AS Month,
        COUNT(*) AS Headcount
    FROM employee_data
    WHERE ExitDate IS NULL 
       OR substr(ExitDate, 4,3) || '-20' || substr(ExitDate, -2) >= substr(StartDate, 4,3)|| '-20'|| substr(StartDate, -2)
    GROUP BY Month
)
SELECT 
L.Month, 
L.Leavers,
H.Headcount,
round(CAST(L.LEAVERS AS REAL)*100.0/H.Headcount,2) as Turnover_Rate
FROM Monthly_Leavers L
JOIN Monthly_Headcount H ON L.Month = H.Month
order by L.Month;

--Tenure
SELECT 
    DepartmentType,
    ROUND(AVG(
        CASE 
            WHEN ExitDate IS NOT NULL THEN 
                JULIANDAY('20' || substr(ExitDate, -2) || '-' || 
                          CASE substr(ExitDate, 4, 3)
                              WHEN 'Jan' THEN '01'
                              WHEN 'Feb' THEN '02'
                              WHEN 'Mar' THEN '03'
                              WHEN 'Apr' THEN '04'
                              WHEN 'May' THEN '05'
                              WHEN 'Jun' THEN '06'
                              WHEN 'Jul' THEN '07'
                              WHEN 'Aug' THEN '08'
                              WHEN 'Sep' THEN '09'
                              WHEN 'Oct' THEN '10'
                              WHEN 'Nov' THEN '11'
                              WHEN 'Dec' THEN '12'
                          END || '-' || substr(ExitDate, 1, 2))
             - 
             JULIANDAY('20' || substr(StartDate, -2) || '-' || 
                          CASE substr(StartDate, 4, 3)
                              WHEN 'Jan' THEN '01'
                              WHEN 'Feb' THEN '02'
                              WHEN 'Mar' THEN '03'
                              WHEN 'Apr' THEN '04'
                              WHEN 'May' THEN '05'
                              WHEN 'Jun' THEN '06'
                              WHEN 'Jul' THEN '07'
                              WHEN 'Aug' THEN '08'
                              WHEN 'Sep' THEN '09'
                              WHEN 'Oct' THEN '10'
                              WHEN 'Nov' THEN '11'
                              WHEN 'Dec' THEN '12'
                          END || '-' || substr(StartDate, 1, 2))
            ELSE 
                JULIANDAY('now') - 
                JULIANDAY('20' || substr(StartDate, -2) || '-' || 
                          CASE substr(StartDate, 4, 3)
                              WHEN 'Jan' THEN '01'
                              WHEN 'Feb' THEN '02'
                              WHEN 'Mar' THEN '03'
                              WHEN 'Apr' THEN '04'
                              WHEN 'May' THEN '05'
                              WHEN 'Jun' THEN '06'
                              WHEN 'Jul' THEN '07'
                              WHEN 'Aug' THEN '08'
                              WHEN 'Sep' THEN '09'
                              WHEN 'Oct' THEN '10'
                              WHEN 'Nov' THEN '11'
                              WHEN 'Dec' THEN '12'
                          END || '-' || substr(StartDate, 1, 2))
        END
    ), 0) AS Avg_Tenure_Days
FROM employee_data
GROUP BY DepartmentType
ORDER BY Avg_Tenure_Days DESC;

--Net Growth
WITH Joiners AS (
    SELECT 
        substr(StartDate, 4, 3) || '-20' || substr(StartDate, -2) AS Month,
        COUNT(*) AS Joiners
    FROM employee_data
    GROUP BY Month
),
Leavers AS (
    SELECT 
        substr(ExitDate, 4, 3) || '-20' || substr(ExitDate, -2) AS Month,
        COUNT(*) AS Leavers
    FROM employee_data
    WHERE ExitDate IS NOT NULL
    GROUP BY Month
)

-- First half: Joiners LEFT JOIN Leavers
SELECT 
    J.Month AS Month,
    J.Joiners AS Joiners,
    COALESCE(L.Leavers, 0) AS Leavers,
    J.Joiners - COALESCE(L.Leavers, 0) AS Net_Growth
FROM Joiners J
LEFT JOIN Leavers L ON J.Month = L.Month

UNION

-- Second half: Leavers LEFT JOIN Joiners (where no matching joiners exist)
SELECT 
    L.Month AS Month,
    COALESCE(J.Joiners, 0) AS Joiners,
    L.Leavers AS Leavers,
    COALESCE(J.Joiners, 0) - L.Leavers AS Net_Growth
FROM Leavers L
LEFT JOIN Joiners J ON J.Month = L.Month
WHERE J.Month IS NULL

ORDER BY Month;