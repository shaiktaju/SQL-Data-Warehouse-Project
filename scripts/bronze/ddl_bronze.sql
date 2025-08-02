/*
=================================================================================
DDL SCRIPT: CREATE BRONZE TABLES
=================================================================================
Script Purpose:
    This script creates tables in teh 'bronze' schema, dropping existing tables
    if they already exist.
  Run this script to re-define the DDL structure of 'bronze' Tables.
=================================================================================
*/


IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
  DROP TABLES bronze.crm_cust_info;
GO

CREATE TABLE bronze.crm_cust_info (
cst_id INT,
cst_key NVARCHAR(50),
cst_first VARCHAR(50),
cst_lastname NVARCHAR(50),
cst_material_status NVARCHAR(50),
cst_gnder NVARCHAR(50),
cst_create_data DATE
);


CREATE TABLE bronze.prd_info (
prd_id INT,
prd_key NVARCHAR(50),
prd_nm NVARCHAR(50),
pr_cost INT,
prd_line NVARCHAR(50),
prd_start_dt DATETIME,
prd_end_dt DATETIME,
);


CREATE TABLE bronze.sales_details (
sls_ord_num	NVARCHAR(50),
sls_prd_key	NVARCHAR(50),
sls_cust_id	INT,
sls_order_dt INT,
sls_ship_dt INT,
sls_due_dt	INT,
sls_sales	INT,
sls_quantity INT,
sls_price INT,
);


CREATE TABLE bronze.CUST_AZ12 (
CID	NVARCHAR(50),
BDATE DATE,
GEN NVARCHAR(50),
);


CREATE TABLE bronze.LOC_A101 (
CID	NVARCHAR(50),
CNTRY NVARCHAR(50),
);
 

CREATE TABLE bronze.PX_CAT_G1V2(
ID	NVARCHAR(50),
CAT	NVARCHAR(50),
SUBCAT	NVARCHAR(50),
MAINTENANCE NVARCHAR(50),
);
