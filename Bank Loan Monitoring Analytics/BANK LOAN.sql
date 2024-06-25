CREATE TABLE financial_loan (
    id INT PRIMARY KEY,
    address_state VARCHAR(2),
    application_type VARCHAR(20),
    emp_length VARCHAR(20),
    emp_title VARCHAR(255),
    grade CHAR(1),
    home_ownership VARCHAR(20),
    issue_date DATE,
    last_credit_pull_date DATE,
    last_payment_date DATE,
    loan_status VARCHAR(20),
    next_payment_date DATE,
    member_id INT,
    purpose VARCHAR(50),
    sub_grade VARCHAR(5),
    term VARCHAR(20),
    verification_status VARCHAR(20),
    annual_income FLOAT,
    dti FLOAT,
    installment FLOAT,
    int_rate FLOAT,
    loan_amount INT,
    total_acc INT,
    total_payment INT
);
select 
	* 
from 
	financial_loan;

COPY 
	financial_loan 
FROM 
	'D:\financial_loan.csv' 
WITH 
	(FORMAT CSV, ENCODING 'UTF-8', DELIMITER ',', HEADER);


------------------------------------------------------------------------------------------------
							/* KEY PERFORMANCE INDICATOR (KPI) REQUIREMENT */
------------------------------------------------------------------------------------------------
-- Problem statement 1
------------------------------------------------------------------------------------------------
--- Total_Loan_Applications ---

SELECT 
	COUNT(id) AS Total_Loan_Applications 
FROM 
	financial_loan

-----------------------------------------------------------------------------------------------
--- MONTH TO DATE Total_Loan_Applications (LAST MONTH)---

SELECT 
	COUNT(id) AS MTD_Total_Loan_Applications 
FROM 
	financial_loan
WHERE 
	EXTRACT(MONTH FROM issue_date) = 12 
	AND EXTRACT(YEAR FROM issue_date) = 2021;

------------------------------------------------------------------------------------------------
--- PREVIOUS MONTH TO DATE Total_Loan_Applications (PREVIOUS MONTH)---

SELECT 
	COUNT(id) AS PMTD_Total_Loan_Applications 
FROM 
	financial_loan
WHERE 
	EXTRACT(MONTH FROM issue_date) = 11 
	AND EXTRACT(YEAR FROM issue_date) = 2021;

------------------------------------------------------------------------------------------------
-- Problem statement 2
------------------------------------------------------------------------------------------------
--- Total_Funded_Amount ---
SELECT 
	SUM(loan_amount) AS Total_Funded_Amount 
FROM 
	financial_loan;

------------------------------------------------------------------------------------------------
--- MONTH TO DATE Total_Funded_Amount (LAST MONTH) ---
SELECT 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM 
	financial_loan
WHERE 
	EXTRACT(MONTH FROM issue_date) = 12 
	AND EXTRACT(YEAR FROM issue_date) = 2021;

------------------------------------------------------------------------------------------------
--- PREVIOUS MONTH TO DATE Total_Funded_Amount (PREVIOUS MONTH) ---
SELECT 
	SUM(loan_amount) AS PMTD_Total_Funded_Amount 
FROM 
	financial_loan
WHERE 
	EXTRACT(MONTH FROM issue_date) = 11 
	AND EXTRACT(YEAR FROM issue_date) = 2021;

------------------------------------------------------------------------------------------------
-- Problem statement 3 --
------------------------------------------------------------------------------------------------
--- Total_Amount_Received ---
SELECT 
	SUM(total_payment) AS Total_Amount_Received 
FROM
	financial_loan;

------------------------------------------------------------------------------------------------
--- MONTH TO DATE Total_Amount_Received (LAST MONTH) ---
SELECT SUM(total_payment) AS MTD_Total_Amount_Received 
FROM 
	financial_loan
WHERE 
	EXTRACT(MONTH FROM issue_date) = 12 
	AND EXTRACT(YEAR FROM issue_date) = 2021;

------------------------------------------------------------------------------------------------
--- PREVIOUS MONTH TO DATE Total_Amount_Received (PREVIOUS LAST MONTH) ---
SELECT SUM(total_payment) AS PMTD_Total_Amount_Received 
FROM 
	financial_loan
WHERE 
	EXTRACT(MONTH FROM issue_date) = 11 
	AND EXTRACT(YEAR FROM issue_date) = 2021;

------------------------------------------------------------------------------------------------
--- Problem statement 4 --
------------------------------------------------------------------------------------------------
--- Average Interest Rate ---
SELECT 
	ROUND(AVG(CAST(int_rate AS numeric)), 4) * 100 AS Average_Interest_Rate 
FROM 
	financial_loan;

------------------------------------------------------------------------------------------------
--- MONTH TO DATE Average Interest Rate (LAST MONTH) ---
SELECT 
	ROUND(AVG(CAST(int_rate AS numeric)), 3) * 100  AS MTD_Average_Interest_Rate 
FROM 
	financial_loan
WHERE 
	EXTRACT(MONTH FROM issue_date) = 12 
	AND EXTRACT(YEAR FROM issue_date) = 2021;

------------------------------------------------------------------------------------------------
--- PREVIOUS MONTH TO DATE Average Interest Rate (PREVIOUS MONTH) ---
SELECT 
	ROUND(AVG(CAST(int_rate AS numeric)), 3) * 100  AS PMTD_Average_Interest_Rate
FROM 
	financial_loan
WHERE 
	EXTRACT(MONTH FROM issue_date) = 11 
	AND EXTRACT(YEAR FROM issue_date) = 2021;

------------------------------------------------------------------------------------------------
--- Problem statement 4 --
------------------------------------------------------------------------------------------------
--- Average Debt_to_Income_ratio ---
SELECT 
	ROUND(AVG(CAST(dti AS numeric)), 3) * 100  AS Average_Debt_to_Income_ratio
FROM 
	financial_loan;

------------------------------------------------------------------------------------------------
--- MONTH TO DATE Average Debt_to_Income_ratio (LAST MONTH) ---
SELECT 
	ROUND(AVG(CAST(dti AS numeric)), 3) * 100  AS MTD_Average_Debt_to_Income_ratio 
FROM 
	financial_loan
WHERE 
	EXTRACT(MONTH FROM issue_date) = 12 
	AND EXTRACT(YEAR FROM issue_date) = 2021;

------------------------------------------------------------------------------------------------
--- PREVIOUS MONTH TO DATE Average Debt_to_Income_ratio (PREVIOUS MONTH) ---
SELECT 
    ROUND(AVG(CAST(dti AS numeric)), 3) * 100 AS PMTD_Average_Debt_to_Income_ratio
FROM 
    financial_loan
WHERE 
    EXTRACT(MONTH FROM issue_date) = 11 
    AND EXTRACT(YEAR FROM issue_date) = 2021;
------------------------------------------------------------------------------------------------
							/* GOOD LOAN vs BAD LOAN ISSUED */
------------------------------------------------------------------------------------------------
-- Problem statement 1
------------------------------------------------------------------------------------------------
--- Good_Loan_Percentage ---
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current'
        THEN
            id
        END)*100)
    /
    COUNT(id) AS Good_Loan_Percentage
FROM 
    financial_loan;

------------------------------------------------------------------------------------------------
--- Good_Loan_Application ---
SELECT
	COUNT(id) AS Good_Loan_Application
FROM 
	financial_loan
WHERE
	loan_status = 'Fully Paid' 
	OR loan_status = 'Current';

------------------------------------------------------------------------------------------------
--- Good_Loan_Funded_Amount ---
SELECT
	SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM 
	financial_loan
WHERE
	loan_status = 'Fully Paid' 
	OR loan_status = 'Current';

--- Good_Loan_Amount_Received ---
SELECT
	SUM(total_payment) AS Good_Loan_Amount_Received
FROM 
	financial_loan
WHERE
	loan_status = 'Fully Paid' 
	OR loan_status = 'Current';


------------------------------------------------------------------------------------------------
-- Problem statement 2
------------------------------------------------------------------------------------------------
--- Bad_Loan_Percentage ---
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off'
        THEN
            id
        END)*100)
    /
    COUNT(id) AS Bad_Loan_Percentage
FROM 
    financial_loan;

------------------------------------------------------------------------------------------------
--- Bad_Loan_Application ---
SELECT
	COUNT(id) AS Bad_Loan_Application
FROM 
	financial_loan
WHERE
	loan_status = 'Charged Off';

------------------------------------------------------------------------------------------------
--- Bad_Loan_Funded_Amount ---
SELECT
	SUM(loan_amount) AS Bad_Loan_Funded_Amount
FROM 
	financial_loan
WHERE
	loan_status = 'Charged Off';

--- Bad_Loan_Amount_Received ---
SELECT
	SUM(total_payment) AS Bad_Loan_Amount_Received
FROM 
	financial_loan
WHERE
	loan_status = 'Charged Off';

------------------------------------------------------------------------------------------------
							/* MEASURE ANALYSING */
------------------------------------------------------------------------------------------------
-- Problem statement 1
------------------------------------------------------------------------------------------------
--- Loan_Status ---
SELECT
	loan_status,
    COUNT(id) AS Total_Loan_Applications,
    SUM(total_payment) AS Total_Amount_Received,
	SUM(loan_amount) AS Total_Funded_Amount,
    ROUND(AVG(CAST(int_rate AS numeric)), 2) * 100 AS Interest_Rate,
    ROUND(AVG(CAST(dti AS numeric)), 2) * 100 AS Debt_to_Income_Ratio
FROM
	financial_loan
GROUP BY
	loan_status;

--- MTD_Loan_Status and PMTD_Loan_Status ---

SELECT 
    loan_status, 
    SUM(CASE WHEN EXTRACT(MONTH FROM issue_date) = 12 AND EXTRACT(YEAR FROM issue_date) = 2021 
	THEN total_payment END) AS MTD_Total_Amount_Received,
    SUM(CASE WHEN EXTRACT(MONTH FROM issue_date) = 11 AND EXTRACT(YEAR FROM issue_date) = 2021 
	THEN total_payment END) AS PMTD_Total_Amount_Received,
    SUM(CASE WHEN EXTRACT(MONTH FROM issue_date) = 12 AND EXTRACT(YEAR FROM issue_date) = 2021 
	THEN loan_amount END) AS MTD_Total_Funded_Amount,
	SUM(CASE WHEN EXTRACT(MONTH FROM issue_date) = 11 AND EXTRACT(YEAR FROM issue_date) = 2021 
	THEN loan_amount END) AS PMTD_Total_Funded_Amount
FROM 
    financial_loan
GROUP BY 
    loan_status;

------------------------------------------------------------------------------------------------
							/* DEMOGRAPHIC ANALYSING */
------------------------------------------------------------------------------------------------
-- Problem statement 1
------------------------------------------------------------------------------------------------
--- Analysis by Month ---
SELECT 
    EXTRACT(MONTH FROM issue_date) AS Month_Number, 
    TO_CHAR(issue_date, 'Month') AS Month_Name, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM 
	financial_loan
GROUP BY 
	EXTRACT(MONTH FROM issue_date), 
	TO_CHAR(issue_date, 'Month')
ORDER BY 
	EXTRACT(MONTH FROM issue_date);

--- Analysis by STATE ---
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM 
	financial_loan
GROUP BY 
	address_state
ORDER BY 
	address_state;

--- Analysis by Term ---
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM 
	financial_loan
GROUP BY 
	term
ORDER BY 
	term;

--- Analysis by Employee Length ---
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM 
	financial_loan
GROUP BY 
	emp_length
ORDER BY 
	emp_length

--- Analysis by Employee Length ---
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM 
	financial_loan
GROUP BY 
	purpose
ORDER BY 
	purpose;

--- Analysis by House Ownership ---
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM 
	financial_loan
GROUP BY 
	home_ownership
ORDER BY 
	home_ownership;

--- Analysis by Grade ---
SELECT 
    grade AS Grade,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM 
    financial_loan
GROUP BY 
    grade
ORDER BY 
    grade;
------------------------------------------------------------------------------------------------
										--- THE END ---
------------------------------------------------------------------------------------------------
