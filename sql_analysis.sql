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


-- CUMMULATIVE LOAN AMOUNT BY CATEGORICAL VARIABLES

--1

SELECT Property_Area, LoanAmount,

SUM(LoanAmount) OVER (PARTITION BY Property_Area ORDER BY LoanAmount DESC) AS CUMULATIVE_LOAN_AMOUNT_BY_PROPERTY_AREA
FROM loan_data_clean;

--2


SELECT Dependents, LoanAmount,

SUM(LoanAmount) OVER (PARTITION BY Dependents ORDER BY LoanAmount DESC) AS CUMULATIVE_LOAN_AMOUNT_BY_DEPENDENTS
FROM loan_data_clean;

--3


SELECT Gender, LoanAmount,

SUM(LoanAmount) OVER (PARTITION BY Gender ORDER BY LoanAmount DESC) AS CUMULATIVE_LOAN_AMOUNT_BY_GENDER
FROM loan_data_clean;


--4

SELECT Self_Employed, LoanAmount,

SUM(LoanAmount) OVER (PARTITION BY Self_Employed ORDER BY LoanAmount ASC) AS CUMULATIVE_LOAN_AMOUNT_BY_SELF_EMPLOYED
FROM loan_data_clean;

-- MOVING AVERAGE OF LOAN AMOUNT AND APPLICANT INCOME

--1

SELECT LoanAmount,

AVG(LoanAmount) OVER (ORDER BY LoanAmount ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS MOVING_AVERAGE_LOAN_AMOUNT

FROM loan_data_clean;

--2

SELECT ApplicantIncome, 

AVG(ApplicantIncome) OVER (ORDER BY ApplicantIncome ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS MOVING_AVERAGE_APPLICANT_INCOME

FROM loan_data_clean;

-- INCOME QUARTILES

SELECT ApplicantIncome, LoanAmount,

NTILE(4) OVER (ORDER BY ApplicantIncome) as INCOME_QUARTILE

FROM loan_data_clean;

--CTEs FOR AVERAGE LOAN AMOUNTS FOR CATEGORICAL VARIABLES

--1

WITH AVERAGE_LOAN_AMOUNT AS (
    SELECT Property_Area, AVG(LoanAmount) as AVERAGE_LOAN_AMOUNT
    FROM loan_data_clean
    GROUP BY Property_Area
)
SELECT * FROM AVERAGE_LOAN_AMOUNT

--2

WITH AVERAGE_LOAN_AMOUNT AS (
    SELECT Self_Employed, AVG(LoanAmount) as AVERAGE_LOAN_AMOUNT
    FROM loan_data_clean
    GROUP BY Self_Employed
)
SELECT * FROM AVERAGE_LOAN_AMOUNT

--3

WITH AVERAGE_LOAN_AMOUNT AS (
    SELECT Gender, AVG(LoanAmount) as AVERAGE_LOAN_AMOUNT
    FROM loan_data_clean
    GROUP BY Gender
)
SELECT * FROM AVERAGE_LOAN_AMOUNT

--4

WITH AVERAGE_LOAN_AMOUNT AS (
    SELECT Loan_Status, AVG(LoanAmount) as AVERAGE_LOAN_AMOUNT
    FROM loan_data_clean
    GROUP BY Loan_Status
)
SELECT * FROM AVERAGE_LOAN_AMOUNT

--5

WITH AVERAGE_LOAN_AMOUNT AS (
    SELECT Dependents, AVG(LoanAmount) as AVERAGE_LOAN_AMOUNT
    FROM loan_data_clean
    GROUP BY Dependents
)
SELECT * FROM AVERAGE_LOAN_AMOUNT

--6

WITH AVERAGE_LOAN_AMOUNT AS (
    SELECT Gender, AVG(LoanAmount) as AVERAGE_LOAN_AMOUNT
    FROM loan_data_clean
    GROUP BY Gender
)
SELECT * FROM AVERAGE_LOAN_AMOUNT

--CTEs FOR THE COUNT OF LOAN APPROVALS FOR EACH CATEGORICAL COLUMN

--1


WITH APPROVED_LOANS AS (
    SELECT * FROM loan_data_clean WHERE Loan_Status = 1
)
SELECT Property_Area, COUNT(*) AS COUNT_OF_APPROVALS

FROM APPROVED_LOANS GROUP BY Property_Area;

--2

WITH APPROVED_LOANS AS (
    SELECT * FROM loan_data_clean WHERE Loan_Status = 1
)
SELECT Gender, COUNT(*) AS COUNT_OF_APPROVALS

FROM APPROVED_LOANS GROUP BY Gender;

--3

WITH APPROVED_LOANS AS (
    SELECT * FROM loan_data_clean WHERE Loan_Status = 1
)
SELECT Self_Employed, COUNT(*) AS COUNT_OF_APPROVALS

FROM APPROVED_LOANS GROUP BY Self_Employed;

--4

WITH APPROVED_LOANS AS (
    SELECT * FROM loan_data_clean WHERE Loan_Status = 1
)
SELECT Dependents, COUNT(*) AS COUNT_OF_APPROVALS

FROM APPROVED_LOANS GROUP BY Dependents;

--CTE ANALYSIS FOR APPROVED LOANS STATISTICS FOR CATEGORICAL COLUMNS

--1

WITH LOAN_INCOME_RATIO AS (
    SELECT LoanAmount, ApplicantIncome, Gender, Dependents, LoanAmount/ApplicantIncome AS Ratio
    FROM loan_data_clean WHERE ApplicantIncome > 0 AND LoanAmount > 0
)
SELECT * FROM LOAN_INCOME_RATIO WHERE Ratio > 0.5 AND Gender=0 AND Dependents=0; 


--2

WITH LOAN_INCOME_RATIO AS (
    SELECT LoanAmount, ApplicantIncome, Property_Area, LoanAmount/ApplicantIncome AS Ratio
    FROM loan_data_clean WHERE ApplicantIncome > 0 AND LoanAmount > 0
)
SELECT * FROM LOAN_INCOME_RATIO WHERE Ratio < 0.5 AND Property_Area=0; 


-- DEFAULT RATE ANALYSIS FOR DIFFERENT CATEGORICAL FEATURES

--1

WITH defaults AS (

    SELECT Education, SUM(CASE WHEN Loan_Status=0 THEN 1 ELSE 0 END) AS defaults,
    COUNT(*) AS total
    FROM loan_data_clean GROUP BY Education
)
SELECT Education, defaults*100.0/total as Default_Rate FROM defaults;

--2

WITH defaults AS (

    SELECT Gender, SUM(CASE WHEN Loan_Status=0 THEN 1 ELSE 0 END) AS defaults,
    COUNT(*) AS total
    FROM loan_data_clean GROUP BY Gender
)
SELECT Gender, defaults*100.0/total as Default_Rate FROM defaults;

--3

WITH defaults AS (

    SELECT Dependents, SUM(CASE WHEN Loan_Status=0 THEN 1 ELSE 0 END) AS defaults,
    COUNT(*) AS total
    FROM loan_data_clean GROUP BY Dependents
)
SELECT Dependents, defaults*100.0/total as Default_Rate FROM defaults;

--4

WITH defaults AS (

    SELECT Self_Employed, SUM(CASE WHEN Loan_Status=0 THEN 1 ELSE 0 END) AS defaults,
    COUNT(*) AS total
    FROM loan_data_clean GROUP BY Self_Employed
)
SELECT Self_Employed, defaults*100.0/total as Default_Rate FROM defaults;


--5

WITH defaults AS (

    SELECT Property_Area, SUM(CASE WHEN Loan_Status=0 THEN 1 ELSE 0 END) AS defaults,
    COUNT(*) AS total
    FROM loan_data_clean GROUP BY Property_Area
)
SELECT Property_Area, defaults*100.0/total as Default_Rate FROM defaults;


-- LOAN TERM CATEGORIZATION AND COUNT 

SELECT CASE
    WHEN Loan_Amount_Term <= 180 THEN "Short"
    WHEN Loan_Amount_Term <= 360 THEN "Medium"
    ELSE "Long"
    END Loan_Term_Category,
    COUNT(*) AS Count
FROM loan_data_clean

GROUP BY Loan_Term_Category;


-- LOAN APPROVAL RATES BY INCOME BANDS

SELECT CASE 
    WHEN ApplicantIncome < 100 THEN "Low"
    WHEN ApplicantIncome BETWEEN 100 and 200 THEN "MEDIUM" 
    ELSE "High" 
    END AS Income_bands,

    SUM(CASE WHEN Loan_Status=1 THEN 1 ELSE 0 END)*100.0/COUNT(*) AS Loan_Approval_Rate
FROM loan_data_clean
GROUP BY Income_bands;

-- BANDING AND COUNT FOR NUMBER OF DEPENDENTS

SELECT CASE
        WHEN Dependents = '0' THEN 'No Dependents'
        WHEN Dependents = '1' THEN 'One'
     ELSE 'Multiple'
     END AS Dependents_Category,
     COUNT(*) AS Count
FROM loan_data_clean

GROUP BY Dependents_category;