USE [BIClass]
GO

/****** Object:  StoredProcedure [Project2].[Load_DimCustomer]    Script Date: 11/14/2023 5:45:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Mudabir Rizvi
-- Create date: 11/14/2023
-- Description:	
-- =============================================
Alter PROCEDURE [Project2].[Load_DimCustomer]
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

	Insert into[CH01-01-Dimension].[DimCustomer]
	(
		customername,
		UserAuthorizationKey,
		DateAdded,
		DateOfLastUpdate
	)
	

	select 
	
		distinct 
		old.CustomerName,
		@GroupMemberUserAuthorizationKey,
		@DateAdded,
		@DateOfLastUpdate
	from FileUpload.OriginallyLoadedData as OLD
	order by customername asc


	declare @rowCount as INT;
	set @rowCount = (SELECT COUNT(CustomerKey) FROM [CH01-01-Dimension].[DimCustomer]);
	set @startT = SYSDATETIME();
	set @endT = SYSDATETIME();

	INSERT INTO Process.WorkflowSteps (UserAuthorizationKey, WorkFlowStepDescription, StartingDateTime, EndingDateTime, WorkFlowStepTableRowCount)
	VALUES(
		@GroupMemberUserAuthorizationKey,
		N'Loads all of the Customer.',
		@startT,
		 @endT,
		@rowCount
	)


END

GO

select * from [CH01-01-Dimension].[DimCustomer]
