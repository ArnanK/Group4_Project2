USE [BIClass]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Arnan Khan
-- Create date: 11/7/2023
-- Description:	Drop the Foreign Keys From the Star Schema
-- =============================================
ALTER PROCEDURE [Project2].[DropForeignKeysFromStarSchemaData]
AS
BEGIN
    SET NOCOUNT ON;
	--Remove the Foreign Keys for the [CH01-01-Fact]
	ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT FK_Data_DimCustomer;
	ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT FK_Data_DimGender;
	ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT FK_Data_DimMartialStatus;
	ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT FK_Data_DimOccupation;
	ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT FK_Data_DimOrderDate;
	ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT FK_Data_DimProduct;
	ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT FK_Data_DimTerritory;
	ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT FK_Data_DimSalesManager;

	ALTER TABLE [CH01-01-Dimension].[DimProductSubcategory] DROP CONSTRAINT FK_DimProductSubcategory;
	

END;
