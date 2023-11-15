?USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimOrderDate]    Script Date: 11/12/2023 7:58:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Akash Ramkaran
-- Create date: 11/12/2023
-- Description:	
-- =============================================
ALTER PROCEDURE [Project2].[Load_Data]
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

	INSERT INTO [CH01-01-Dimension].[DimOrderDate]
	(
		OrderDate,
		MonthName,
		MonthNumber,
		Year,
		UserAuthorizationKey,
		DateAdded,
		DateOfLastUpdate
	)
	SELECT
		DISTINCT 
		OLD.OrderDate,
		OLD.MonthName,
		OLD.MonthNumber,
		OLD.Year,
		@GroupMemberUserAuthorizationKey,
		@DateAdded,
		@DateOfLastUpdate
	FROM FileUpload.OriginallyLoadedData as OLD
	Order BY OrderDate asc


	declare @rowCount as INT;
	set @rowCount = (SELECT COUNT(*) FROM [CH01-01-Dimension].[DimOrderDate]);
	set @startT = SYSDATETIME();
	set @endT = SYSDATETIME();

	INSERT INTO Process.WorkflowSteps (UserAuthorizationKey, WorkFlowStepDescription, StartingDateTime, EndingDateTime, WorkFlowStepTableRowCount)
	VALUES(
		@GroupMemberUserAuthorizationKey,
		N'OrderDate.',
		@startT,
		 @endT,
		@rowCount
	)

END
