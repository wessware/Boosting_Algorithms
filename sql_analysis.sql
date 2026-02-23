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

-- CTEs for APPROVALS BY CATEGORICAL VARIABLES

--1 

WITH Approved AS (
    SELECT * 
    FROM loan_data_clean
    WHERE Loan_Status = 1
)
SELECT Property_Area, COUNT(*) as Approved_by_Property_Area
FROM Approved 
GROUP BY Property_Area;

--2

WITH Approved AS (
    SELECT * 
    FROM loan_data_clean
    WHERE Loan_Status = 1
)
SELECT Gender, COUNT(*) as Approvals_by_Gender
FROM Approved 
GROUP BY Gender;

--3

WITH Approved AS (
    SELECT * 
    FROM loan_data_clean
    WHERE Loan_Status = 1
)
SELECT Married, COUNT(*) as Approval_by_Marital_Status
FROM Approved 
GROUP BY Married;

--4

WITH Approved AS (
    SELECT * 
    FROM loan_data_clean
    WHERE Loan_Status = 1
)
SELECT Self_Employed, COUNT(*) as Approvals_by_Employment_Status
FROM Approved 
GROUP BY Self_Employed;

--5

WITH Approved AS (
    SELECT * 
    
    FROM loan_data_clean

    WHERE Loan_Status = 1
)
SELECT Dependents, COUNT(*) as Approval_by_Number_of_Dependents

FROM Approved 

GROUP BY Dependents;


--- CTEs for AVERAGE LOAN AMOUNT BY CATEGORICAL VARIABLES

--1

WITH AVG_LOANS AS (
    SELECT Property_Area, AVG(LoanAmount) as AVERAGE_LOAN_AMOUNT

    FROM loan_data_clean

    WHERE ApplicantIncome > 0 AND LoanAmount > 0

    GROUP BY Property_Area
)
SELECT * FROM AVG_LOANS;

--2 

WITH AVG_LOANS AS (

    SELECT Gender, AVG(LoanAmount) as AVERAGE_LOAN_AMOUNT

    FROM loan_data_clean

    WHERE ApplicantIncome > 0 AND LoanAmount > 0

    GROUP BY Gender
)
SELECT * FROM AVG_LOANS;


--3

WITH AVG_LOANS AS (
    SELECT Dependents, AVG(LoanAmount) as AVERAGE_LOAN_AMOUNT

    FROM loan_data_clean

    WHERE ApplicantIncome > 0 AND LoanAmount > 0

    GROUP BY Dependents
)
SELECT * FROM AVG_LOANS;

--4

WITH AVG_LOANS AS (
    SELECT Self_Employed, AVG(LoanAmount) as AVERAGE_LOAN_AMOUNT

    FROM loan_data_clean

    WHERE ApplicantIncome > 0 AND LoanAmount > 0

    GROUP BY Self_Employed
)
SELECT * FROM AVG_LOANS;

--RANKING APPLICANTS BY INCOME AND LOAN AMOUNT ON CATEGORICAL VARIABLES

--1

SELECT ApplicantIncome, LoanAmount, Gender,

RANK() OVER (ORDER BY ApplicantIncome DESC) AS Applicant_Income_Ranking

FROM loan_data_clean;


--2

SELECT Gender, ApplicantIncome, LoanAmount, 

RANK() OVER (ORDER BY Gender DESC) AS Applicant_Income_Ranking

FROM loan_data_clean;

--3

SELECT Dependents, ApplicantIncome, LoanAmount, Gender,

RANK() OVER (ORDER BY Dependents ASC) AS Applicant_Income_Ranking

FROM loan_data_clean;

--4

SELECT Property_Area, LoanAmount, ApplicantIncome, Gender,

ROW_NUMBER() OVER (PARTITION BY Property_Area ORDER BY ApplicantIncome DESC) AS RANK_OF_INCOME_BY_PROPERTY_AREA

FROM loan_data_clean;