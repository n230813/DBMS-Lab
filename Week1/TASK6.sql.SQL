USE taxation_db;
-- TASK1
-- task1
SELECT*
FROM income_record
WHERE amount=(
SELECT MAX(amount)
FROM income_record
);
-- task2
SELECT*
FROM income_record
WHERE amount=(
SELECT MIN(amount)
FROM income_record
);
-- TASK3
SELECT*
FROM income_record
WHERE amount >(
SELECT AVG(amount)
FROM income_record
);
-- task4
SELECT*
FROM income_record
WHERE amount =(
SELECT MAX(amount)
FROM income_record
);
-- TASK 5
SELECT*
FROM taxpayer_
WHERE taxpayer_id IN(
SELECT taxpayer_id
FROM taxpayer_
WHERE occupation='Business owner');
-- level2
-- task1
SELECT*
FROM taxpayer_
WHERE taxpayer_id IN (
SELECT taxpayer_id
FROM income_record
);
-- task2
DESC income_record;
SELECT*
FROM taxpayer_
WHERE taxpayer_id IN (
SELECT taxpayer_id
FROM income_record
WHERE category_name='Business');
-- task3
SELECT*
FROM income_record
WHERE financial_year IN(
SELECT year_label
FROM financial_year
WHERE year_label='2025-2026'
);
-- task 4
SELECT *
FROM Income_Record
WHERE amount > (
    SELECT MIN(amount)
    FROM Income_Record
    WHERE category_name = 'Business'
);
-- TASK 5
SELECT *
FROM Income_Record
WHERE amount < (
    SELECT MAX(amount)
    FROM Income_Record
    WHERE category_name = 'Salary'
);
-- TASK 6
SELECT *
FROM Taxpayer_
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE amount > (
        SELECT AVG(amount)
        FROM Income_Record
    )
);
-- TASK 7
SELECT *
FROM Income_Category
WHERE category_name IN (
    SELECT category_name
    FROM Income_Record
);
-- TASK 8
SELECT *
FROM Taxpayer_
WHERE taxpayer_id NOT IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_name = 'Investment'
);
-- level 3
-- TASK 1
SELECT *
FROM Taxpayer_
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE amount = (
        SELECT MAX(amount)
        FROM Income_Record
    )
);
-- TASK 2
SELECT *
FROM Income_Record
WHERE amount > (
    SELECT AVG(amount)
    FROM Income_Record
    WHERE category_name = 'Business'
);
-- TASK 3
SELECT *
FROM Taxpayer_
WHERE annual_income > (
    SELECT AVG(annual_income)
    FROM Taxpayer_
);
-- TASK 4
SELECT *
FROM Income_Record
WHERE amount > ANY (
    SELECT amount
    FROM Income_Record
    WHERE category_name = 'Investment'
);
-- TASK 5
SELECT *
FROM Income_Record
WHERE amount > ALL (
    SELECT amount
    FROM Income_Record
    WHERE category_name = 'Investment'
);
-- TASK 6
SELECT *
FROM Income_Category
WHERE category_name IN (
    SELECT category_name
    FROM Income_Record
    WHERE amount = (
        SELECT MAX(amount)
        FROM Income_Record
    )
);
-- TASK 7
SELECT *
FROM Financial_Year
WHERE year_label IN (
    SELECT financial_year
    FROM Income_Record
    GROUP BY financial_year
    HAVING SUM(amount) = (
        SELECT MAX(total_income)
        FROM (
            SELECT SUM(amount) AS total_income
            FROM Income_Record
            GROUP BY financial_year
        ) AS yearly_income
    )
);
-- TASK 8
SELECT *
FROM Taxpayer_
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    GROUP BY taxpayer_id
    HAVING SUM(amount) > (
        SELECT AVG(total_income)
        FROM (
            SELECT SUM(amount) AS total_income
            FROM Income_Record
            GROUP BY taxpayer_id
        ) AS taxpayer_income
    )
);
-- REAL-WORLD TAXATION ANALYSIS
-- TASK 1
SELECT *
FROM Taxpayer_
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE amount = (
        SELECT MAX(amount)
        FROM Income_Record
    )
);


-- TASK 2
SELECT *
FROM Taxpayer_
WHERE annual_income > (
    SELECT AVG(annual_income)
    FROM Taxpayer_
);
-- TASK 3
SELECT *
FROM Income_Category
WHERE category_name IN (
    SELECT category_name
    FROM Income_Record
    WHERE amount = (
        SELECT MAX(amount)
        FROM Income_Record
    )
);


-- TASK 4
SELECT *
FROM Taxpayer_
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_name = 'Business'
)
AND taxpayer_id NOT IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_name = 'Investment'
);


-- TASK 5
SELECT *
FROM Income_Record
WHERE amount > ALL (
    SELECT amount
    FROM Income_Record
    WHERE category_name = 'Investment'
);


-- TASK 6
SELECT *
FROM Income_Record
WHERE amount > ANY (
    SELECT amount
    FROM Income_Record
    WHERE category_name = 'Investment'
);


-- TASK 7
SELECT *
FROM Taxpayer_
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    GROUP BY taxpayer_id
    HAVING SUM(amount) = (
        SELECT MAX(total_income)
        FROM (
            SELECT SUM(amount) AS total_income
            FROM Income_Record
            GROUP BY taxpayer_id
        ) AS taxpayer_totals
    )
);


-- TASK 8

SELECT ir.*
FROM Income_Record ir
JOIN (
    SELECT category_name, AVG(amount) AS average_income
    FROM Income_Record
    GROUP BY category_name
) AS category_avg
ON ir.category_name = category_avg.category_name
WHERE ir.amount > category_avg.average_income;
DESC financial_year;
DESC income_record;
ALTER TABLE income_record
ADD COLUMN financial_year VARCHAR(9);
UPDATE income_record
SET financial_year='2025-2026';
