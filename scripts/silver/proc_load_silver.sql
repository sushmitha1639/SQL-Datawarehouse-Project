/*
*********************************************************************************************************
Stored Procedure: Load Silver Layer (Source -> Bronze)
*********************************************************************************************************
Script Purpose:
This stored procedure performs the ETL (Extract, Transform, Load) process to
populate the 'silver' schema tables from the 'bronze' schema.
It performs the following actions:
- Truncates the silver tables before loading data.
- Inserts transformed and cleaned data from bronze into silver tables

Parameters:
None
This stored procedure does not accept any parameters or return any values.

Usage Example:
EXEC silver.load_bronze;
********************************************************************************************************
*/
create or alter procedure bronze.load_bronze as
begin
declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
begin try
set @batch_start_time = getdate();
print '======================================================';
print 'loading bronze layer';
print '======================================================';

print '------------------------------------------------------';
print 'loading crm tables';
print '------------------------------------------------------';

set @start_time = getdate();
print'>> truncating table: bronze.crm_cust_info';
truncate table bronze.crm_cust_info;

print'>> inserting data into: bronze.crm_cust_info';
bulk insert bronze.crm_cust_info
from 'C:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
);
set @end_time = getdate();
print '>> load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
print '>> -------------- ';


set @start_time = getdate();
print'>> truncating table: bronze.crm_sales_details';
truncate table bronze.crm_sales_details;

print'>> inserting data into: bronze.crm_sales_details';
bulk insert bronze.crm_sales_details
from 'C:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
);
set @end_time = getdate();
print '>> load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
print '>> -------------- ';


set @start_time = getdate();
print'>> truncating table: bronze.crm_prd_info';
truncate table bronze.crm_prd_info;

print'>> inserting data into: bronze.crm_prd_info';
bulk insert bronze.crm_prd_info
from 'C:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
);
set @end_time = getdate();
print '>> load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
print '>> -------------- ';



print '------------------------------------------------------';
print 'loading erp tables';
print '------------------------------------------------------';


set @start_time = getdate();
print'>> truncating table: bronze.erp_cust_az12';
truncate table bronze.erp_cust_az12;

print'>> inserting data into: bronze.erp_cust_az12';
bulk insert bronze.erp_cust_az12
from 'C:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
);
set @end_time = getdate();
print '>> load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
print '>> -------------- ';

set @start_time = getdate();
print'>> truncating table: bronze.erp_loc_a101';
truncate table bronze.erp_loc_a101;

print'>> inserting data into: bronze.erp_loc_a101';
bulk insert bronze.erp_loc_a101
from 'C:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
);
set @end_time = getdate();
print '>> load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
print '>> -------------- ';

set @start_time = getdate();
print'>> truncating table: bronze.erp_px_cat_g1v2';
truncate table bronze.erp_px_cat_g1v2;

print'>> inserting data into: bronze.erp_px_cat_g1v2';
bulk insert bronze.erp_px_cat_g1v2
from 'C:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
with(
firstrow = 2,
fieldterminator = ',',
tablock
);
set @end_time = getdate();
print '>> load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
print '>> -------------- ';

set @batch_end_time = getdate();
print '========================================================='
print 'loading bronze layer is completed';
print '  - total load duration: ' + cast(datediff(second, @batch_start_time, @batch_end_time) as nvarchar) +' seconds';
print '========================================================='
end try
begin catch
print '=========================================================';
print 'error occured during loading bronze layer';
print 'error message' + error_message();
print 'error message' + cast (error_number() as nvarchar);
print 'error message' + cast (error_state() as nvarchar);
print '=========================================================';
end catch
end
