USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimMaritalStatus]    Script Date: 11/15/2023 8:11:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Abdul Mohammed
-- Create date: 11/14/2023
-- Description:	
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimMaritalStatus]
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

	INSERT INTO [CH01-01-Dimension].[DimMaritalStatus]
	(
		MaritalStatus,
		MaritalStatusDescription,
		UserAuthorizationKey,
		DateAdded,
		DateOfLastUpdate
	)
	SELECT
		DISTINCT 
		OLD.MaritalStatus,
		CASE WHEN OLD.MaritalStatus='M' THEN 'Married'
		ELSE 'Single' END AS MaritialStatusDescription,

		@GroupMemberUserAuthorizationKey,
		@DateAdded,
		@DateOfLastUpdate
	FROM FileUpload.OriginallyLoadedData as OLD


	declare @rowCount as INT;
	set @rowCount = (SELECT COUNT(*) FROM [CH01-01-Dimension].[DimMaritalStatus]);
	set @startT = SYSDATETIME();
	set @endT = SYSDATETIME();

	INSERT INTO Process.WorkflowSteps 
(		UserAuthorizationKey,
		WorkFlowStepDescription,
		StartingDateTime,
		EndingDateTime,
		WorkFlowStepTableRowCount)
	VALUES(
		@GroupMemberUserAuthorizationKey,
		N'Marital Status',
		@startT,
		 @endT,
		@rowCount
	)

END

