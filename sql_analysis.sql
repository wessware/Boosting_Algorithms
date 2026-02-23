--SQL QUERIES FOR LOAN APPROVAL RATES BY CATEGORICAL VARIABLES

--1 

SELECT Property_Area,

SUM(CASE WHEN Loan_Status = 1 THEN 1 ELSE 0 END)*100 / (SELECT COUNT(*) FROM loan_data_clean) AS Approval_by_Property_Area

FROM loan_data_clean

GROUP BY Property_Area;

--2 


SELECT Dependents,

SUM(CASE WHEN Loan_Status = 1 THEN 1 ELSE 0 END)*100 / (SELECT COUNT(*) FROM loan_data_clean) AS Approval_by_Dependents

FROM loan_data_clean

GROUP BY Dependents;

--3

SELECT Married,

SUM(CASE WHEN Loan_Status = 1 THEN 1 ELSE 0 END)*100 / (SELECT COUNT(*) FROM loan_data_clean) AS Approval_by_Marital_Status

FROM loan_data_clean

GROUP BY Married;

--4

SELECT Education,

SUM(CASE WHEN Loan_Status = 1 THEN 1 ELSE 0 END)*100 / (SELECT COUNT(*) FROM loan_data_clean) AS Approval_by_Education

FROM loan_data_clean

GROUP BY Education;

--5

SELECT Self_Employed,

SUM(CASE WHEN Loan_Status = 1 THEN 1 ELSE 0 END)*100 / (SELECT COUNT(*) FROM loan_data_clean) AS Approval_by_Employment_Status

FROM loan_data_clean

GROUP BY Self_Employed;


--LOAN TO INCOME RATIO ANALYSIS - ABOVE DATASET AVERAGE

SELECT * 

FROM loan_data_clean

WHERE LoanAmount / ApplicantIncome > (
    SELECT AVG(LoanAmount / ApplicantIncome) 
    FROM loan_data_clean WHERE ApplicantIncome > 0 AND LoanAmount > 0

);
