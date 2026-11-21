/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Purpose:
    Defines the physical table schemas for raw CRM and ERP ingestion in the 
    'Bronze' layer.

Design Notes:
    - Idempotency: Drops existing tables before recreation so schema updates 
      can be applied cleanly.
    - Raw Landing Pattern: Omits PRIMARY KEY, FOREIGN KEY, and NOT NULL 
      constraints to prevent ingestion failures on dirty source records. Data 
      integrity rules are enforced downstream in the Silver layer.
    - Date Handling: Raw integer dates in sales_details (YYYYMMDD) are stored 
      as INT to prevent bulk-load conversion errors on malformed dates (e.g., 0).
===============================================================================
*/

-- ----------------------------------------------------------------------------
-- CRM Source Tables
-- ----------------------------------------------------------------------------
IF OBJECT_ID('Bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE Bronze.crm_cust_info;
GO

CREATE TABLE Bronze.crm_cust_info (
    cst_id             NVARCHAR(50),
    cst_key            NVARCHAR(50),
    cst_firstname      NVARCHAR(50),
    cst_lastname       NVARCHAR(50),
    cst_marital_status NVARCHAR(20),
    cst_gndr           NVARCHAR(10),
    cst_create_date    DATE
);
GO

IF OBJECT_ID('Bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE Bronze.crm_prd_info;
GO

CREATE TABLE Bronze.crm_prd_info (
    prd_id         NVARCHAR(50),
    prd_key        NVARCHAR(50),
    prd_name       NVARCHAR(100),
    prd_cost       DECIMAL(10,2),
    prd_line       NVARCHAR(50),
    prd_start_date DATE,
    prd_end_date   DATE
);
GO

IF OBJECT_ID('Bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE Bronze.crm_sales_details;
GO

CREATE TABLE Bronze.crm_sales_details (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt INT,
    sls_ship_dt  INT,
    sls_due_dt   INT,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT
);
GO

-- ----------------------------------------------------------------------------
-- ERP Source Tables
-- ----------------------------------------------------------------------------
IF OBJECT_ID('Bronze.erp_CUST_AZ12', 'U') IS NOT NULL
    DROP TABLE Bronze.erp_CUST_AZ12;
GO

CREATE TABLE Bronze.erp_CUST_AZ12 (
    CID   NVARCHAR(50),
    BDATE DATE,
    GEN   NVARCHAR(10)
);
GO

IF OBJECT_ID('Bronze.erp_LOC_A101', 'U') IS NOT NULL
    DROP TABLE Bronze.erp_LOC_A101;
GO

CREATE TABLE Bronze.erp_LOC_A101 (
    CID   NVARCHAR(50),
    CNTRY NVARCHAR(50)
);
GO

IF OBJECT_ID('Bronze.erp_PX_CAT_G1V2', 'U') IS NOT NULL
    DROP TABLE Bronze.erp_PX_CAT_G1V2;
GO

CREATE TABLE Bronze.erp_PX_CAT_G1V2 (
    ID          NVARCHAR(50),
    CAT         NVARCHAR(50),
    SUBCAT      NVARCHAR(50),
    MAINTENANCE NVARCHAR(50)
);
GO
