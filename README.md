# Data-warehouse-project and analytics
Welcome to the data-warehouse-project and analytics
# Overview
This project focuses on building a modern data warehouse using SQL Server to consolidate sales data from multiple source systems, enabling advanced analytical reporting and data-driven decision-making.
The project is divided into two main phases: Data Engineering (building the data warehouse) and Data Analysis (creating BI reports and SQL analytics).
# Phase 1: Data Engineering (Data Warehouse Setup)
# Objectives & Specifications
    • Data Sources: Import and integrate data from two source systems (ERP and CRM) provided as CSV files.
    • Data Quality: Cleanse and resolve data quality issues prior to analysis (e.g., deduplication, handling missing values, standardizing formats).
    • Integration: Combine both sources into a single, user-friendly data model designed specifically for analytical queries.
    • Scope: Focus on the latest dataset only; historization of data is not required for this iteration.
    • Documentation: Provide clear documentation of the data model to support both business stakeholders and analytics teams.
  # Execution Roadmap
      • Star Schema Design: Create a unified data model tailored for analytics. This will typically feature a central Fact_Sales table surrounded by dimensions such as Dim_Customer (from the CRM), Dim_Product (from the ERP), and Dim_Date.
    • ETL Strategy: Develop the extraction, transformation, and loading process to handle the CSV files, resolving primary and foreign key mismatches between the ERP and CRM systems.
    • Data Dictionary: Draft documentation mapping raw source fields to the final warehouse schema, ensuring business definitions are clear and accessible.
# Phase 2: Data Analysis (BI Analytics & Reporting)
# Objectives
Develop SQL-based analytics to deliver detailed insights that empower stakeholders with key business metrics, enabling data-driven decisions and strategic planning.
# Focus Areas & Execution Roadmap
    • Customer Behavior: Develop SQL scripts to calculate key metrics such as Customer Lifetime Value (CLV), purchasing frequency, retention rates, and average order value.
    • Product Performance: Write queries to identify top-selling items, slow movers, profit margins, and cross-selling patterns.
    • Sales Trends: Utilize time-series analytics and SQL window functions to track month-over-month growth, rolling averages, seasonality, and regional performance.

