USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[TruncateStarSchemaData]    Script Date: 11/6/2023 9:54:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Arnan Khan
-- Create date: 11/06/2023
-- Description:	@GroupMemberUserAuthorizationKey:
-- authorization key for stored procedure
-- =============================================
ALTER PROCEDURE [Project2].[TruncateStarSchemaData]
	@GroupMemberUserAuthorizationKey int

AS
BEGIN
	declare @startT DATETIME2;
	declare @endT DATETIME2;
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	truncate table [CH01-01-FACT].Data
	truncate table [CH01-01-Dimension].DimCustomer
	truncate table [CH01-01-Dimension].DimGender
	truncate table [CH01-01-Dimension].DimMartialStatus
	truncate table [CH01-01-Dimension].DimOccupation
	truncate table [CH01-01-Dimension].DimOrderDate
	truncate table [CH01-01-Dimension].DimProduct
	truncate table [CH01-01-Dimension].DimProductCategory
	truncate table [CH01-01-Dimension].DimProductSubcategory
	truncate table [CH01-01-Dimension].DimTerritory
	truncate table [CH01-01-Dimension].DimSalesManagers

	ALTER SEQUENCE [PKSequence].[DataSequenceObject] RESTART WITH 1;
	ALTER SEQUENCE [PKSequence].[DimCustomerSequenceObject] RESTART WITH 1;
	ALTER SEQUENCE [PKSequence].[DimGenderSequenceObject] RESTART WITH 1;
	ALTER SEQUENCE [PKSequence].[DimMartialStatusSequenceObject] RESTART WITH 1;
	ALTER SEQUENCE [PKSequence].[DimOccupationSequenceObject] RESTART WITH 1;
	ALTER SEQUENCE [PKSequence].[DimOrderDateSequenceObject] RESTART WITH 1;
	ALTER SEQUENCE [PKSequence].[DimProductSequenceObject] RESTART WITH 1;
	ALTER SEQUENCE [PKSequence].[DimProductCategorySequenceObject] RESTART WITH 1;
	ALTER SEQUENCE [PKSequence].[DimProductSubcategorySequenceObject] RESTART WITH 1;
	ALTER SEQUENCE [PKSequence].[DimTerritorySequenceObject] RESTART WITH 1;
	ALTER SEQUENCE [PKSequence].[DimSalesManagersSequenceObject] RESTART WITH 1;
	
	declare @rowCount as INT;
	set @rowCount = 0;
	set @startT = SYSDATETIME();
	set @endT = SYSDATETIME();

	EXEC [Process].[usp_TrackWorkFlow]
		@UserAuthorization = @GroupMemberUserAuthorizationKey,
		@WorkFlowDescription = N'Truncates all Tables and alters Sequence Objects to 1.',
		@startTime = @startT,
		@endTime = @endT,
		@WorkFlowStepTableRowCount = @rowCount;

	
END;
	

