USE [BIClass]
GO

/****** Object:  StoredProcedure [Project2].[Load_DimProductSubcategory]    Script Date: 11/12/2023 6:46:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Samin Chowdhury
-- Create date: 11/12/2023
-- Description:	Loads into Dim Product While mainting FK orderings.
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimProductSubcategory]
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

	INSERT INTO [CH01-01-Dimension].DimProductSubcategory
	(
		ProductCategoryKey,
		ProductSubcategory,
		UserAuthorizationKey,
		DateAdded,
		DateofLastUpdate
	)
	SELECT 
	DISTINCT
		DPC.ProductCategoryKey,
		PSC.ProductSubcategory,
		@GroupMemberUserAuthorizationKey,
		@DateAdded,
		@DateofLastUpdate
	FROM FileUpload.OriginallyLoadedData AS OLD
	INNER JOIN FileUpload.ProductSubcategories as PSC on OLD.ProductSubcategory=PSC.ProductSubcategory
	INNER JOIN [CH01-01-Dimension].DimProductCategory as DPC on DPC.ProductCategory=OLD.ProductCategory
	


	declare @rowCount as INT;
	set @rowCount = (SELECT COUNT(ProductSubcategoryKey) FROM [CH01-01-Dimension].[DimProductSubcategory]);
	set @startT = SYSDATETIME();
	set @endT = SYSDATETIME();

	INSERT INTO Process.WorkflowSteps (UserAuthorizationKey, WorkFlowStepDescription, StartingDateTime, EndingDateTime, WorkFlowStepTableRowCount)
	VALUES(
		@GroupMemberUserAuthorizationKey,
		N'Loads all of the Product Categories.',
		@startT,
		 @endT,
		@rowCount
	)
END;
GO
