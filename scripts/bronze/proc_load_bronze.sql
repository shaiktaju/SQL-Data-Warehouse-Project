/*
=========================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
=========================================================================================
Script Purpose:
    This stored procedure loads data inot the 'bronze' Schema from external CSV files.
    It performs the following actions:
     -Truncatess the bronze tables before loading data.
     -Uses the 'BULK INSERT' command to load data from CSV FILES to bronze tables.

Parameters:
      None.
This stored procedure does not accept any parameters or return any values.

Usage Example:
      EXEC bronze.load_bronze;
=========================================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '=================================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '=================================================================';

		PRINT '-----------------------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '-----------------------------------------------------------------';

		SET @start_time =GETDATE();
		PRINT '>>TRUNCATE TABLE: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>>Insering Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\nizam\Downloads\Project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '---------------';

		SET @start_time =GETDATE();
		PRINT '>>TRUNCATE TABLE: bronze.prd_info';
		TRUNCATE TABLE bronze.prd_info;

		PRINT '>>Insering Data Into: bronze.prd_info';
		BULK INSERT bronze.prd_info
		FROM 'C:\Users\nizam\Downloads\Project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time =GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '---------------';

		SET @start_time =GETDATE();
		PRINT '>>TRUNCATE TABLE: bronze.sales_details';
		TRUNCATE TABLE bronze.sales_details;

		PRINT '>>Insering Data Into: bronze.sales_details';
		BULK INSERT bronze.sales_details
		FROM 'C:\Users\nizam\Downloads\Project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time =GETDATE();
		PRINT '>>Load Duration: ' + CAST (DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '---------------';

		PRINT '-----------------------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '-----------------------------------------------------------------';

		SET @start_time =GETDATE();
		PRINT '>>TRUNCATE TABLE:bronze.CUST_AZ12';
		TRUNCATE TABLE bronze.CUST_AZ12;

		PRINT '>>Insering Data Into: bronze.CUST_AZ12';
		BULK INSERT bronze.CUST_AZ12
		FROM 'C:\Users\nizam\Downloads\Project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time =GETDATE();
		PRINT '>>Load Duration: ' +CAST (DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '---------------';


		SET @start_time =GETDATE();
		PRINT '>>TRUNCATE TABLE: bronze.LOC_A101';
		TRUNCATE TABLE bronze.LOC_A101;

		PRINT '>>Insering Data Into: bronze.LOC_A101';
		BULK INSERT bronze.LOC_A101
		FROM 'C:\Users\nizam\Downloads\Project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time =GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '---------------';


		SET @start_time =GETDATE();
		PRINT '>>TRUNCATE TABLE: bronze.PX_CAT_G1V2';
		TRUNCATE TABLE bronze.PX_CAT_G1V2;

		PRINT '>>Insering Data Into: bronze.PX_CAT_G1V2';
		BULK INSERT bronze.PX_CAT_G1V2
		FROM 'C:\Users\nizam\Downloads\Project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time =GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '---------------';

		SET @batch_end_time = GETDATE();
		PRINT '=================================================================';
		PRINT 'Loading Bronze Layer is completed';
		PRINT '		-Total load Duration:' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds';
		PRINT '=================================================================';
	END TRY
	BEGIN CATCH
		PRINT '=================================================';
		PRINT 'ERROR OCCURED DRUING LOADING BRONZE LAYER';
		PRINT 'Error Message' +	ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=================================================';
	END CATCH
END
