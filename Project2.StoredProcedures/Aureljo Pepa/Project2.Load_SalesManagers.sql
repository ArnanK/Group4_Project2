USE [BIClass]
GO
-- =============================================
-- Author:		Aureljo Pepa
-- Create date: 11/14/2023
-- Description:	
-- =============================================
/****** Object:  StoredProcedure [Project2].[Load_SalesManagers]    Script Date: 11/10/2023 10:08:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [Project2].[Load_SalesManagers]
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

   INSERT INTO [CH01-01-Dimension].SalesManagers
   (
		Category,
		SalesManager,
		Office,
		UserAuthorizationKey,
		DateAdded,
		DateOfLastUpdate
	)
	SELECT DISTINCT 
		OLD.ProductCategory,
		OLD.SalesManager,
		Office = CASE 
			WHEN OLD.SalesManager LIKE 'Marco%' THEN 'Redmond'
			WHEN OLD.SalesManager LIKE 'Alberto%' THEN 'Seattle'
			WHEN OLD.SalesManager LIKE 'Maurizio%' THEN 'Redmond' 
			ELSE 'Seattle'
		END,
	  @GroupMemberUserAuthorizationKey, 
	  @DateAdded,
	  @DateOfLastUpdate
	FROM FileUpload.OriginallyLoadedData AS OLD 

	declare @rowCount as INT;
    set @rowCount = (SELECT COUNT(*) FROM [CH01-01-Dimension].[DimOccupation])
    set @startT = SYSDATETIME();
    set @endT = SYSDATETIME();

    INSERT INTO Process.WorkflowSteps (UserAuthorizationKey, WorkFlowStepDescription, StartingDateTime, EndingDateTime, WorkFlowStepTableRowCount)
    VALUES(
        @GroupMemberUserAuthorizationKey,
        N'Loads all of the SalesManagers, along with their keys. A key value of 1 is for Marco, 2 for Alberto, 3 for Maurizio and 4 for Luis.',
        @startT,
        @endT,
        @rowCount
    )
END;


SELECT *
FROM [CH01-01-Dimension].SalesManagers