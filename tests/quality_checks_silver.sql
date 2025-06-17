/*
*****************************************************************************************
Quality Checks
****************************************************************************************
Script purpose:
This script performs various quality checks for data consistency, accuracy, and
standardization across the 'silver' schema. It includes checks for:
- Null or dublicate primary keys
- Unwanted spaces in string fields
- Data standardization and consistency
- Invalid date ranges and orders
- Data consistency between related fields.

Usage notes:
- Run these checks after data loading silver layer.
-Investigate and resolve any discrepencies found during the checks.
***************************************************************************************
*/

--************************************************************************************
-- Checking 'silver.crm_cust_info'
--*************************************************************************************
--Check for nulls or duplicates in primary key
--Expectation : No Results
