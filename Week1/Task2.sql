USE taxation_db;
-- 1. REMOVE OLD COLUMNS

ALTER TABLE Income_record
DROP COLUMN category_name;

ALTER TABLE Income_Record
DROP COLUMN financial_year;


-- 2. ADD NEW COLUMNS

ALTER TABLE Income_Record
ADD COLUMN category_id INT NOT NULL;

ALTER TABLE Income_Record
ADD COLUMN year_id INT NOT NULL;


-- 3. UPDATE EXISTING RECORDS WITH CATEGORY IDs

UPDATE Income_Record
SET category_id = 1
WHERE income_id IN (1001, 1002, 1004);

UPDATE Income_Record
SET category_id = 2
WHERE income_id IN (1003, 1005, 1006);


-- 4. UPDATE EXISTING RECORDS WITH FINANCIAL YEAR ID

UPDATE Income_Record
SET year_id = 6
WHERE income_id IN (1001, 1002, 1003, 1004, 1005, 1006);


-- 5. ADD FOREIGN KEY FOR TAXPAYER

ALTER TABLE Income_Record
ADD CONSTRAINT fk_income_taxpayer
FOREIGN KEY (taxpayer_id)
REFERENCES Taxpayer_(taxpayer_id);


-- 6. ADD FOREIGN KEY FOR INCOME CATEGORY

ALTER TABLE Income_Record
ADD CONSTRAINT fk_income_category
FOREIGN KEY (category_id)
REFERENCES Income_Category(category_id);


-- 7. ADD FOREIGN KEY FOR FINANCIAL YEAR

ALTER TABLE Income_Record
ADD CONSTRAINT fk_income_year
FOREIGN KEY (year_id)
REFERENCES Financial_Year(year_id);


-- 8. VIEW UPDATED INCOME_RECORD TABLE

SELECT * FROM Income_Record;
-- TASK 1
-- TRY INSERTING taxpayer_id = 999
-- Expected: ERROR because taxpayer 999 does not exist.

-- INSERT INTO Income_Record
-- (income_id, taxpayer_id, income_source, amount,
--  received_date, category_id, year_id)
-- VALUES
-- (1015, 999, 'Test Company', 500000.00,
--  '2026-03-31', 1, 6);


-- TASK 2
-- TRY INSERTING category_id = 20
-- Expected: ERROR because category 20 does not exist.

-- INSERT INTO Income_Record
-- (income_id, taxpayer_id, income_source, amount,
--  received_date, category_id, year_id)
-- VALUES
-- (1016, 101, 'Test Company', 500000.00,
--  '2026-03-31', 20, 6);


-- TASK 3
-- TRY INSERTING year_id = 15
-- Expected: ERROR because financial year 15 does not exist.

-- INSERT INTO Income_Record
-- (income_id, taxpayer_id, income_source, amount,
--  received_date, category_id, year_id)
-- VALUES
-- (1017, 101, 'Test Company', 500000.00,
--  '2026-03-31', 1, 15);


-- TASK 4
-- TRY DELETING A TAXPAYER WHOSE RECORD EXISTS
-- Expected: ERROR because of Foreign Key constraint.

-- DELETE FROM Taxpayer
-- WHERE taxpayer_id = 101;


-- TASK 5
-- TRY DELETING AN INCOME CATEGORY CURRENTLY IN USE
-- Expected: ERROR because of Foreign Key constraint.

-- DELETE FROM Income_Category
-- WHERE category_id = 1;


-- TASK 6
-- FOREIGN KEY:
-- A Foreign Key is a column that refers to the Primary Key
-- of another table.

-- REFERENTIAL INTEGRITY:
-- Referential Integrity ensures that a Foreign Key value
-- must match an existing value in the referenced table.

-- WHY FOREIGN KEYS ARE REQUIRED:
-- Foreign Keys maintain relationships between tables,
-- prevent invalid data and maintain data consistency.

-- TASK 1
-- DISPLAY ALL UNIQUE OCCUPATIONS

SELECT DISTINCT occupation
FROM Taxpayer_;


-- TASK 2
-- DISPLAY ALL UNIQUE INCOME CATEGORIES

SELECT DISTINCT category_name
FROM Income_Category;


-- TASK 3
-- DISPLAY ALL UNIQUE FINANCIAL YEARS

SELECT DISTINCT year_label
FROM Financial_Year;


-- TASK 4
-- DISPLAY ALL UNIQUE INCOME SOURCES

SELECT DISTINCT income_source
FROM Income_Record;




-- TASK 1
-- TAXPAYERS WHO HAVE EITHER SALARY OR BUSINESS INCOME

SELECT DISTINCT t.full_name
FROM Taxpayer_ t
JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
JOIN Income_Category c
ON i.category_id = c.category_id
WHERE c.category_name = 'Salary'

UNION

SELECT DISTINCT t.full_name
FROM Taxpayer_ t
JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
JOIN Income_Category c
ON i.category_id = c.category_id
WHERE c.category_name = 'Business';


-- TASK 2
-- DISPLAY INCOME SOURCES FROM 2024-2025
-- UNION 2025-2026

SELECT DISTINCT i.income_source
FROM Income_Record i
JOIN Financial_Year f
ON i.year_id = f.year_id
WHERE f.year_label = '2024-2025'

UNION

SELECT DISTINCT i.income_source
FROM Income_Record i
JOIN Financial_Year f
ON i.year_id = f.year_id
WHERE f.year_label = '2025-2026';


-- TASK 3
-- DISPLAY TAXPAYERS WHO ARE TEACHERS
-- UNION SOFTWARE ENGINEERS

SELECT full_name
FROM Taxpayer_
WHERE occupation = 'Teacher'

UNION

SELECT full_name
FROM Taxpayer_
WHERE occupation = 'Software Engineer';



-- ============================================================
-- PART E: INTERSECT
-- ============================================================

-- TASK 1
-- FIND TAXPAYERS WHO HAVE BOTH SALARY AND BUSINESS INCOME

SELECT t.full_name
FROM Taxpayer_ t
JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
JOIN Income_Category c
ON i.category_id = c.category_id
WHERE c.category_name = 'Salary'
INTERSECT
SELECT DISTINCT t.full_name
FROM Taxpayer_ t
JOIN Income_Record i ON t.taxpayer_id = i.taxpayer_id
JOIN Income_Category c ON i.category_id = c.category_id
WHERE c.category_name = 'Salary'
AND t.taxpayer_id IN (
    SELECT i.taxpayer_id
    FROM Income_Record i
    JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Business'
);




-- TASK 2
-- FIND TAXPAYERS WHO HAVE RECORDS IN BOTH
-- 2024-2025 AND 2025-2026

SELECT t.full_name
FROM Taxpayer_ t
JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
JOIN Financial_Year f
ON i.year_id = f.year_id
WHERE f.year_label = '2024-2025'

INTERSECT

SELECT t.full_name
FROM Taxpayer_ t
JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
JOIN Financial_Year f
ON i.year_id = f.year_id
WHERE f.year_label = '2025-2026';



-- ============================================================
-- PART F: EXCEPT (MINUS)
-- ============================================================

-- TASK 1
-- TAXPAYERS WHO HAVE SALARY INCOME
-- BUT DO NOT HAVE BUSINESS INCOME

SELECT t.full_name
FROM Taxpayer_ t
JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
JOIN Income_Category c
ON i.category_id = c.category_id
WHERE c.category_name = 'Salary'

EXCEPT

SELECT t.full_name
FROM Taxpayer_ t
JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
JOIN Income_Category c
ON i.category_id = c.category_id
WHERE c.category_name = 'Business';


-- TASK 2
-- TAXPAYERS WHO HAVE RECORDS IN 2025-2026
-- BUT NOT IN 2024-2025

SELECT t.full_name
FROM Taxpayer_ t
JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
JOIN Financial_Year f
ON i.year_id = f.year_id
WHERE f.year_label = '2025-2026'

EXCEPT

SELECT t.full_name
FROM Taxpayer_ t
JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
JOIN Financial_Year f
ON i.year_id = f.year_id
WHERE f.year_label = '2024-2025';



-- ============================================================
-- PART G: NESTED QUERIES USING IN
-- ============================================================

-- TASK 1
-- DISPLAY TAXPAYERS WHO HAVE SUBMITTED AT LEAST ONE
-- INCOME RECORD

SELECT full_name
FROM Taxpayer_
WHERE taxpayer_id IN
(
    SELECT taxpayer_id
    FROM Income_Record
);


-- TASK 2
-- DISPLAY TAXPAYERS WHOSE OCCUPATION IS PRESENT
-- AMONG TAXPAYERS EARNING BUSINESS INCOME

SELECT full_name, occupation
FROM Taxpayer_
WHERE occupation IN
(
    SELECT t.occupation
    FROM Taxpayer_ t
    JOIN Income_Record i
    ON t.taxpayer_id = i.taxpayer_id
    JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Business'
);



-- ============================================================
-- PART H: NESTED QUERIES USING NOT IN
-- ============================================================

-- TASK 1
-- DISPLAY TAXPAYERS WHO HAVE NOT SUBMITTED ANY
-- INCOME RECORDS

SELECT full_name
FROM Taxpayer_
WHERE taxpayer_id NOT IN
(
    SELECT taxpayer_id
    FROM Income_Record
);


-- TASK 2
-- DISPLAY OCCUPATIONS THAT ARE NOT PRESENT
-- IN ANY INCOME RECORD

SELECT DISTINCT occupation
FROM Taxpayer_
WHERE occupation NOT IN
(
    SELECT DISTINCT t.occupation
    FROM Taxpayer_ t
    JOIN Income_Record i
    ON t.taxpayer_id = i.taxpayer_id
);



-- ============================================================
-- PART I: EXISTS
-- ============================================================

-- TASK 1
-- DISPLAY TAXPAYERS FOR WHOM AT LEAST ONE
-- INCOME RECORD EXISTS

SELECT t.full_name
FROM Taxpayer_ t
WHERE EXISTS
(
    SELECT 1
    FROM Income_Record i
    WHERE i.taxpayer_id = t.taxpayer_id
);


-- TASK 2
-- DISPLAY FINANCIAL YEARS THAT HAVE AT LEAST ONE
-- INCOME RECORD

SELECT f.year_label
FROM Financial_Year f
WHERE EXISTS
(
    SELECT 1
    FROM Income_Record i
    WHERE i.year_id = f.year_id
);



-- ============================================================
-- PART J: NOT EXISTS
-- ============================================================

-- TASK 1
-- DISPLAY TAXPAYERS WHO DO NOT HAVE ANY
-- INCOME RECORDS

SELECT t.full_name
FROM Taxpayer_ t
WHERE NOT EXISTS
(
    SELECT 1
    FROM Income_Record i
    WHERE i.taxpayer_id = t.taxpayer_id
);


-- TASK 2
-- DISPLAY INCOME CATEGORIES THAT HAVE NEVER BEEN USED

SELECT c.category_name
FROM Income_Category c
WHERE NOT EXISTS
(
    SELECT 1
    FROM Income_Record i
    WHERE i.category_id = c.category_id
);



-- ============================================================
-- PART K: ANY
-- ============================================================

-- TASK 1
-- DISPLAY TAXPAYERS WHOSE ANNUAL INCOME IS GREATER
-- THAN ANY TAXPAYER WHOSE OCCUPATION IS TEACHER

SELECT full_name, annual_income
FROM Taxpayer_
WHERE annual_income > ANY
(
    SELECT annual_income
    FROM Taxpayer_
    WHERE occupation = 'Teacher'
);


-- TASK 2
-- DISPLAY TAXPAYERS WHOSE ANNUAL INCOME IS GREATER
-- THAN ANY TAXPAYER EARNING BUSINESS INCOME

SELECT t.full_name, t.annual_income
FROM Taxpayer_ t
WHERE t.annual_income > ANY
(
    SELECT t2.annual_income
    FROM Taxpayer_ t2
    JOIN Income_Record i
    ON t2.taxpayer_id = i.taxpayer_id
    JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Business'
);



-- ============================================================
-- PART L: ALL
-- ============================================================

-- TASK 1
-- DISPLAY TAXPAYERS WHOSE ANNUAL INCOME IS GREATER
-- THAN ALL TAXPAYERS WHOSE OCCUPATION IS TEACHER

SELECT full_name, annual_income
FROM Taxpayer_
WHERE annual_income > ALL
(
    SELECT annual_income
    FROM Taxpayer_
    WHERE occupation = 'Teacher'
);


-- TASK 2
-- DISPLAY TAXPAYERS WHOSE ANNUAL INCOME IS GREATER
-- THAN ALL BUSINESS INCOME TAXPAYERS

SELECT t.full_name, t.annual_income
FROM Taxpayer_ t
WHERE t.annual_income > ALL
(
    SELECT t2.annual_income
    FROM Taxpayer_ t2
    JOIN Income_Record i
    ON t2.taxpayer_id = i.taxpayer_id
    JOIN Income_Category c
    ON i.category_id = c.category_id
    WHERE c.category_name = 'Business'
);



-- ============================================================
-- PART M: ADDITIONAL QUERY PRACTICE
-- ============================================================

-- 1. DISPLAY ALL TAXPAYERS IN ASCENDING ORDER OF NAME

SELECT *
FROM Taxpayer_
ORDER BY full_name ASC;


-- 2. DISPLAY TAXPAYERS WHOSE ANNUAL INCOME
-- IS GREATER THAN 8,00,000

SELECT *
FROM Taxpayer_
WHERE annual_income > 800000;


-- 3. DISPLAY TAXPAYERS WHOSE OCCUPATION IS
-- SOFTWARE ENGINEER

SELECT *
FROM Taxpayer_
WHERE occupation = 'Software Engineer';


-- 4. DISPLAY ALL INCOME RECORDS BELONGING
-- TO BUSINESS CATEGORY

SELECT i.*
FROM Income_Record i
JOIN Income_Category c
ON i.category_id = c.category_id
WHERE c.category_name = 'Business';


-- 5. DISPLAY INCOME RECORDS WITH AMOUNTS BETWEEN
-- 5,00,000 AND 10,00,000

SELECT *
FROM Income_Record
WHERE amount BETWEEN 500000 AND 1000000;


-- 6. DISPLAY TAXPAYERS WHOSE NAMES START
-- WITH THE LETTER A

SELECT *
FROM Taxpayer_
WHERE full_name LIKE 'A%';


-- 7. DISPLAY ALL TAXPAYERS FROM A PARTICULAR CITY




-- 8. DISPLAY ALL ACTIVE TAXPAYERS

SELECT *
FROM Taxpayer_
WHERE is_active = TRUE;


-- 9. DISPLAY TOTAL NUMBER OF TAXPAYERS

SELECT COUNT(*) AS total_taxpayers
FROM Taxpayer_;


-- 10. DISPLAY HIGHEST ANNUAL INCOME RECORDED

SELECT MAX(annual_income) AS highest_annual_income
FROM Taxpayer_;



-- ============================================================
-- PART N: MINI CHALLENGE
-- ============================================================

-- 1. WHICH TAXPAYER HAS THE HIGHEST ANNUAL INCOME?

SELECT full_name, annual_income
FROM Taxpayer
WHERE annual_income =
(
    SELECT MAX(annual_income)
    FROM Taxpayer
);


-- 2. WHICH INCOME CATEGORY CONTAINS THE HIGHEST
-- NUMBER OF INCOME RECORDS?

SELECT c.category_name, COUNT(*) AS total_records
FROM Income_Record i
JOIN Income_Category c
ON i.category_id = c.category_id
GROUP BY c.category_id, c.category_name
ORDER BY total_records DESC
LIMIT 1;


-- 3. HOW MANY TAXPAYERS BELONG TO EACH OCCUPATION?

SELECT occupation, COUNT(*) AS total_taxpayers
FROM Taxpayer
GROUP BY occupation;


-- 4. HOW MANY TAXPAYERS ARE CURRENTLY ACTIVE?

SELECT COUNT(*) AS active_taxpayers
FROM Taxpayer
WHERE is_active = TRUE;


-- 5. WHICH FINANCIAL YEAR CONTAINS THE HIGHEST
-- NUMBER OF INCOME RECORDS?

SELECT f.year_label, COUNT(*) AS total_records
FROM Income_Record i
JOIN Financial_Year f
ON i.year_id = f.year_id
GROUP BY f.year_id, f.year_label
ORDER BY total_records DESC
LIMIT 1;