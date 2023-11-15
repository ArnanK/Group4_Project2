ALTER PROCEDURE [Project2].[Load_DimOccupation]
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
   INSERT INTO [CH01-01-Dimension].[DimOccupation] (OccupationKey, Occupation, UserAuthorizationKey, DateAdded, DateOfLastUpdate)
   SELECT DISTINCT
      CASE 
         WHEN OLD.Occupation = 'clerical' THEN 1
         WHEN OLD.Occupation = 'management' THEN 2
         WHEN OLD.Occupation = 'manual' THEN 3
         WHEN OLD.Occupation = 'professional' THEN 4
         WHEN OLD.Occupation = 'skilled manual' THEN 5
         ELSE NULL -- You may want to handle other cases accordingly
      END AS OccupationKey,
      OLD.Occupation,
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
        N'Loads all of the Occupations and the corresponding occupation key',
        @startT,
         @endT,
        @rowCount
    )
END;





