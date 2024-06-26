USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimProduct]    Script Date: 11/10/2023 10:08:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Arnan Khan
-- Create date: 11/10/2023
-- Description:	
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimProduct]
@GroupMemberUserAuthorizationKey INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @DateAdded DATETIME2;
    SET @DateAdded = SYSDATETIME();
	DECLARE @startT DATETIME2;
	DECLARE @endT DATETIME2;

    DECLARE @DateOfLastUpdate DATETIME2;
    SET @DateOfLastUpdate = SYSDATETIME();

	INSERT INTO [CH01-01-Dimension].[DimProduct]
	(
	ProductSubcategoryKey,
	ProductCategory,
	ProductSubcategory,
	ProductCode,
	ProductName,
	Color,
	ModelName,
	UserAuthorizationKey,
	DateAdded,
	DateOfLastUpdate
	)
	SELECT
	DISTINCT 
	DPS.ProductSubcategoryKey,
	OLD.ProductCategory,
	DPS.ProductSubcategory,
	OLD.ProductCode,
	OLD.ProductName,
	OLD.Color,
	OLD.ModelName,
	@GroupMemberUserAuthorizationKey,
	@DateAdded,
	@DateOfLastUpdate
	FROM FileUpload.OriginallyLoadedData as OLD
	FULL OUTER JOIN [CH01-01-Dimension].[DimProductSubcategory] as DPS
		ON OLD.ProductSubcategory = DPS.ProductSubcategory
	
	declare @rowCount as INT;
	set @rowCount = (SELECT COUNT(ProductKey) FROM [CH01-01-Dimension].[DimProduct]);
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


END
