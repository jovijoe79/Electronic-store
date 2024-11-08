SELECT *
FROM electronic_sales;

-- DATA CLEANING
-- FIRST CREATE A NEW TABLE TO PRESERVE THE ORIGINAL DATA
CREATE TABLE electronic_sales_staging
LIKE electronic_sales;

INSERT INTO electronic_sales_staging
SELECT * 
FROM electronic_sales;

SELECT *
FROM electronic_sales_staging;

-- NEXT WE CHECK FOR DUPLICATES
WITH CTE AS
(
SELECT *, 
ROW_NUMBER() 
OVER(PARTITION BY Age, Gender, Product_Type, SKU, Rating, Order_Status, Payment_Method, Total_Price, Unit_Price, 
Quantity, Purchase_Date, Shipping_Type, Add_ons_Purchased, Add_on_Total) AS row_num
FROM electronic_sales_staging
)
SELECT *
FROM CTE
WHERE row_num > 1;

-- since no duplicates we start looking through column by column
SELECT *
FROM electronic_sales_staging;

-- REMOVING DATA THAT HAS ANY COLUMN WITH NULLS
DELETE 
FROM electronic_sales_staging
WHERE Age = ''
OR Gender = ''
OR Loyalty_Member = ''
OR Product_Type = ''
OR SKU = ''
OR Rating = ''
OR Order_Status = ''
OR Payment_Method = ''
OR Total_Price = ''
OR Unit_Price = ''
OR Quantity = ''
OR Purchase_Date = ''
OR Shipping_Type = ''
OR Add_ons_Purchased = ''
OR Add_on_Total = '';

SELECT *
FROM electronic_sales_staging;

-- CHANGE THE DATE DATA TYPE
SELECT Purchase_Date, STR_TO_DATE(Purchase_Date, '%m/%d/%Y') AS Purchase_Date
FROM electronic_sales_staging;

UPDATE electronic_sales_staging
SET Purchase_Date = STR_TO_DATE(Purchase_Date, '%m/%d/%Y');

SELECT * 
FROM electronic_sales_staging;

ALTER TABLE electronic_sales_staging
MODIFY COLUMN Purchase_Date DATE;


-- EXPLORATORY ANALYSIS
-- 1) WHAT PRODUCT SOLD MORE(COMPLETED)
SELECT DISTINCT Product_Type, COUNT(Order_Status)
FROM electronic_sales_staging
WHERE Order_Status = 'Completed'
GROUP BY Product_Type
ORDER BY 2 DESC;

-- 2) WHAT PRODUCT SOLD MORE (CANCELLED)
SELECT DISTINCT Product_Type, COUNT(Order_Status)
FROM electronic_sales_staging
WHERE Order_Status = 'Cancelled'
GROUP BY Product_Type
ORDER BY 2 DESC;

-- 3) WHAT IS THE MOST COMMON PAYMENT METHOD
SELECT DISTINCT Payment_Method, COUNT(Payment_Method)
FROM electronic_sales_staging
GROUP BY Payment_Method
ORDER BY 2 DESC;

SELECT *
FROM electronic_sales_staging;

-- 4) WHAT PRODUCT HAD THE BEST SHIPPING TYPE BY RATING
SELECT DISTINCT Product_Type, Shipping_Type, Rating, COUNT(Shipping_Type) AS Shipping_type_count
FROM electronic_sales_staging
GROUP BY Product_Type, Rating, Shipping_Type
ORDER BY 1 ASC;

-- 5) WHAT PRODUCT WAS RATED THE MOST
SELECT DISTINCT Product_Type, Rating, COUNT(Rating) AS RATE
FROM electronic_sales_staging
GROUP BY Product_Type, Rating
ORDER BY 2 DESC;

SELECT *
FROM electronic_sales_staging;

-- 6) WHAT PRODUCT HAD THE MOST LOYALTY MEMBERS
SELECT DISTINCT Product_Type, COUNT(Loyalty_Member)
FROM electronic_sales_staging
WHERE Loyalty_Member = 'Yes'
GROUP BY Product_Type
ORDER BY 2 DESC;

-- 7) WHAT ARE MALES BUYING THE MOST 
SELECT DISTINCT Product_Type, Gender, COUNT(Gender)
FROM electronic_sales_staging
WHERE Gender = 'Male'
GROUP BY Product_Type, Gender
ORDER BY 3 DESC;

-- 7) WHAT ARE FEMALES BUYING THE MOST 
SELECT DISTINCT Product_Type, Gender, COUNT(Gender)
FROM electronic_sales_staging
WHERE Gender = 'Female'
GROUP BY Product_Type, Gender
ORDER BY 3 DESC;

SELECT *
FROM electronic_sales_staging;

-- 8) PEOPLE ABOVE 50 WHAT DID THEY BUY THE MOST
SELECT DISTINCT Product_Type, Age, COUNT(Product_Type)
FROM electronic_sales_staging
WHERE Age > 50
GROUP BY Product_Type, Age
ORDER BY 3 DESC;

-- 9) WHAT SOLD THE MOST PRODUCT
SELECT DISTINCT Product_Type, SUM(Total_Price)
FROM electronic_sales_staging
GROUP BY Product_Type
ORDER BY 2 DESC;

-- 10) HOW MANY QUANTITIES OF PRODUCTS WHERE CANCELLED
SELECT DISTINCT Product_Type, Order_Status, SUM(Quantity)
FROM electronic_sales_staging
WHERE Order_Status = 'Cancelled'
GROUP BY Product_Type
ORDER BY 3 DESC;

-- 11) ARE CANCELLED PRODUCTS RATED LOWER?
SELECT DISTINCT Product_Type, Rating, Order_Status, SUM(Rating)
FROM electronic_sales_staging
WHERE Order_Status = 'Cancelled'
GROUP BY Product_Type, Rating
ORDER BY 1 ASC;

SELECT *
FROM electronic_sales_staging;

-- 12) SHIPPING TYPE TO RATING
SELECT DISTINCT Product_Type, Shipping_Type, Rating
FROM electronic_sales_staging
GROUP BY Product_Type, Shipping_Type, Rating
ORDER BY 3 DESC;

-- 13) PRODUCT TO PAYMENT METHOD
SELECT DISTINCT Product_Type, Payment_Method, COUNT(Payment_Method)
FROM electronic_sales_staging
GROUP BY Product_Type, Payment_Method
ORDER BY 1 ASC, 2 ASC, 3 DESC;

SELECT *
FROM electronic_sales_staging;

SELECT Purchase_Date
FROM electronic_sales_staging
ORDER BY 1 DESC;

-- 14) IN WHAT MONTH IN 2024 DID THEY SELL THE MOST
SELECT DISTINCT SUBSTRING(Purchase_Date, 1, 7) AS `MONTH`, SUM(Total_Price)
FROM electronic_sales_staging
WHERE SUBSTRING(Purchase_Date, 1, 7) LIKE '2024%'
GROUP BY `MONTH`
ORDER BY 2 DESC;

SELECT DISTINCT `AGE`
FROM electronic_sales_staging;
