
-- =============================================
-- Create date: 11/14/2023
-- Description:	Runs Load Star Schema and Outputs all values in the workflow Steps.
-- =============================================
EXEC [Project2].[LoadStarSchemaData]

SELECT *
FROM Process.WorkflowSteps
