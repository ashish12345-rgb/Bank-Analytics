use bank_analysis;

-- KPI 1 Total Loan Amount
SELECT 
    CONCAT(FORMAT(SUM(loan_amnt) / 1000000, 0), 'M') AS total_loan_amount
FROM mastertable;

-- KPI 2 Total Funded Amount
SELECT 
    CONCAT(FORMAT(SUM(funded_amnt) / 1000000, 0),
            'M') AS total_funded_amount
FROM mastertable;

-- KPI 3 Total no. of Customers
SELECT 
    COUNT(DISTINCT member_id) AS total_customers
FROM mastertable;

-- KPI 4 Average Intrest Rate
SELECT 
    CONCAT(ROUND(AVG(int_rate), 2), '%') AS Average_interest_rate
FROM mastertable;

-- KPI 5 Total Revolve Balance
SELECT 
    CONCAT(FORMAT(SUM(revol_bal) / 1000000, 0), 'M') AS total_revol_balance
FROM mastertable;

-- YEAR WISE LOAN STATUS
SELECT 
    `issue_d - year` AS Year,
    CONCAT(FORMAT(SUM(loan_amnt) / 1000000, 0), 'M') AS Total_loan_amount
FROM mastertable
GROUP BY `issue_d - year`
ORDER BY `issue_d - year`;

-- MONTH WISE LOAN STATUS
SELECT 
    `last_pymnt_d - month` AS payment_month,
    CONCAT(FORMAT(SUM(loan_amnt) / 1000000, 0), 'M') AS total_loan_amount
FROM mastertable
GROUP BY `last_pymnt_d - month`
ORDER BY FIELD(`last_pymnt_d - month`,
'January','February','March','April','May','June','July',
'August','September','October','November','December');


/*GRADE AND SUB GRADE WISE LOAN AMOUNT*/
SELECT 
    grade,
    sub_grade,
    CONCAT(FORMAT(SUM(loan_amnt) / 1000000, 0), 'M') AS Loan_Amount
FROM mastertable
GROUP BY grade , sub_grade
ORDER BY grade , sub_grade;


-- VERIFIED VS NON VERIFIED TOTAL PAYMENT STATUS
SELECT 
    verification_status,
    CONCAT(FORMAT(SUM(total_pymnt) / 1000000, 0),
            'M') AS Total_Payment
FROM mastertable
WHERE verification_status IN ('Verified' , 'Not Verified')
GROUP BY verification_status;

-- HOME OWNERSHIP VS LAST PAYMENT DATE STATUS
SELECT 
    home_ownership,
    `last_pymnt_d _Year`,
    CONCAT(FORMAT(SUM(last_pymnt_amnt) / 1000, 0),
            ' K') AS Total_Last_Payment
FROM mastertable
GROUP BY home_ownership , `last_pymnt_d _Year`
ORDER BY home_ownership;

-- CUSTOM KPIs 
-- Status wise Loan Amount
SELECT 
    loan_status,
    CONCAT(FORMAT(SUM(loan_amnt) / 1000000, 0), 'M') AS total_loan_amount
FROM mastertable
GROUP BY loan_status;

-- TOP 5 PURPOSE WISE FUND AMOUNT
SELECT 
    purpose,
    SUM(funded_amnt) AS total_funded_amount
FROM mastertable
GROUP BY purpose
ORDER BY total_funded_amount DESC
LIMIT 5;

-- STATE WISE NUMBER OF MEMBERS
SELECT 
    addr_state AS State,
    COUNT(DISTINCT member_id) AS Number_of_Members
FROM mastertable
WHERE 
    addr_state IS NOT NULL  
GROUP BY addr_state  
ORDER BY Number_of_Members DESC;