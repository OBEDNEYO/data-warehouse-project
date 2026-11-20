/*================================================================================
Create Database and Schemas
==================================================================================
Script Purpose:
This script creates a new database 'Datawarehouse' after checking if it exists and if does exist , it is dropped and recreated. Also the scripts creates three schemas in the Database called 'Bronze', 'Silver' and 'Gold'
WARNING: This script will drop Database 'Datawarehouse' and all its data will be deleted permanently if its exists so proceed with Caution before running the script ensure there is proper backups */
-- Drop and recreate the database Datawarehouse
USE master;

GO

-- Drop and recreate the database 'Datawarehouse'
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Datawarehouse')
BEGIN
    DROP DATABASE Datawarehouse;
END;

GO

CREATE DATABASE Datawarehouse;

GO

-- create schemas in our Database
USE Datawarehouse;
GO
create schema Bronze;
GO
create schema Silver;
GO
create schema Gold;
