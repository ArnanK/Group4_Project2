USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimTerritory]    Script Date: 11/12/2023 9:15:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Arnan Khan
-- Create date: 11/15/2023
-- Description:	Dim Territory Loaded.
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimTerritory]
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

	INSERT INTO [CH01-01-Dimension].DimTerritory
	(
		TerritoryGroup,
		TerritoryCountry,
		TerritoryRegion,
		UserAuthorizationKey,
		DateAdded,
		DateOfLastUpdate
	)
	SELECT DISTINCT TerritoryGroup,TerritoryCountry,TerritoryRegion,@GroupMemberUserAuthorizationKey,@DateAdded,@DateOfLastUpdate
	FROM FileUpload.OriginallyLoadedData

	declare @rowCount as INT;
	set @rowCount = (SELECT COUNT(*) FROM [CH01-01-Dimension].[DimTerritory]);
	set @startT = SYSDATETIME();
	set @endT = SYSDATETIME();

	INSERT INTO Process.WorkflowSteps (UserAuthorizationKey, WorkFlowStepDescription, StartingDateTime, EndingDateTime, WorkFlowStepTableRowCount)
	VALUES(
		@GroupMemberUserAuthorizationKey,
		N'Territory.',
		@startT,
		 @endT,
		@rowCount
	)
	
END

