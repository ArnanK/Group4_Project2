USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_Data]    Script Date: 11/15/2023 7:52:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mudabir Rizvi
-- Create date: 11/14/2023
-- Description:	
-- =============================================
ALTER PROCEDURE [Project2].[Load_Data]
@GroupMemberUserAuthorizationKey INT
AS
BEGIN
	
	SET NOCOUNT ON;
	DECLARE @DateAdded DATETIME2;
    SET @DateAdded = SYSDATETIME();
	DECLARE @startT DATETIME2;
	DECLARE @endT DATETIME2;

    DECLARE @DateOfLastUpdate DATETIME2;
    SET @DateOfLastUpdate = SYSDATETIME();

	INSERT INTO [CH01-01-Fact].[Data]
	(
		
		ProductCategory,
		SalesManager,
		ProductSubcategory,
		ProductCode,
		ProductName,
		Color,
		ModelName,
		OrderQuantity,
		UnitPrice,
		ProductStandardCost,
		SalesAmount,
		[MonthName],
		[MonthNumber],
		[Year],
		CustomerName,
		Education,
		Occupation,
		TerritoryRegion,
		TerritoryCountry,
		TerritoryGroup,
		UserAuthorizationKey,
		DateAdded,
		DateOfLastUpdate
	)
	SELECT
		DISTINCT 
		
		old.ProductCategory,
		old.SalesManager,
		old.ProductSubcategory,
		old.ProductCode,
		old.ProductName,
		old.Color,
		old.ModelName,
		old.OrderQuantity,
		old.UnitPrice,
		old.ProductStandardCost,
		old.SalesAmount,
		old.[MonthName],
		old.MonthNumber,
		old.[Year],
		old.CustomerName,
		old.Education,
		old.Occupation,
		old.TerritoryRegion,
		old.TerritoryCountry,
		old.TerritoryGroup,
		@GroupMemberUserAuthorizationKey,
		@DateAdded,
		@DateOfLastUpdate
	FROM FileUpload.OriginallyLoadedData as old
	LEFT JOIN [CH01-01-Dimension].SalesManagers as SM on SM.SalesManager=old.SalesManager
	LEFT JOIN [CH01-01-Dimension].DimOccupation as DO on DO.Occupation=old.Occupation
	LEFT JOIN [CH01-01-Dimension].DimTerritory as DT on DT.TerritoryCountry=old.TerritoryCountry and DT.TerritoryGroup=old.TerritoryGroup and DT.TerritoryRegion=old.TerritoryRegion
	LEFT JOIN [CH01-01-Dimension].DimProduct as DP on DP.ProductName=old.ProductName and DP.ProductCode=old.ProductCode
	LEFT JOIN [CH01-01-Dimension].DimCustomer as DC on DC.CustomerName=old.CustomerName
	


	declare @rowCount as INT;
	set @rowCount = (SELECT COUNT(*) FROM [CH01-01-Fact].[Data]);
	set @startT = SYSDATETIME();
	set @endT = SYSDATETIME();

	INSERT INTO Process.WorkflowSteps (UserAuthorizationKey, WorkFlowStepDescription, StartingDateTime, EndingDateTime, WorkFlowStepTableRowCount)
	VALUES(
		@GroupMemberUserAuthorizationKey,
		N'SalesKey',
		@startT,
		 @endT,
		@rowCount
	)

END

