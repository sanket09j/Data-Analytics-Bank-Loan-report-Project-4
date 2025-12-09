/*  
==========================================
BANK LOAN ANALYSIS – SQL QUERY DOCUMENT
Author: Sanket Jadhav  
Dataset: Bank Loan Records  
Used In: Power BI – Bank Loan Performance Dashboard  
==========================================
*/

/* -----------------------------------------
   SECTION 1 – KPI QUERIES
----------------------------------------- */

/* Total Loan Applications */
SELECT COUNT(id) AS Total_Applications
FROM [Bank loan];

/* MTD Loan Applications (Month = 12) */
SELECT COUNT(id) AS MTD_Applications
FROM [Bank loan]
WHERE MONTH(issue_date) = 12;

/* PMTD Loan Applications (Month = 11) */
SELECT COUNT(id) AS PMTD_Applications
FROM [Bank loan]
WHERE MONTH(issue_date) = 11;


/* Total Funded Amount */
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM [Bank loan];

/* MTD Total Funded Amount */
SELECT SUM(loan_amount) AS MTD_Total_Funded
FROM [Bank loan]
WHERE MONTH(issue_date) = 12;

/* PMTD Total Funded Amount */
SELECT SUM(loan_amount) AS PMTD_Total_Funded
FROM [Bank loan]
WHERE MONTH(issue_date) = 11;


/* Total Amount Received */
SELECT SUM(total_payment) AS Total_Amount_Received
FROM [Bank loan];

/* MTD Total Amount Received */
SELECT SUM(total_payment) AS MTD_Amount_Received
FROM [Bank loan]
WHERE MONTH(issue_date) = 12;

/* PMTD Total Amount Received */
SELECT SUM(total_payment) AS PMTD_Amount_Received
FROM [Bank loan]
WHERE MONTH(issue_date) = 11;


/* Average Interest Rate */
SELECT AVG(int_rate) * 100 AS Avg_Int_Rate
FROM [Bank loan];

/* MTD Average Interest Rate */
SELECT AVG(int_rate) * 100 AS MTD_Avg_Int_Rate
FROM [Bank loan]
WHERE MONTH(issue_date) = 12;

/* PMTD Average Interest Rate */
SELECT AVG(int_rate) * 100 AS PMTD_Avg_Int_Rate
FROM [Bank loan]
WHERE MONTH(issue_date) = 11;


/* Average DTI Ratio */
SELECT AVG(dti) * 100 AS Avg_DTI
FROM [Bank loan];

/* MTD Average DTI */
SELECT AVG(dti) * 100 AS MTD_Avg_DTI
FROM [Bank loan]
WHERE MONTH(issue_date) = 12;

/* PMTD Average DTI */
SELECT AVG(dti) * 100 AS PMTD_Avg_DTI
FROM [Bank loan]
WHERE MONTH(issue_date) = 11;


/* -----------------------------------------
   SECTION 2 – GOOD LOAN ANALYSIS
----------------------------------------- */

/* Good Loan Percentage  
   (Fully Paid + Current) */
SELECT 
    (COUNT(CASE WHEN loan_status IN ('Fully Paid', 'Current') THEN id END) * 100.0) /
    COUNT(id) AS Good_Loan_Percentage
FROM [Bank loan];

/* Good Loan Applications */
SELECT COUNT(id) AS Good_Loan_Applications
FROM [Bank loan]
WHERE loan_status IN ('Fully Paid', 'Current');

/* Good Loan Funded Amount */
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM [Bank loan]
WHERE loan_status IN ('Fully Paid', 'Current');

/* Good Loan Amount Received */
SELECT SUM(total_payment) AS Good_Loan_Amount_Received
FROM [Bank loan]
WHERE loan_status IN ('Fully Paid', 'Current');


/* -----------------------------------------
   SECTION 3 – BAD LOAN ANALYSIS
----------------------------------------- */

/* Bad Loan Percentage (Charged Off) */
SELECT 
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) /
    COUNT(id) AS Bad_Loan_Percentage
FROM [Bank loan];

/* Bad Loan Applications */
SELECT COUNT(id) AS Bad_Loan_Applications
FROM [Bank loan]
WHERE loan_status = 'Charged Off';

/* Bad Loan Funded Amount */
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount
FROM [Bank loan]
WHERE loan_status = 'Charged Off';

/* Bad Loan Amount Received */
SELECT SUM(total_payment) AS Bad_Loan_Amount_Received
FROM [Bank loan]
WHERE loan_status = 'Charged Off';


/* -----------------------------------------
   SECTION 4 – LOAN STATUS SUMMARY (For KPI Table)
----------------------------------------- */

SELECT
    loan_status,
    COUNT(id) AS Loan_Count,
    SUM(total_payment) AS Total_Amount_Received,
    SUM(loan_amount) AS Total_Funded_Amount,
    AVG(int_rate * 100) AS Avg_Interest_Rate,
    AVG(dti * 100) AS Avg_DTI
FROM [Bank loan]
GROUP BY loan_status;


/* MTD Summary by Loan Status */
SELECT
    loan_status,
    SUM(total_payment) AS MTD_Total_Amount_Received,
    SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM [Bank loan]
WHERE MONTH(issue_date) = 12
GROUP BY loan_status;


/* -----------------------------------------
   SECTION 5 – TREND ANALYSIS
----------------------------------------- */

/* Monthly Report */
SELECT
    MONTH(issue_date) AS Month_Number,
    DATENAME(MONTH, issue_date) AS Month_Name,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM [Bank loan]
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY Month_Number;


/* -----------------------------------------
   SECTION 6 – DEMOGRAPHIC & CATEGORY ANALYSIS
----------------------------------------- */

/* Loan Applications by State */
SELECT
    address_state AS State,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM [Bank loan]
GROUP BY address_state
ORDER BY address_state;

/* Loan Applications by Loan Term */
SELECT
    term AS Term,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM [Bank loan]
GROUP BY term
ORDER BY term;

/* Loan Applications by Employment Length */
SELECT
    emp_length AS Employment_Length,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM [Bank loan]
GROUP BY emp_length
ORDER BY emp_length;

/* Loan Applications by Purpose */
SELECT
    purpose AS Purpose,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM [Bank loan]
GROUP BY purpose
ORDER BY purpose;

/* Loan Applications by Home Ownership */
SELECT
    home_ownership AS Home_Ownership,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM [Bank loan]
GROUP BY home_ownership
ORDER BY home_ownership;


/* Purpose Breakdown for Grade A Loans */
SELECT
    purpose AS Purpose,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM [Bank loan]
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose;
