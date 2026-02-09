-- =========================================================
-- Stored Procedure: bronze.load_bronze
-- Purpose         : Load raw CRM & ERP data into Bronze Layer
-- Description     : 
--   This procedure performs the ETL process for the Bronze layer.
--   Steps included:
--     1. Truncate existing data in all Bronze tables.
--     2. Bulk insert new data from CSV files into each table.
--     3. Log progress messages for each step.
--     4. Handle errors and display detailed error information if any step fails.
-- Tables Loaded:
--   CRM:
--     - bronze.crm_cust_info        : Customer Information
--     - bronze.crm_prd_info         : Product Information
--     - bronze.crm_sales_details    : Sales Transactions
--   ERP:
--     - bronze.erp_cust_az12        : Customer Master AZ12
--     - bronze.erp_loc_a101         : Location Master A101
--     - bronze.erp_px_cat_g1v2      : Product Category G1V2
-- Usage:
--   EXEC bronze.load_bronze;
-- =========================================================


CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    DECLARE @START_TIME DATETIME, @END_TIME DATETIME ,@START_TIME_1 DATETIME, @END_TIME_1 DATETIME
    BEGIN TRY
       
        PRINT 'LOADING BRONZE LAYER...';
         SET @START_TIME_1 =GETDATE();
        -- =================================================
        -- CRM: Customer Info
        -- =================================================
        SET @START_TIME =GETDATE();
        PRINT 
        '---------------------------------------------
        Truncating bronze.crm_cust_info...';
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT 'Inserting data into bronze.crm_cust_info...';
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\azeem\Downloads\SQL Course Material\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
         SET @END_TIME =     GETDATE();
        PRINT ' TIME TAKEN TO LOAD : ' + CAST(DATEDIFF(MilliSecond,@start_time,@end_time) AS NVARCHAR) + ' Milliseconds'
        -- =================================================
        -- CRM: Product Info
        -- =================================================
        SET @START_TIME =GETDATE();
        PRINT 
        '---------------------------------------------
        Truncating bronze.crm_prd_info...
        ';
        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT 'Inserting data into bronze.crm_prd_info...';
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\azeem\Downloads\SQL Course Material\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
         SET @END_TIME =     GETDATE();
        PRINT ' TIME TAKEN TO LOAD : ' + CAST(DATEDIFF(MilliSecond,@start_time,@end_time) AS NVARCHAR) + ' Milliseconds'
        -- =================================================
        -- CRM: Sales Details
        -- =================================================
        SET @START_TIME =GETDATE();
        PRINT 
        '---------------------------------------------
        Truncating bronze.crm_sales_details...';
        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT 'Inserting data into bronze.crm_sales_details...';
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\azeem\Downloads\SQL Course Material\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
         SET @END_TIME =     GETDATE();
        PRINT ' TIME TAKEN TO LOAD : ' + CAST(DATEDIFF(MilliSecond,@start_time,@end_time) AS NVARCHAR) + ' Milliseconds'
        -- =================================================
        -- ERP: Customer Master AZ12
        -- =================================================
        SET @START_TIME =GETDATE();
        PRINT 
        '---------------------------------------------
        Truncating bronze.erp_cust_az12...';
        TRUNCATE TABLE bronze.erp_cust_az12;

        PRINT 'Inserting data into bronze.erp_cust_az12...';
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\azeem\Downloads\SQL Course Material\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
         SET @END_TIME =     GETDATE();
        PRINT ' TIME TAKEN TO LOAD : ' + CAST(DATEDIFF(MilliSecond,@start_time,@end_time) AS NVARCHAR) + ' Milliseconds'
        -- =================================================
        -- ERP: Location A101
        -- =================================================
        SET @START_TIME =GETDATE();
        PRINT 
        '---------------------------------------------
        Truncating bronze.erp_loc_a101...';
        TRUNCATE TABLE bronze.erp_loc_a101;

        PRINT 'Inserting data into bronze.erp_loc_a101...';
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\azeem\Downloads\SQL Course Material\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
         SET @END_TIME =     GETDATE();
        PRINT ' TIME TAKEN TO LOAD : ' + CAST(DATEDIFF(MilliSecond,@start_time,@end_time) AS NVARCHAR) + ' Milliseconds'
        -- =================================================
        -- ERP: Product Category G1V2
        -- =================================================
        SET @START_TIME =GETDATE();
        PRINT 
        '---------------------------------------------
        Truncating bronze.erp_px_cat_g1v2...';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT 'Inserting data into bronze.erp_px_cat_g1v2...';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\azeem\Downloads\SQL Course Material\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
         SET @END_TIME =     GETDATE();
        PRINT ' TIME TAKEN TO LOAD : ' + CAST(DATEDIFF(MilliSecond,@start_time,@end_time) AS NVARCHAR) + ' Milliseconds'
        PRINT 'BRONZE LAYER LOADED SUCCESSFULLY.';
        SET @END_TIME_1 =     GETDATE();
        PRINT ' TIME TAKEN TO LOAD BRONZE LAYER : ' + CAST(DATEDIFF(milliSecond,@start_time_1,@end_time_1) AS NVARCHAR) + ' Milli-Seconds'
      
       

    END TRY
    BEGIN CATCH
        PRINT 'ERROR OCCURRED WHILE LOADING BRONZE LAYER!';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number : ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
        PRINT 'Error Line   : ' + CAST(ERROR_LINE() AS NVARCHAR(10));
        PRINT 'Error State  : ' + CAST(ERROR_STATE() AS NVARCHAR(10));
    END CATCH
END;

-- Execute the procedure

GO
EXEC bronze.load_bronze;
