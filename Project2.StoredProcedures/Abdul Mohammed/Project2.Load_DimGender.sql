USE [BIClass]
GO
/****** Object: StoredProcedure [Project2].[Load_DimGender] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Abdul Mohammed
-- Create date: 11/14/2023
-- Description:	
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimGender]
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

	INSERT INTO [CH01-01-Dimension].[DimGender]
	(
		Gender,
		GenderDescription,
		UserAuthorizationKey,
		DateAdded,
		DateOfLastUpdate
	)
	SELECT
		DISTINCT 
		OLD.Gender,
		CASE Old.Gender WHEN 'M' THEN 'Male' ELSE 'Female' END AS GenderDescription,
		@GroupMemberUserAuthorizationKey,
		@DateAdded,
		@DateOfLastUpdate
	FROM FileUpload.OriginallyLoadedData as OLD
	Order BY Gender asc

	declare @rowCount as INT;
	set @rowCount = (SELECT COUNT(*) FROM [CH01-01-Dimension].[DimGender]);
	set @startT = SYSDATETIME();
	set @endT = SYSDATETIME();

	INSERT INTO Process.WorkflowSteps (UserAuthorizationKey, WorkFlowStepDescription, StartingDateTime, EndingDateTime, WorkFlowStepTableRowCount)
	VALUES(
		@GroupMemberUserAuthorizationKey,
		N'Gender.',
		@startT,
		 @endT,
		@rowCount
	)

END