USE taxation_db;
-- PART A : VERIFY WEEK-1 DATABASE
-- Task 1: Display all tables in the database

SHOW TABLES;

-- Task 2: Display all records from Taxpayer_ table

SELECT *
FROM Taxpayer_;



-- Task 3: Display all records from Income_Category table

SELECT *
FROM Income_Category;



-- Task 4: Display all records from Financial_Year table

SELECT *
FROM Financial_Year;


-- Task 5: Display all records from Income_Record table

SELECT *
FROM Income_Record;
-- PART B : BUILT-IN STRING FUNCTIONS
-- Question 1
-- Display all taxpayer names in uppercase.

SELECT UPPER(full_name) AS taxpayer_name
FROM Taxpayer_;


-- Question 2
-- Display all occupations in lowercase.

SELECT LOWER(occupation) AS occupation
FROM Taxpayer_;

-- Question 3
-- Find the length of each taxpayer's name.

SELECT full_name,
       LENGTH(full_name) AS name_length
FROM Taxpayer_;


-- Question 4
-- Display the first four characters of every PAN number.

SELECT pan_number,
       LEFT(pan_number, 4) AS first_four_characters
FROM Taxpayer_;
-- Question 5
-- Concatenate taxpayer name with occupation.

SELECT CONCAT(full_name, ' - ', occupation) AS taxpayer_details
FROM Taxpayer_;
-- Question 6
-- Replace the word 'Income' with 'Inc.' in income category names.

SELECT REPLACE(category_name, 'Income', 'Inc.') AS modified_category
FROM Income_Category;
-- Question 7
-- Remove leading or trailing spaces from taxpayer names.

SELECT TRIM(full_name) AS taxpayer_name
FROM Taxpayer_;

-- Question 8
-- Display only the first name of every taxpayer.

SELECT SUBSTRING_INDEX(full_name, ' ', 1) AS first_name
FROM Taxpayer_;

-- Question 9
-- Generate a display string.

SELECT CONCAT('Taxpayer : ', full_name,
              ' | Occupation : ', occupation) AS display_details
FROM Taxpayer_;

-- Question 10
-- Display all taxpayers whose PAN number begins with AP.

SELECT *
FROM Taxpayer_
WHERE pan_number LIKE 'AP%';

-- PART C : BUILT-IN NUMERIC FUNCTIONS

-- Question 1
-- Round every annual income.

SELECT full_name,
       ROUND(annual_income) AS rounded_income
FROM Taxpayer_;

-- Question 2
-- Display the absolute value of annual_income - 500000.

SELECT full_name,
       ABS(annual_income - 500000) AS absolute_difference
FROM Taxpayer_;

-- Question 3
-- Display the square of annual income.

SELECT full_name,
       POWER(annual_income, 2) AS annual_income_square
FROM Taxpayer_;
-- Question 4
-- Find the remainder when annual income is divided by 1000.

SELECT full_name,
       MOD(annual_income, 1000) AS remainder
FROM Taxpayer_;

-- Question 5
-- Round annual income to two decimal places.

SELECT full_name,
       ROUND(annual_income, 2) AS rounded_income
FROM Taxpayer_;


-- Question 6
-- Display the ceiling and floor values of annual income.

SELECT full_name,
       CEIL(annual_income) AS ceiling_value,
       FLOOR(annual_income) AS floor_value
FROM Taxpayer_;
-- Question 7
-- Generate a random integer between 1 and 100.

SELECT FLOOR(RAND() * 100) + 1 AS random_integer;

-- Question 8
-- Display the square root of annual income.

SELECT full_name,
       SQRT(annual_income) AS square_root
FROM Taxpayer_;


-- Question 9
-- Calculate annual_income × 1.10 for every taxpayer
-- to estimate income after a 10% increment.

SELECT full_name,
       annual_income,
       ROUND(annual_income * 1.10, 2) AS estimated_income
FROM Taxpayer_;

-- PART D : BUILT-IN DATE FUNCTIONS

-- Question 1
-- Display today's date.

SELECT CURDATE() AS today_date;

-- Question 2
-- Display current date and time.

SELECT NOW() AS current_date_time;

-- Question 3
-- Display only the year from every financial year start date.

SELECT year_label,
       YEAR(start_date) AS start_year
FROM Financial_Year;

-- Question 4
-- Display only the month from every financial year start date.

SELECT year_label,
       MONTH(start_date) AS start_month
FROM Financial_Year;
-- Question 5
-- Display only the day of the month.

SELECT year_label,
       DAY(start_date) AS start_day
FROM Financial_Year;

-- Question 6
-- Display the financial year end date by adding one year to the start date.

SELECT year_label,
       start_date,
       DATE_ADD(start_date, INTERVAL 1 YEAR) AS end_date_after_one_year
FROM Financial_Year;

-- Question 7
-- Display the financial year start date after adding 30 days.

SELECT year_label,
       start_date,
       DATE_ADD(start_date, INTERVAL 30 DAY) AS start_date_plus_30_days
FROM Financial_Year;
-- Question 8
-- Display the financial year start date after subtracting 7 days.

SELECT year_label,
       start_date,
       DATE_SUB(start_date, INTERVAL 7 DAY) AS start_date_minus_7_days
FROM Financial_Year;
-- Question 9
-- Calculate the number of days between today's date and the financial year start date.

SELECT year_label,
       DATEDIFF(CURDATE(), start_date) AS days_difference
FROM Financial_Year;

-- Question 10
-- Display financial years belonging to the current year.

SELECT *
FROM Financial_Year
WHERE YEAR(start_date) = YEAR(CURDATE());
-- PART E : CONVERSION FUNCTIONS

-- Question 1
-- Convert annual income into INTEGER.

SELECT full_name,
       CAST(annual_income AS SIGNED) AS annual_income_integer
FROM Taxpayer_;

-- Question 2
-- Convert taxpayer ID into CHAR.

SELECT taxpayer_id,
       CAST(taxpayer_id AS CHAR) AS taxpayer_id_char
FROM Taxpayer_;

-- Question 3
-- Convert the financial year start date into DATETIME.

SELECT year_label,
       CAST(start_date AS DATETIME) AS start_datetime
FROM Financial_Year;

-- Question 4
-- Convert annual income into DECIMAL.

SELECT full_name,
       CAST(annual_income AS DECIMAL(12,2)) AS annual_income_decimal
FROM Taxpayer_;
-- Question 5
-- Display annual income as character strings.

SELECT full_name,
       CAST(annual_income AS CHAR) AS annual_income_string
FROM Taxpayer_;
-- Question 6
-- Convert numeric values before performing arithmetic
-- operations to calculate tax (10% of annual income).

SELECT full_name,
       annual_income,
       CAST(annual_income AS DECIMAL(12,2)) * 0.10 AS estimated_tax
FROM Taxpayer_;