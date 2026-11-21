/*
===============================================================================
Stored Procedure: Bronze.load_bronze
===============================================================================
Purpose:
    Performs a full reload of raw CRM and ERP datasets into the Bronze schema.
    
Design Notes:
    - Idempotency: Uses TRUNCATE TABLE prior to each BULK INSERT to guarantee 
      clean full reloads and prevent duplicate records if re-run accidentally.
    - Error Handling: Wrapped in a TRY...CATCH block to capture and log 
      ingestion failures (e.g., file path issues or schema mismatches).
    - Execution: Run via `EXEC Bronze.load_bronze;`
===============================================================================
*/

CREATE OR ALTER PROCEDURE Bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;

    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '================================================';
        PRINT 'Starting Bronze Layer Ingestion';
        PRINT '================================================';

        -- --------------------------------------------------------------------
        -- CRM Source Ingestion
        -- --------------------------------------------------------------------
        SET @start_time = GETDATE();
        TRUNCATE TABLE Bronze.crm_cust_info;
        BULK INSERT Bronze.crm_cust_info
        FROM 'C:\Users\niyog\Downloads\sql-data-warehouse-project (4)\sql-data-warehouse-project\01_datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Loaded Bronze.crm_cust_info (' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 's)';

        SET @start_time = GETDATE();
        TRUNCATE TABLE Bronze.crm_prd_info;
        BULK INSERT Bronze.crm_prd_info
        FROM 'C:\Users\niyog\Downloads\sql-data-warehouse-project (4)\sql-data-warehouse-project\01_datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Loaded Bronze.crm_prd_info (' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 's)';

        SET @start_time = GETDATE();
        TRUNCATE TABLE Bronze.crm_sales_details;
        BULK INSERT Bronze.crm_sales_details
        FROM 'C:\Users\niyog\Downloads\sql-data-warehouse-project (4)\sql-data-warehouse-project\01_datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Loaded Bronze.crm_sales_details (' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 's)';

        -- --------------------------------------------------------------------
        -- ERP Source Ingestion
        -- --------------------------------------------------------------------
        SET @start_time = GETDATE();
        TRUNCATE TABLE Bronze.erp_CUST_AZ12;
        BULK INSERT Bronze.erp_CUST_AZ12
        FROM 'C:\Users\niyog\Downloads\sql-data-warehouse-project (4)\sql-data-warehouse-project\01_datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Loaded Bronze.erp_CUST_AZ12 (' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 's)';

        SET @start_time = GETDATE();
        TRUNCATE TABLE Bronze.erp_LOC_A101;
        BULK INSERT Bronze.erp_LOC_A101
        FROM 'C:\Users\niyog\Downloads\sql-data-warehouse-project (4)\sql-data-warehouse-project\01_datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Loaded Bronze.erp_LOC_A101 (' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 's)';

        SET @start_time = GETDATE();
        TRUNCATE TABLE Bronze.erp_PX_CAT_G1V2;
        BULK INSERT Bronze.erp_PX_CAT_G1V2
        FROM 'C:\Users\niyog\Downloads\sql-data-warehouse-project (4)\sql-data-warehouse-project\01_datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Loaded Bronze.erp_PX_CAT_G1V2 (' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 's)';

        SET @batch_end_time = GETDATE();
        PRINT '================================================';
        PRINT 'Bronze Ingestion Complete | Total Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + 's';
        PRINT '================================================';

    END TRY
    BEGIN CATCH
        PRINT '================================================';
        PRINT 'ERROR: Bronze Layer Ingestion Failed';
        PRINT 'Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT '================================================';
        THROW; -- Re-throws the error so external schedulers/agents register the failure
    END CATCH
END;
GO
