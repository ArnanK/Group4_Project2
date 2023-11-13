USE [BIClass]
GO

/****** Object:  StoredProcedure [Project2].[Load_DimProductCategory]    Script Date: 11/12/2023 6:46:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Samin Chowdhury
-- Create date: 11/12/2023
-- Description:	Loads the products form the File Upload.
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimProductCategory]
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

	INSERT INTO [CH01-01-Dimension].[DimProductCategory]
	(
	ProductCategory,
	UserAuthorizationKey,
	DateAdded,
	DateofLastUpdate
	)
	SELECT
	ProductCategory,
	@GroupMemberUserAuthorizationKey,
	@DateAdded,
	@DateOfLastUpdate
	FROM FileUpload.ProductCategories



	declare @rowCount as INT;
	set @rowCount = (SELECT COUNT(ProductCategoryKey) FROM [CH01-01-Dimension].[DimProductCategory]);
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
END
GO

