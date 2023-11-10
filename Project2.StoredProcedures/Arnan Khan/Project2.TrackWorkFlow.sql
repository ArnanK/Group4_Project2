-- ===========================================================
-- Author: Arnan Khan
-- Procedure: [Process].[usp_TrackWorkFlow]
-- Create date: 11/10/2023
-- Description:	Allows you to track Work Flow Proceudres as a parametirzed table.
-- ===========================================================
CREATE PROCEDURE [Process].[usp_TrackWorkFlows]
    @UserAuthorizationKey INT,
    @WorkFlowStepDescription NVARCHAR(100),
    @StartTime DATETIME2,
    @EndTime DATETIME2,
    @WorkFlowStepTableRowCount INT
	
AS 
BEGIN
    INSERT INTO Process.WorkflowSteps (UserAuthorizationKey, WorkFlowStepDescription, StartingDateTime, EndingDateTime, WorkFlowStepTableRowCount)
    VALUES (@UserAuthorizationKey, @WorkFlowStepDescription, @StartTime, @EndTime, @WorkFlowStepTableRowCount)
END;
