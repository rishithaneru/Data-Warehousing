This project showcases my ability to design and implement a scalable data warehouse solution, addressing real-world business needs. By leveraging my skills in data cleaning, transformation, and SQL development, I was able to provide actionable insights, that could drive informed decision-making and business growth.

# Project Overview
  In this project, I designed and implemented a comprehensive data warehouse solution for Health Options Inc., a company with multiple locations across the United States. The goal was   to build a robust data warehouse to support executive decision-making and business intelligence needs. The project involved data cleaning, transformation, and loading (ETL)          processes, as well as the creation of fact and dimension tables to facilitate insightful analysis and reporting.

# Key SQL Files
  1) DataWarehouse.sql: Contains statements to drop and create tables in the data warehouse, along with the code for creating the stored procedure of the DateMaster table.
  2) ExecutiveQuestions.sql: Contains statements to drop and create views for answering executive questions.

# Case Requirements
  The executive management team at Health Options Inc. needed to address several critical business questions:

  1) Top Locations by Profit: Identify the top 3 locations in terms of profit annually, monthly, weekly, and daily.
  2) Customer Count: Determine the number of customers served by each location on an annual, monthly, weekly, and daily basis.
  3) Product Popularity: List the top 10 most popular products sold at each location annually, monthly, weekly, and daily.
  4) Product Sales Analysis: Identify products with no or minimal sales.
  5) Drive-Thru Impact: Assess how the number of drive-thru lanes affects sales.

# Data Specifics
  Transaction Data: The dataset consisted of 96,577 sales transactions from 2022, encompassing data from three separate systems.
  Data Quality Issues: The data contained duplicates, null values, and inaccuracies that needed to be addressed during the ETL process.

# Approach and Solution

 5. Data Diagram
  
![alt text](https://github.com/rishithaneru/Data-Warehousing/blob/main/Data_Diagram.png)

  
  1. Data Inspection and Cleaning
  
  I began by inspecting the data to identify available fields, potential issues, and missing information. The initial data analysis highlighted duplicates, null values, and   inconsistent entries. The data cleaning process included:
      1) Removing duplicate records, reducing the total transaction count from 96,577 to 85,584.
      2) Handling null values and correcting inaccuracies in product information.
 
  2. Data Warehouse Design
  
  The design of the data warehouse involved creating well-structured fact and dimension tables. The schema was optimized to support complex queries and efficient data retrieval. Key   tables included:
      1) Fact Table: Containing detailed transaction data.
      2) Dimension Tables: Including dimensions for products, locations, and time.
  
  3. ETL Process
  
  The ETL process was designed and executed using SQL Server Integration Services (SSIS). The steps included:
      1) Extraction: Importing data from the original source tables.
      2) Transformation: Cleaning and transforming the data to ensure consistency and accuracy.
      3) Loading: Populating the fact and dimension tables in the data warehouse.
  
  4. SQL Views and Reporting
  
  To address the executive questions, I created SQL views that joined the fact and dimension tables. These views enabled the generation of detailed reports and dashboards, providing    insights into the key business metrics.
  
 
