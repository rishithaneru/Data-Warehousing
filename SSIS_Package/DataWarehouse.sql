-- Creating Fact and Dimension tables

use SP23_ksmippili
go 

DROP TABLE if exists Fact_HealthOptionsInc
DROP TABLE if exists Dim_StoreInfo
DROP TABLE if exists Dim_ProductInfo
DROP TABLE if exists Dim_CustomerInfo
DROP TABLE if exists Dim_DateMaster
DROP TABLE if exists Dim_LocationMaster 
go

CREATE TABLE Dim_StoreInfo (
    StoreID int NOT NULL IDENTITY(1,1) CONSTRAINT pkStoreID PRIMARY KEY,
    StoreNbr int NOT NULL,
	StoreAddress varchar(255),
    StoreZipCode varchar(20), 
    NbrDriveThruLanes int NOT NULL,
	StoreCapacity int NOT NULL,
	BuildingType varchar(50),
)

CREATE TABLE Dim_LocationMaster (
    LocationID int NOT NULL IDENTITY(1,1) CONSTRAINT pkLocationID PRIMARY KEY,
    City varchar(255) NOT NULL, 
    State varchar(255) NOT NULL
)

CREATE TABLE Dim_ProductInfo (
	ProductID int NOT NULL IDENTITY(1,1) CONSTRAINT pkProductID PRIMARY KEY,
    ProductNbr int NOT NULL,
	MenuName varchar(255),
	ProductDesc varchar(255),
	MenuCategory varchar(255),
	MenuSubCategory varchar(255),
	DefaultProductPrice DECIMAL(18, 4) NOT NULL
)

CREATE TABLE Dim_CustomerInfo (
	CustomerID int NOT NULL IDENTITY(1,1) CONSTRAINT pkCustomerID PRIMARY KEY,
	ReceiptNbr int NOT NULL,
	TransTime time(7),
)

CREATE TABLE Dim_DateMaster (
   DateID int PRIMARY KEY,
   fulldate datetime,
   year_nbr int,
   month_nbr int,
   day_nbr int,
   qtr int,
   day_of_week int,
   day_of_year int,
   day_name char(15),
   month_name char(15)
)


CREATE TABLE Fact_HealthOptionsInc (
	FactID int not null Identity(1,1) Constraint pkFactID Primary Key,
	StoreID int not null Constraint fkFact_HealthOptionsIncXDim_StoreInfo foreign key references Dim_StoreInfo(StoreID), 
	ProductID int not null Constraint fkFact_HealthOptionsIncXDim_ProductInfo foreign key references Dim_ProductInfo(ProductID), 
	CustomerID int not null Constraint fkFact_HealthOptionsIncXDim_CustomerInfo foreign key references Dim_CustomerInfo(CustomerID), 
	DateID int not null Constraint fkFact_HealthOptionsIncXDim_DateMaster foreign key references Dim_DateMaster(DateID), 
	LocationID int not null Constraint fkFact_HealthOptionsIncXDim_LocationMaster foreign key references Dim_LocationMaster(LocationID), 
	Quantity int NOT NULL,
	ProductGrossAmt DECIMAL(18, 4) NOT NULL,
	ProductNetAmt DECIMAL(18, 4) NOT NULL,
	YearsSinceStoreOpened int NOT NULL,
)


-- Stored Procedure to Load DateMaster Dimension table

DROP PROCEDURE IF EXISTS spLoadDateMasterDim
GO

CREATE PROCEDURE spLoadDateMasterDim
AS
BEGIN
    DECLARE @date DATE = '2021-01-01'
    DECLARE @DateID INT = 1

    WHILE (@date <= '2023-12-31')
    BEGIN
        INSERT INTO Dim_DateMaster (DateID, fulldate, year_nbr, month_nbr, day_nbr, qtr, day_of_week, day_of_year, day_name, month_name)
        VALUES (@DateID, CONVERT(DATETIME, @date), YEAR(@date), MONTH(@date), DAY(@date), DATEPART(quarter, @date), DATEPART(dw, @date), DATEPART(dy, @date), DATENAME(weekday, @date), DATENAME(month, @date))

        SET @date = DATEADD(day, 1, @date)
        SET @DateID = @DateID + 1
    END
END
