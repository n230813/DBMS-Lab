-- DBMS LAB TASK 7
-- SQL VIEWS USING TAXATION DATABASE
USE taxation_db;
-- PART A: LEVEL 1 - UNDERSTANDING

-- Task 1: Income record having the highest income

DROP VIEW IF EXISTS highest_income_view;

CREATE VIEW highest_income_view AS
SELECT *
FROM Income_Record
WHERE amount = (
    SELECT MAX(amount)
    FROM Income_Record
);

SELECT * FROM highest_income_view;


-- Task 2: Income record having the lowest income

DROP VIEW IF EXISTS lowest_income_view;

CREATE VIEW lowest_income_view AS
SELECT *
FROM Income_Record
WHERE amount = (
    SELECT MIN(amount)
    FROM Income_Record
);

SELECT * FROM lowest_income_view;


-- Task 3: Income records greater than average income

DROP VIEW IF EXISTS above_average_income_view;

CREATE VIEW above_average_income_view AS
SELECT *
FROM Income_Record
WHERE amount > (
    SELECT AVG(amount)
    FROM Income_Record
);

SELECT * FROM above_average_income_view;


-- Task 4: Income records equal to highest recorded income

DROP VIEW IF EXISTS maximum_income_records_view;

CREATE VIEW maximum_income_records_view AS
SELECT *
FROM Income_Record
WHERE amount = (
    SELECT MAX(amount)
    FROM Income_Record
);

SELECT * FROM maximum_income_records_view;


-- Task 5: Taxpayers whose occupation is Business Owner

DROP VIEW IF EXISTS business_owner_view;

CREATE VIEW business_owner_view AS
SELECT taxpayer_id, full_name, occupation
FROM Taxpayer_
WHERE occupation = 'Business Owner';

SELECT * FROM business_owner_view;
-- PART A: LEVEL 2 - APPLICATION
-- Task 1: Taxpayers having at least one income record

DROP VIEW IF EXISTS taxpayers_with_income_view;

CREATE VIEW taxpayers_with_income_view AS
SELECT DISTINCT t.*
FROM Taxpayer_ t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id;

SELECT * FROM taxpayers_with_income_view;


-- Task 2: Taxpayers having Business category income

DROP VIEW IF EXISTS business_income_taxpayers_view;

CREATE VIEW business_income_taxpayers_view AS
SELECT DISTINCT t.*
FROM Taxpayer_ t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.category_name = 'Business';

SELECT * FROM business_income_taxpayers_view;


-- Task 3: Income records belonging to financial year 2025-2026

DROP VIEW IF EXISTS income_2025_2026_view;

CREATE VIEW income_2025_2026_view AS
SELECT i.*
FROM Income_Record i
INNER JOIN Financial_Year f
ON i.financial_year = f.year_label
WHERE f.year_label = '2025-2026';

SELECT * FROM income_2025_2026_view;


-- Task 4: Income greater than minimum Business income

DROP VIEW IF EXISTS above_min_business_income_view;

CREATE VIEW above_min_business_income_view AS
SELECT *
FROM Income_Record
WHERE amount > (
    SELECT MIN(amount)
    FROM Income_Record
    WHERE category_name = 'Business'
);

SELECT * FROM above_min_business_income_view;


-- Task 5: Income less than maximum Salary income

DROP VIEW IF EXISTS below_max_salary_income_view;

CREATE VIEW below_max_salary_income_view AS
SELECT *
FROM Income_Record
WHERE amount < (
    SELECT MAX(amount)
    FROM Income_Record
    WHERE category_name = 'Salary'
);

SELECT * FROM below_max_salary_income_view;


-- Task 6: Taxpayers having income greater than average income

DROP VIEW IF EXISTS taxpayers_above_average_income_view;

CREATE VIEW taxpayers_above_average_income_view AS
SELECT DISTINCT t.*
FROM Taxpayer_ t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.amount > (
    SELECT AVG(amount)
    FROM Income_Record
);

SELECT * FROM taxpayers_above_average_income_view;


-- Task 7: Income categories having at least one income record

DROP VIEW IF EXISTS categories_with_income_view;

CREATE VIEW categories_with_income_view AS
SELECT DISTINCT c.*
FROM Income_Category c
INNER JOIN Income_Record i
ON c.category_name = i.category_name;

SELECT * FROM categories_with_income_view;


-- Task 8: Taxpayers having no Investment income

DROP VIEW IF EXISTS taxpayers_without_investment_view;

CREATE VIEW taxpayers_without_investment_view AS
SELECT *
FROM Taxpayer_ t
WHERE NOT EXISTS (
    SELECT 1
    FROM Income_Record i
    WHERE i.taxpayer_id = t.taxpayer_id
      AND i.category_name = 'Investment'
);

SELECT * FROM taxpayers_without_investment_view;
-- PART A: LEVEL 3 - MEDIUM TO ADVANCED

-- Task 1: Taxpayer having the highest recorded income

DROP VIEW IF EXISTS highest_income_taxpayer_view;

CREATE VIEW highest_income_taxpayer_view AS
SELECT t.taxpayer_id, t.full_name, i.amount
FROM Taxpayer_ t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.amount = (
    SELECT MAX(amount)
    FROM Income_Record
);

SELECT * FROM highest_income_taxpayer_view;


-- Task 2: Income records greater than average Business income

DROP VIEW IF EXISTS above_average_business_income_view;

CREATE VIEW above_average_business_income_view AS
SELECT *
FROM Income_Record
WHERE amount > (
    SELECT AVG(amount)
    FROM Income_Record
    WHERE category_name = 'Business'
);

SELECT * FROM above_average_business_income_view;


-- Task 3: Taxpayers whose total income is greater than
-- the average total income of all taxpayers

DROP VIEW IF EXISTS above_average_total_income_view;
DROP VIEW IF EXISTS taxpayer_total_income_view;

CREATE VIEW taxpayer_total_income_view AS
SELECT t.taxpayer_id,
       t.full_name,
       COALESCE(SUM(i.amount), 0) AS total_income
FROM Taxpayer_ t
LEFT JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
GROUP BY t.taxpayer_id, t.full_name;

CREATE VIEW above_average_total_income_view AS
SELECT *
FROM taxpayer_total_income_view
WHERE total_income > (
    SELECT AVG(total_income)
    FROM taxpayer_total_income_view
);

SELECT * FROM above_average_total_income_view;


-- Task 4: Income greater than at least one Investment income
-- ANY means greater than at least one value

DROP VIEW IF EXISTS greater_than_any_investment_view;

CREATE VIEW greater_than_any_investment_view AS
SELECT *
FROM Income_Record
WHERE amount > ANY (
    SELECT amount
    FROM Income_Record
    WHERE category_name = 'Investment'
);

SELECT * FROM greater_than_any_investment_view;


-- Task 5: Income greater than every Investment income
-- ALL means greater than every value

DROP VIEW IF EXISTS greater_than_all_investment_view;

CREATE VIEW greater_than_all_investment_view AS
SELECT *
FROM Income_Record
WHERE amount > ALL (
    SELECT amount
    FROM Income_Record
    WHERE category_name = 'Investment'
);

SELECT * FROM greater_than_all_investment_view;


-- Task 6: Income category containing the highest income record

DROP VIEW IF EXISTS highest_income_category_view;

CREATE VIEW highest_income_category_view AS
SELECT DISTINCT category_name
FROM Income_Record
WHERE amount = (
    SELECT MAX(amount)
    FROM Income_Record
);

SELECT * FROM highest_income_category_view;


-- Task 7: Financial year having the highest total income

DROP VIEW IF EXISTS highest_income_year_view;
DROP VIEW IF EXISTS yearly_total_income_view;

CREATE VIEW yearly_total_income_view AS
SELECT financial_year,
       SUM(amount) AS total_income
FROM Income_Record
GROUP BY financial_year;

CREATE VIEW highest_income_year_view AS
SELECT *
FROM yearly_total_income_view
WHERE total_income = (
    SELECT MAX(total_income)
    FROM yearly_total_income_view
);

SELECT * FROM highest_income_year_view;


-- Task 8: Taxpayers whose total recorded income is greater
-- than the average total recorded income

DROP VIEW IF EXISTS taxpayers_above_average_total_view;

CREATE VIEW taxpayers_above_average_total_view AS
SELECT *
FROM taxpayer_total_income_view
WHERE total_income > (
    SELECT AVG(total_income)
    FROM taxpayer_total_income_view
);

SELECT * FROM taxpayers_above_average_total_view;
-- PART B: REAL-WORLD TAXATION ANALYSIS

-- Task 1: Taxpayer having the highest individual income

DROP VIEW IF EXISTS highest_individual_income_view;

CREATE VIEW highest_individual_income_view AS
SELECT t.taxpayer_id,
       t.full_name,
       i.income_id,
       i.amount
FROM Taxpayer_ t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.amount = (
    SELECT MAX(amount)
    FROM Income_Record
);

SELECT * FROM highest_individual_income_view;


-- Task 2: Taxpayers whose income is above overall average

DROP VIEW IF EXISTS above_overall_average_view;

CREATE VIEW above_overall_average_view AS
SELECT t.taxpayer_id,
       t.full_name,
       i.income_id,
       i.amount
FROM Taxpayer_ t
INNER JOIN Income_Record i
ON t.taxpayer_id = i.taxpayer_id
WHERE i.amount > (
    SELECT AVG(amount)
    FROM Income_Record
);

SELECT * FROM above_overall_average_view;


-- Task 3: Category containing the highest income record

DROP VIEW IF EXISTS highest_record_category_view;

CREATE VIEW highest_record_category_view AS
SELECT DISTINCT category_name
FROM Income_Record
WHERE amount = (
    SELECT MAX(amount)
    FROM Income_Record
);

SELECT * FROM highest_record_category_view;


-- Task 4: Taxpayers having Business income
-- but no Investment income

DROP VIEW IF EXISTS business_without_investment_view;

CREATE VIEW business_without_investment_view AS
SELECT DISTINCT t.*
FROM Taxpayer_ t
WHERE EXISTS (
    SELECT 1
    FROM Income_Record i
    WHERE i.taxpayer_id = t.taxpayer_id
      AND i.category_name = 'Business'
)
AND NOT EXISTS (
    SELECT 1
    FROM Income_Record i
    WHERE i.taxpayer_id = t.taxpayer_id
      AND i.category_name = 'Investment'
);

SELECT * FROM business_without_investment_view;


-- Task 5: Income records greater than every Investment income

DROP VIEW IF EXISTS income_greater_than_all_investments_view;

CREATE VIEW income_greater_than_all_investments_view AS
SELECT *
FROM Income_Record
WHERE amount > ALL (
    SELECT amount
    FROM Income_Record
    WHERE category_name = 'Investment'
);

SELECT * FROM income_greater_than_all_investments_view;


-- Task 6: Income records greater than at least one Investment income

DROP VIEW IF EXISTS income_greater_than_any_investment_view;

CREATE VIEW income_greater_than_any_investment_view AS
SELECT *
FROM Income_Record
WHERE amount > ANY (
    SELECT amount
    FROM Income_Record
    WHERE category_name = 'Investment'
);

SELECT * FROM income_greater_than_any_investment_view;


-- Task 7: Taxpayer(s) having the highest total income

DROP VIEW IF EXISTS highest_total_income_taxpayer_view;

CREATE VIEW highest_total_income_taxpayer_view AS
SELECT *
FROM taxpayer_total_income_view
WHERE total_income = (
    SELECT MAX(total_income)
    FROM taxpayer_total_income_view
);

SELECT * FROM highest_total_income_taxpayer_view;


-- Task 8: Income records above the average income
-- of their corresponding category

DROP VIEW IF EXISTS income_above_category_average_view;

CREATE VIEW income_above_category_average_view AS
SELECT i.*
FROM Income_Record i
INNER JOIN (
    SELECT category_name,
           AVG(amount) AS average_amount
    FROM Income_Record
    GROUP BY category_name
) AS category_average
ON i.category_name = category_average.category_name
WHERE i.amount > category_average.average_amount;

SELECT * FROM income_above_category_average_view;