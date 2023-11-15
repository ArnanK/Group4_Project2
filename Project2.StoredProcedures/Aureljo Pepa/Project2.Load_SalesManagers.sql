ALTER PROCEDURE [Project2].[Load_SalesManagers]
@GroupMemberAuthorizationKey INT 
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
		SalesManagerKey,
		Category,
		SalesManager,
		Office,
		UserAuthorizationKey, 
		DateAdded, 
		DateOfLastUpdate
	)
	SELECT DISTINCT 
		CASE 
			WHEN OLD.SalesManager LIKE 'Marco%' THEN 1
			WHEN OLD.SalesManager LIKE 'Maurizio%' THEN 2
			WHEN OLD.SalesManager LIKE 'Alberto%' THEN 3
			WHEN OLD.SalesManager LIKE 'Luis%' THEN 4
			ELSE 5 -- For other cases
		END AS SalesManagerKey,
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
	ORDER BY SalesManagerKey;

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
