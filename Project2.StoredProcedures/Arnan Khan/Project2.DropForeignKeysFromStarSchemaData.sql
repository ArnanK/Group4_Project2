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
	@GroupMemberUserAuthorizationKey INT
AS
BEGIN
	declare @startT DATETIME2;
	declare @endT DATETIME2;
    SET NOCOUNT ON;
	--Remove the Foreign Keys for the [CH01-01-Fact]
	ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT IF EXISTS FK_Data_DimCustomer;
	ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT IF EXISTS FK_Data_DimGender;
	ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT IF EXISTS FK_Data_DimMaritalStatus;
	ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT IF EXISTS FK_Data_DimOccupation;
	ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT IF EXISTS FK_Data_DimOrderDate;
	ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT IF EXISTS FK_Data_DimProduct;
	ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT IF EXISTS FK_Data_DimTerritory;
	ALTER TABLE [CH01-01-Fact].[Data] DROP CONSTRAINT IF EXISTS FK_Data_SalesManager;

	ALTER TABLE [CH01-01-Dimension].[DimProduct] DROP CONSTRAINT IF EXISTS FK_DimProductSubcategory;
    ALTER TABLE [CH01-01-Dimension].[DimProductSubCategory] DROP CONSTRAINT IF EXISTS FK_DimProductCategory;
	
	
	declare @rowCount as INT;
	set @rowCount = 0;
	set @startT = SYSDATETIME();
	set @endT = SYSDATETIME();

	INSERT INTO Process.WorkflowSteps (UserAuthorizationKey, WorkFlowStepDescription, StartingDateTime, EndingDateTime, WorkFlowStepTableRowCount)
	VALUES(
		@GroupMemberUserAuthorizationKey,
		N'Loads all of the Products.',
		@startT,
		 @endT,
		@rowCount
	)
END;
