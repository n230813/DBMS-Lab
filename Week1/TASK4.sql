USE taxation_db;
-- PART A : VERIFY PREVIOUS DATABASE

SHOW TABLES;

SELECT * FROM Taxpayer_;

SELECT * FROM Income_Category;

SELECT * FROM Financial_Year;

SELECT * FROM Income_Record;

-- PART B : SQL JOIN OPERATIONS
-- LEVEL 1 (UNDERSTANDING)

-- Task 1
-- Display every taxpayer along with the income source.

SELECT
    t.taxpayer_id,
    t.full_name,
    i.income_source
FROM Taxpayer_ t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id;

-- Task 2
-- Display every taxpayer along with the category of income they earn.

SELECT
    t.full_name,
    c.category_name
FROM Taxpayer_ t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Income_Category c
ON i.category_id = c.category_id;

-- Task 3
-- Display every income record along with its financial year.

SELECT
    i.income_id,
    i.income_source,
    f.year_label
FROM Income_Record i
INNER JOIN Financial_Year f
ON i.year_id = f.year_id;


-- Task 4
-- Display the taxpayer name together with the annual income
-- and income amount recorded in the Income_Record table.

SELECT
    t.full_name,
    t.annual_income,
    i.amount
FROM Taxpayer_ t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id;

-- Task 5
-- Display the taxpayer name, income source,
-- category name and financial year for every income record.

SELECT
    t.full_name,
    i.income_source,
    c.category_name,
    f.year_label
FROM Taxpayer_ t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Income_Category c
ON i.category_id = c.category_id
INNER JOIN Financial_Year f
ON i.year_id = f.year_id;
USE taxation_db;
-- PART B : SQL JOIN OPERATIONS
-- LEVEL 2 (APPLICATION)

-- Task 1
-- Display all taxpayers who earn Salary income
-- along with the organization from which they receive the income.

SELECT
    t.full_name,
    i.income_source,
    c.category_name
FROM Taxpayer_ t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Income_Category c
ON i.category_id = c.category_id
WHERE c.category_name = 'Salary';

-- Task 2
-- Display all taxpayers who earn Business income
-- together with their occupation and income source.

SELECT
    t.full_name,
    t.occupation,
    i.income_source,
    c.category_name
FROM Taxpayer_ t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Income_Category c
ON i.category_id = c.category_id
WHERE c.category_name = 'Business';

-- Task 3
-- Display taxpayer details together with the financial year
-- start date and end date.

SELECT
    t.taxpayer_id,
    t.full_name,
    t.pan_number,
    t.occupation,
    i.income_source,
    f.year_label,
    f.start_date,
    f.end_date
FROM Taxpayer_ t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Financial_Year f
ON i.year_id = f.year_id;

-- Task 4
-- Display taxpayer details together with the description
-- of the income category.

SELECT
    t.taxpayer_id,
    t.full_name,
    t.pan_number,
    t.occupation,
    c.category_name,
    c.description
FROM Taxpayer_ t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Income_Category c
ON i.category_id = c.category_id;

-- Task 5
-- Display complete taxation information.

SELECT
    t.full_name,
    t.pan_number,
    t.occupation,
    i.income_source,
    c.category_name,
    i.amount,
    f.year_label,
    f.start_date,
    f.end_date
FROM Taxpayer_ t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Income_Category c
ON i.category_id = c.category_id
INNER JOIN Financial_Year f
ON i.year_id = f.year_id;
USE taxation_db;
-- PART B : LEVEL 3 (ADVANCED JOINS)

-- Task 1
-- Display all taxpayers including those who have not submitted any income records.

SELECT
    t.taxpayer_id,
    t.full_name,
    i.income_source
FROM Taxpayer_ t
LEFT JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id;

-- Task 2
-- Display all income categories including those that are not used.

SELECT
    c.category_id,
    c.category_name,
    i.income_source
FROM Income_Category c
LEFT JOIN Income_Record i
ON c.category_id = i.category_id;

-- Task 3
-- Display all financial years along with income records.

SELECT
    f.year_label,
    i.income_source,
    i.amount
FROM Financial_Year f
LEFT JOIN Income_Record i
ON f.year_id = i.year_id;

-- Task 4
-- Display all taxpayers and all income records
-- (FULL OUTER JOIN using UNION in MySQL).

SELECT
    t.taxpayer_id,
    t.full_name,
    i.income_source
FROM Taxpayer_ t
LEFT JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id

UNION

SELECT
    t.taxpayer_id,
    t.full_name,
    i.income_source
FROM Taxpayer_ t
RIGHT JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id;

-- Task 5
-- Display every taxpayer with every financial year.

SELECT
    t.full_name,
    f.year_label
FROM Taxpayer_ t
CROSS JOIN Financial_Year f;
-- ADDITIONAL PRACTICE

-- Task 6
-- Display taxpayer name, PAN number, income source,
-- income category and financial year.

SELECT
    t.full_name,
    t.pan_number,
    i.income_source,
    c.category_name,
    f.year_label
FROM Taxpayer_ t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Income_Category c
ON i.category_id = c.category_id
INNER JOIN Financial_Year f
ON i.year_id = f.year_id;

-- ============================================================

-- Task 7
-- Display taxpayer name with category description.

SELECT
    t.full_name,
    c.category_name,
    c.description
FROM Taxpayer_ t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Income_Category c
ON i.category_id = c.category_id;

-- Task 8
-- Display income source and financial year.

SELECT
    i.income_source,
    f.year_label
FROM Income_Record i
INNER JOIN Financial_Year f
ON i.year_id = f.year_id;

-- Task 9
-- Display Business income taxpayers for 2025-2026.

SELECT
    t.full_name,
    i.income_source,
    c.category_name,
    f.year_label
FROM Taxpayer_ t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Income_Category c
ON i.category_id = c.category_id
INNER JOIN Financial_Year f
ON i.year_id = f.year_id
WHERE c.category_name = 'Business'
AND f.year_label = '2025-2026';

-- Task 10
-- Display complete taxation report.

SELECT
    t.taxpayer_id,
    t.full_name,
    t.pan_number,
    t.occupation,
    t.annual_income,
    i.income_source,
    i.amount,
    c.category_name,
    c.description,
    f.year_label,
    f.start_date,
    f.end_date
FROM Taxpayer_ t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
INNER JOIN Income_Category c
ON i.category_id = c.category_id
INNER JOIN Financial_Year f
ON i.year_id = f.year_id;