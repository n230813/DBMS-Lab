USE pranathidb1;
CREATE TABLE Financial_year(
year_id INT PRIMARY KEY,
year_label VARCHAR(9) NOT NULL
UNIQUE,
start_date DATE NOT NULL,
end_date DATE NOT NULL,
filing_deadline DATE,
is_current BOOLEAN NOT NULL
);
INSERT INTO Financial_year
(year_id, year_label, start_date, end_date, filing_deadline, is_current)
VALUES
(1,'2020-2021','2020-04-01','2021-03-31','2021-07-31',FALSE),
(2,'2021-2022','2021-04-01','2022-07-31','2022-07-31',FALSE),
(3,'2022-2023','2022-04-01','2023-03-31','2023-07-31',FALSE),
(4,'2023-2024','2023-04-01','2024-03-31','2024-07-31',FALSE),
(5,'2024-2025','2024-04-01','2025-03-31','2025-07-31',FALSE),
(6,'2025-2026','2025-04-01','2026-03-31','2026-07-31',TRUE);
CREATE TABLE Income_Record(
income_id INT PRIMARY KEY,
taxpayer_id INT NOT NULL,
income_source VARCHAR(100) NOT NULL,
category_name VARCHAR(50) NOT NULL,
amount DECIMAL(12,2) NOT NULl,
received_date DATE NOT NULL,
financial_year VARCHAR(9) NOT NULL
);
INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, category_name, amount, received_date, financial_year)
VALUES
(1001,101,'TechNova Solutions','Salary',850000.00,'2026-03-31','2025-2026'),
(1002,102,'City Care Hospital','Salary',1200000.00,'2026-03-31','2025-2026'),
(1003,103,'Reddy Enterprises','Business',1800000.00,'2026-03-31','2025-2026'),
(1004,104,'Sunrise School','Salary',620000.00,'2026-03-31','2025-2026'),
(1005,105,'Web Design Projects','Business',750000.00,'2026-03-31','2025-2026'),
(1006,106,'Professional Consulting','Business',1500000.00,'2026-03-31','2025-2026');

select * from Income_Record;