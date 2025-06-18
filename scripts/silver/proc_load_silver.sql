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


