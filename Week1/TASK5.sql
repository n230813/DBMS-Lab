USE taxation_db;
SHOW TABLES;
SELECT * FROM taxpayer_;

SELECT * FROM income_Category;

SELECT * FROM financial_Year;

SELECT * FROM income_record;

SELECT COUNT(*) AS total_income_records
FROM income_record;

SELECT SUM(amount) AS total_income
FROM income_record;

SELECT AVG(amount) AS average_income
FROM income_record;

SELECT MAX(amount) AS highest_income
FROM income_record;

SELECT MIN(amount) AS lowest_income
FROM income_record;

SELECT category_id, COUNT(*) AS number_of_records
FROM income_record
GROUP BY category_id;

SELECT category_id, SUM(amount) AS total_income
FROM income_record
GROUP BY category_id;

SELECT category_id, AVG(amount) AS average_income
FROM income_record
GROUP BY category_id;

SELECT category_id, MAX(amount) AS highest_income
FROM income_record
GROUP BY category_id;

SELECT category_id, MIN(amount) AS lowest_income
FROM income_record
GROUP BY category_id;

SELECT year_id, SUM(amount) AS total_income
FROM income_record
GROUP BY year_id;

SELECT year_id, COUNT(*) AS number_of_records
FROM income_record
GROUP BY year_id;

SELECT category_id, year_id, SUM(amount) AS total_income
FROM income_record
GROUP BY category_id, year_id;
SELECT category_id, SUM(amount) AS total_income
FROM income_record
GROUP BY category_id
HAVING SUM(amount) > 1000000;
SELECT category_id, AVG(amount) AS average_income
FROM income_record
GROUP BY category_id
HAVING AVG(amount) > 500000;
SELECT year_id, COUNT(*) AS number_of_records
FROM income_record
GROUP BY year_id
HAVING COUNT(*) > 3;
SELECT category_id, SUM(amount) AS total_income
FROM income_record
GROUP BY category_id
ORDER BY SUM(amount) DESC;

SELECT category_id, SUM(amount) AS total_income
FROM income_record
GROUP BY category_id
HAVING SUM(amount) > 1000000
ORDER BY SUM(amount) DESC;

SELECT
    category_id,
    SUM(amount) AS total_income,
    AVG(amount) AS average_income
FROM income_record
GROUP BY category_id;

SELECT
    category_id,
    year_id,
    SUM(amount) AS total_income
FROM income_record
GROUP BY category_id, year_id
ORDER BY SUM(amount) DESC
LIMIT 1;

SELECT
    C.category_name,
    SUM(I.amount) AS total_income
FROM income_record I
JOIN Income_Category C
    ON I.category_id = C.category_id
GROUP BY C.category_name;

SELECT
    F.financial_year,
    COUNT(DISTINCT I.taxpayer_id) AS number_of_taxpayers
FROM income_record I
JOIN Financial_Year F
    ON I.year_id = F.year_id
GROUP BY F.financial_year;

SELECT
    C.category_name,
    SUM(I.amount) AS total_income
FROM income_record I
JOIN Income_Category C
    ON I.category_id = C.category_id
GROUP BY C.category_name
ORDER BY SUM(I.amount) DESC
LIMIT 1;

SELECT
    F.year_label,
    SUM(I.amount) AS total_income
FROM income_record I
JOIN Financial_Year F
    ON I.year_id = F.year_id
GROUP BY F.year_id,F.year_label;
SELECT
    C.category_name,
    AVG(I.amount) AS average_income
FROM income_record I
JOIN Income_Category C
    ON I.category_id = C.category_id
GROUP BY C.category_name
ORDER BY AVG(I.amount) DESC
LIMIT 1;
SELECT
    C.category_name,
    COUNT(*) AS number_of_records
FROM income_record I
JOIN Income_Category C
    ON I.category_id = C.category_id
GROUP BY C.category_name
HAVING COUNT(*) > 2;
-- TASK 1
-- Display only those income categories whose total income
-- is greater than ₹10,00,000

SELECT
    C.category_name,
    SUM(I.amount) AS total_income
FROM income_record I
JOIN income_category C
    ON I.category_id = C.category_id
GROUP BY C.category_id, C.category_name
HAVING SUM(I.amount) > 1000000;
SELECT
    C.category_name,
    AVG(I.amount) AS average_income
FROM income_record I
JOIN income_category C
    ON I.category_id = C.category_id
GROUP BY C.category_id, C.category_name
HAVING AVG(I.amount) > 500000;
SELECT
    F.year_label,
    COUNT(I.income_id) AS number_of_records
FROM income_record I
JOIN financial_year F
    ON I.year_id = F.year_id
GROUP BY F.year_id, F.year_label
HAVING COUNT(I.income_id) > 3;
SELECT
    C.category_name,
    SUM(I.amount) AS total_income
FROM income_record I
JOIN income_category C
    ON I.category_id = C.category_id
GROUP BY C.category_id, C.category_name
ORDER BY SUM(I.amount) DESC;
SELECT
    C.category_name,
    SUM(I.amount) AS total_income
FROM income_record I
JOIN income_category C
    ON I.category_id = C.category_id
GROUP BY C.category_id, C.category_name
HAVING SUM(I.amount) > 1000000
ORDER BY SUM(I.amount) DESC;

SELECT
    C.category_name,
    SUM(I.amount) AS total_income,
    AVG(I.amount) AS average_income
FROM income_record I
JOIN income_category C
    ON I.category_id = C.category_id
GROUP BY C.category_id, C.category_name;

SELECT
    C.category_name,
    F.year_label,
    SUM(I.amount) AS total_income
FROM income_record I
JOIN income_category C
    ON I.category_id = C.category_id
JOIN financial_year F
    ON I.year_id = F.year_id
GROUP BY C.category_id, C.category_name,
         F.year_id, F.year_label
ORDER BY SUM(I.amount) DESC
LIMIT 1;
SELECT
    F.year_label,
    COUNT(DISTINCT I.taxpayer_id) AS number_of_taxpayers
FROM income_record I
JOIN financial_year F
    ON I.year_id = F.year_id
GROUP BY F.year_id, F.year_label;

SELECT
    C.category_name,
    SUM(I.amount) AS total_income
FROM income_record I
JOIN income_category C
    ON I.category_id = C.category_id
GROUP BY C.category_id, C.category_name
ORDER BY SUM(I.amount) DESC
LIMIT 1;
SELECT
    F.year_label,
    SUM(I.amount) AS total_income
FROM income_record I
JOIN financial_year F
    ON I.year_id = F.year_id
GROUP BY F.year_id, F.year_label
ORDER BY SUM(I.amount) DESC
LIMIT 1;
SELECT
    C.category_name,
    AVG(I.amount) AS average_income
FROM income_record I
JOIN income_category C
    ON I.category_id = C.category_id
GROUP BY C.category_id, C.category_name
ORDER BY AVG(I.amount) DESC
LIMIT 1;
SELECT
    C.category_name,
    COUNT(I.income_id) AS number_of_records
FROM income_record I
JOIN income_category C
    ON I.category_id = C.category_id
GROUP BY C.category_id, C.category_name
HAVING COUNT(I.income_id) > 2;
SELECT
    F.year_label,
    SUM(I.amount) AS total_income
FROM income_record I
JOIN financial_year F
    ON I.year_id = F.year_id
GROUP BY F.year_id, F.year_label
HAVING SUM(I.amount) > 1000000;
SELECT
    C.category_name AS income_category,
    COUNT(I.income_id) AS number_of_records,
    SUM(I.amount) AS total_income,
    AVG(I.amount) AS average_income,
    MAX(I.amount) AS highest_income
FROM income_record I
JOIN income_category C
    ON I.category_id = C.category_id
GROUP BY C.category_id, C.category_name;