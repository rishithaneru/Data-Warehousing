USE SP23_ksmippili
go

DROP VIEW IF EXISTS ViewAllRecordsinFactTable
DROP VIEW IF EXISTS Top3LocationsbyYear
DROP VIEW IF EXISTS Top3LocationsbyMonth
DROP VIEW IF EXISTS Top3LocationsbyWeek
DROP VIEW IF EXISTS Top3LocationsbyDay
DROP VIEW IF EXISTS CustomersbyLocationAndYear
DROP VIEW IF EXISTS CustomersbyLocationAndMonth
DROP VIEW IF EXISTS CustomersbyLocationAndWeek
DROP VIEW IF EXISTS CustomersbyLocationAndDay
DROP VIEW IF EXISTS PopularProductsbyYear
DROP VIEW IF EXISTS PopularProductsbyMonth
DROP VIEW IF EXISTS PopularProductsbyWeek
DROP VIEW IF EXISTS PopularProductsbyDay
DROP VIEW IF EXISTS ProductSales
DROP VIEW IF EXISTS DrivethruProfits
DROP VIEW IF EXISTS DrivethruSales
go

-- Viewing all records in fact table with all information from dimension tables
CREATE VIEW ViewAllRecordsinFactTable AS
SELECT FactID
	,fact.StoreID
	,fact.ProductID
	,fact.CustomerID
	,fact.DateID
	,fact.LocationID
	,Quantity
	,ProductGrossAmt
	,ProductNetAmt
	,YearsSinceStoreOpened
	,[ReceiptNbr]
    ,[TransTime]
	,[fulldate]
	,[year_nbr]
	,[month_nbr] 
	,[day_nbr]
    ,[qtr]
    ,[day_of_week]
	,[day_of_year]
	,[day_name]
	,[month_name]
	,[City]
	,[State]
    ,[ProductNbr]
	,[MenuName]
	,[ProductDesc]
	,[MenuCategory]
    ,[MenuSubCategory]
	,[DefaultProductPrice]
    ,[StoreNbr]
	,[StoreAddress]
	,[StoreZipCode]
    ,[NbrDriveThruLanes]
    ,[StoreCapacity]
    ,[BuildingType]
FROM Fact_HealthOptionsInc fact
LEFT JOIN Dim_StoreInfo AS store ON fact.StoreID = store.StoreID
LEFT JOIN Dim_DateMaster AS dateM ON fact.DateID = dateM.DateID
LEFT JOIN Dim_LocationMaster AS Location ON fact.LocationID = Location.LocationID
LEFT JOIN Dim_ProductInfo AS product ON fact.ProductID = product.ProductID
LEFT JOIN Dim_CustomerInfo AS customer ON fact.CustomerID = customer.CustomerID


SELECT * FROM ViewAllRecordsinFactTable


-- 1. What are the top 3 locations with respect to profit annually, monthly, weekly and daily?
-- Considering 11 January, 2022	

--Annual
CREATE VIEW Top3LocationsbyYear AS
SELECT
 TOP 3
 store.StoreNbr,
 location.City,
 location.State,
 SUM(fact.ProductNetAmt) AS TotalProfit
FROM
 Fact_HealthOptionsInc AS fact
 LEFT JOIN Dim_StoreInfo AS store ON fact.StoreID = store.StoreID
 LEFT JOIN Dim_DateMaster AS dateMaster ON fact.DateID = dateMaster.DateID
 LEFT JOIN Dim_LocationMaster AS location ON fact.LocationID = location.LocationID
WHERE
 dateMaster.year_nbr = 2022
GROUP BY
 store.StoreNbr,
 location.City,
 location.State
ORDER BY
 TotalProfit DESC;

SELECT * FROM Top3LocationsbyYear

--Monthly
CREATE VIEW Top3LocationsbyMonth AS
SELECT
 TOP 3
 store.StoreNbr,
 location.City,
 location.State,
 SUM(fact.ProductNetAmt) AS TotalProfit
FROM
	Fact_HealthOptionsInc AS fact
 LEFT JOIN Dim_StoreInfo AS store ON fact.StoreID = store.StoreID
 LEFT JOIN Dim_DateMaster AS dateMaster ON fact.DateID = dateMaster.DateID
 LEFT JOIN Dim_LocationMaster AS location ON fact.LocationID = location.LocationID
WHERE
 dateMaster.year_nbr = 2022 AND
 dateMaster.month_nbr = 1  
GROUP BY
 store.StoreNbr,
 location.City,
 location.State
ORDER BY
 TotalProfit DESC;

SELECT * FROM Top3LocationsbyMonth
-- Weekly
CREATE VIEW Top3LocationsbyWeek AS
SELECT
 TOP 3
 store.StoreNbr,
 location.City,
 location.State,
 SUM(fact.ProductNetAmt) AS TotalProfit
FROM
 Fact_HealthOptionsInc AS fact
 LEFT JOIN Dim_StoreInfo AS store ON fact.StoreID = store.StoreID
 LEFT JOIN Dim_DateMaster AS dateMaster ON fact.DateID = dateMaster.DateID
 LEFT JOIN Dim_LocationMaster AS location ON fact.LocationID = location.LocationID
WHERE
 dateMaster.year_nbr = 2022 AND
	DATEPART(week, dateMaster.fulldate) = 3
GROUP BY
 store.StoreNbr,
 location.City,
 location.State
ORDER BY
 TotalProfit DESC;

SELECT * FROM Top3LocationsbyWeek


--Daily
CREATE VIEW Top3LocationsbyDay AS
SELECT
 TOP 3
 store.StoreNbr,
 location.City,
 location.State,
 SUM(fact.ProductNetAmt) AS TotalProfit
FROM
 Fact_HealthOptionsInc AS fact
 LEFT JOIN Dim_StoreInfo AS store ON fact.StoreID = store.StoreID
 LEFT JOIN Dim_DateMaster AS dateMaster ON fact.DateID = dateMaster.DateID
 LEFT JOIN Dim_LocationMaster AS location ON fact.LocationID = location.LocationID
WHERE
 dateMaster.year_nbr = 2022 AND
	dateMaster.day_nbr = 11 
GROUP BY
 store.StoreNbr,
 location.City,
 location.State
ORDER BY
 TotalProfit DESC;

SELECT * FROM Top3LocationsbyDay

--**********************************************************************************************
-- 2. How many customers does each location serve annually, monthly, weekly and daily?
-- By location, we are considering the granularity of a store number
-- However, we also provided the store address, city and state of the store in the View for analysis
-- Considering 11th January, 2022

-- Annually
CREATE VIEW CustomersbyLocationAndYear AS
SELECT
 store.StoreNbr,
 store.StoreAddress,
 location.City,
 location.State,
 COUNT(DISTINCT fact.CustomerID) AS TotalCustomers
FROM
 Fact_HealthOptionsInc AS fact
 LEFT JOIN Dim_StoreInfo AS store ON fact.StoreID = store.StoreID
 LEFT JOIN Dim_DateMaster AS dateMaster ON fact.DateID = dateMaster.DateID
 LEFT JOIN Dim_LocationMaster AS location ON fact.LocationID = location.LocationID
WHERE
 dateMaster.year_nbr = 2022
GROUP BY
 store.StoreNbr,
 store.StoreAddress,
 location.City,
 location.State

SELECT * FROM CustomersbyLocationAndYear
ORDER BY TotalCustomers DESC

-- Monthly
CREATE VIEW CustomersbyLocationAndMonth AS
SELECT
 store.StoreNbr,
 store.StoreAddress,
 location.City,
 location.State,
 COUNT(DISTINCT fact.CustomerID) AS TotalCustomers
FROM
 Fact_HealthOptionsInc AS fact
 LEFT JOIN Dim_StoreInfo AS store ON fact.StoreID = store.StoreID
 LEFT JOIN Dim_DateMaster AS dateMaster ON fact.DateID = dateMaster.DateID
 LEFT JOIN Dim_LocationMaster AS location ON fact.LocationID = location.LocationID
WHERE
 dateMaster.year_nbr = 2022 AND
 dateMaster.month_nbr = 1  
GROUP BY
 store.StoreNbr,
 store.StoreAddress,
 location.City,
 location.State

SELECT * FROM CustomersbyLocationAndMonth
ORDER BY TotalCustomers DESC

-- Weekly
CREATE VIEW CustomersbyLocationAndWeek AS
SELECT
 store.StoreNbr,
 store.StoreAddress,
 location.City,
 location.State,
 COUNT(DISTINCT fact.CustomerID) AS TotalCustomers
FROM
 Fact_HealthOptionsInc AS fact
 LEFT JOIN Dim_StoreInfo AS store ON fact.StoreID = store.StoreID
 LEFT JOIN Dim_DateMaster AS dateMaster ON fact.DateID = dateMaster.DateID
 LEFT JOIN Dim_LocationMaster AS location ON fact.LocationID = location.LocationID
WHERE
  dateMaster.year_nbr = 2022 AND
	DATEPART(week, dateMaster.fulldate) = 3
GROUP BY
 store.StoreNbr,
 store.StoreAddress,
 location.City,
 location.State

SELECT * FROM CustomersbyLocationAndWeek
ORDER BY TotalCustomers DESC

-- Daily
CREATE VIEW CustomersbyLocationAndDay AS
SELECT
 store.StoreNbr,
 store.StoreAddress,
 location.City,
 location.State,
 COUNT(DISTINCT fact.CustomerID) AS TotalCustomers
FROM
 Fact_HealthOptionsInc AS fact
 LEFT JOIN Dim_StoreInfo AS store ON fact.StoreID = store.StoreID
 LEFT JOIN Dim_DateMaster AS dateMaster ON fact.DateID = dateMaster.DateID
 LEFT JOIN Dim_LocationMaster AS location ON fact.LocationID = location.LocationID
WHERE
 dateMaster.year_nbr = 2022 AND
	dateMaster.day_nbr = 11 
GROUP BY
 store.StoreNbr,
 store.StoreAddress,
 location.City,
 location.State

SELECT * FROM CustomersbyLocationAndDay
ORDER BY TotalCustomers DESC

--*********************************************************************************************************
-- 3. What are the top 10 most popular products sold by location annually, monthly, weekly and daily? 
-- Considering 11th January, 2022 as our reference date
-- We have also considered the storenumber 35350 as the reference location
-- We are also providing MenuCategory and MenuSubCategory for added analysis

-- Annually
CREATE VIEW PopularProductsbyYear AS
SELECT TOP 10
	product.MenuName,
	product.MenuCategory,
	product.MenuSubCategory,
 SUM(fact.Quantity) AS AnnualSales
FROM
 Fact_HealthOptionsInc AS fact
 LEFT JOIN Dim_StoreInfo AS store ON fact.StoreID = store.StoreID
 LEFT JOIN Dim_ProductInfo AS product ON fact.ProductID = product.ProductID
 LEFT JOIN Dim_DateMaster AS dateMaster ON fact.DateID = dateMaster.DateID
WHERE
 dateMaster.year_nbr = 2022 and
	Store.StoreNbr = 35350
GROUP BY
 product.MenuName,
 product.MenuCategory,
 product.MenuSubCategory
ORDER BY
 AnnualSales DESC

SELECT * FROM PopularProductsbyYear

-- Monthly 
CREATE VIEW PopularProductsbyMonth AS
SELECT TOP 10
	product.MenuName,
	product.MenuCategory,
	product.MenuSubCategory
 SUM(fact.Quantity) AS MonthlySales
FROM
 Fact_HealthOptionsInc AS fact
 LEFT JOIN Dim_StoreInfo AS store ON fact.StoreID = store.StoreID
 LEFT JOIN Dim_ProductInfo AS product ON fact.ProductID = product.ProductID
 LEFT JOIN Dim_DateMaster AS dateMaster ON fact.DateID = dateMaster.DateID
WHERE
 dateMaster.year_nbr = 2022 AND
 dateMaster.month_nbr = 1 AND 
	Store.StoreNbr = 35350
GROUP BY
	product.MenuName,
	product.MenuCategory,
	product.MenuSubCategory
ORDER BY
 MonthlySales DESC

SELECT * FROM PopularProductsbyMonth

-- Weekly
CREATE VIEW PopularProductsbyWeek AS
SELECT TOP 10
 product.MenuName,
 product.MenuCategory,
 product.MenuSubCategory,
 SUM(fact.Quantity) AS WeeklySales
FROM
 Fact_HealthOptionsInc AS fact
 LEFT JOIN Dim_StoreInfo AS store ON fact.StoreID = store.StoreID
 LEFT JOIN Dim_ProductInfo AS product ON fact.ProductID = product.ProductID
 LEFT JOIN Dim_DateMaster AS dateMaster ON fact.DateID = dateMaster.DateID
WHERE
 dateMaster.year_nbr = 2022 AND
	DATEPART(week, dateMaster.fulldate) = 3 AND
	store.StoreNbr = 35350
GROUP BY
 product.MenuName,
 product.MenuCategory,
 product.MenuSubCategory
ORDER BY
 WeeklySales DESC;


SELECT * FROM PopularProductsbyWeek

-- Daily
CREATE VIEW PopularProductsbyDay AS
SELECT TOP 10
 product.MenuName,
 product.MenuCategory,
 product.MenuSubCategory,
 SUM(fact.Quantity) AS WeeklySales
FROM
 Fact_HealthOptionsInc AS fact
 LEFT JOIN Dim_StoreInfo AS store ON fact.StoreID = store.StoreID
 LEFT JOIN Dim_ProductInfo AS product ON fact.ProductID = product.ProductID
 LEFT JOIN Dim_DateMaster AS dateMaster ON fact.DateID = dateMaster.DateID
WHERE
 dateMaster.year_nbr = 2022 AND
	dateMaster.day_nbr = 11 AND 
	store.StoreNbr = 35350
GROUP BY
 product.MenuName,
 product.MenuCategory,
 product.MenuSubCategory
ORDER BY
 WeeklySales DESC;

SELECT * FROM PopularProductsbyDay

-- ************************************************************************************************
-- 4. Which products have no sales or few sales?
-- We considered Product Gross Amount as sales figure of interest
-- However, one could also consider volume (quantity) as a figure of interest
-- We did not consider a specific date/period of analysis; However one could use Date Dimension table to slice the data in periods
-- We also did not consider a specific location

CREATE VIEW ProductSales AS
SELECT 
TOP 20 
	product.MenuName, 
	product.MenuCategory,
	product.MenuSubCategory,
	SUM(fact.ProductGrossAmt) as TotalSales
FROM Fact_HealthOptionsInc AS fact
LEFT JOIN Dim_ProductInfo AS product ON fact.ProductID = product.ProductID
GROUP BY 
	product.MenuName,
	product.MenuCategory,
	product.MenuSubCategory
ORDER BY TotalSales

SELECT * FROM ProductSales

-- ***********************************************************************************************************
-- 5. How is the number of drive-thru lanes impacting sales?
-- It is possible that number of drive through lanes depends on business strategy
-- For instance, certain locations might have higher drive-thru-lanes due to higher traffic
-- Or number of drive through lanes also depends on the year the store opened
-- In our VIEW statement, we have not considered these effects

-- Using Net Amount to calculate the impact of number of drive through lanes on Net Profit

CREATE VIEW DriveThruProfit AS
WITH ProfitandSalesPerCustomer AS (
  SELECT 
    Customer.CustomerID,  
    fact.StoreID, 
    SUM(ProductGrossAmt) AS ProductGrossAmt,
    SUM(ProductNetAmt) AS ProductNetAmt
  FROM Fact_HealthOptionsInc AS fact
  LEFT JOIN Dim_CustomerInfo AS Customer 
    ON fact.CustomerID = Customer.CustomerID
  GROUP BY 
    Customer.CustomerID, 
    fact.LocationID, 
    fact.StoreID
)
SELECT 
	store.NbrDriveThruLanes as NumberOfLanes, 
	SUM(ProductNetAmt) as TotalNetProfit, 
	AVG(ProductNetAmt) as AverageNetProfit
FROM ProfitandSalesPerCustomer 
LEFT JOIN Dim_StoreInfo AS store 
  ON ProfitandSalesPerCustomer.StoreID = store.StoreID
GROUP BY
	store.NbrDriveThruLanes

CREATE VIEW DriveThruSales AS
WITH ProfitandSalesPerCustomer AS (
  SELECT 
    Customer.CustomerID,  
    fact.StoreID, 
    SUM(ProductGrossAmt) AS ProductGrossAmt,
    SUM(ProductNetAmt) AS ProductNetAmt
  FROM Fact_HealthOptionsInc AS fact
  LEFT JOIN Dim_CustomerInfo AS Customer 
    ON fact.CustomerID = Customer.CustomerID
  GROUP BY 
    Customer.CustomerID, 
    fact.LocationID, 
    fact.StoreID
)
SELECT 
	store.NbrDriveThruLanes as NumberOfLanes, 
	SUM(ProductGrossAmt) as TotalSales, 
	AVG(ProductGrossAmt) as AverageSales
FROM ProfitandSalesPerCustomer 
LEFT JOIN Dim_StoreInfo AS store 
  ON ProfitandSalesPerCustomer.StoreID = store.StoreID
GROUP BY
	store.NbrDriveThruLanes

SELECT * FROM DriveThruProfit

SELECT * FROM DriveThruSales

