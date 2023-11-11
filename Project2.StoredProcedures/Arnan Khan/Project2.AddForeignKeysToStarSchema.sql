USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[AddForeignKeysToStarSchemaData]    Script Date: 11/10/2023 2:31:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Arnan Khan
-- Create date: 11/10/2023
-- Description:	Adds Foreign Keys back to tables.
-- =============================================
ALTER PROCEDURE [Project2].[AddForeignKeysToStarSchemaData]
@GroupMemberUserAuthorizationKey INT
AS
BEGIN
	declare @startT DATETIME2;
	declare @endT DATETIME2;
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
	
	--Foreign Keys for .Data table.
	ALTER TABLE [CH01-01-Fact].Data
	ADD CONSTRAINT FK_Data_DimMartialStatus Foreign Key(DimMartialStatus)
	REFERENCES [CH01-01-Dimension].[DimMartialStatus] (MartialStatus);

	ALTER TABLE [CH01-01-Fact].Data
	ADD CONSTRAINT FK_Data_DimOccupation Foreign Key(DimOccupation)
	REFERENCES [CH01-01-Dimension].[DimOccupation] (OccupationKey);

	ALTER TABLE [CH01-01-Fact].Data
	ADD CONSTRAINT FK_Data_DimOrderDate Foreign Key(DimOrderDate)
	REFERENCES [CH01-01-Dimension].[DimOrderDate] (OrderDate);

	ALTER TABLE [CH01-01-Fact].Data
	ADD CONSTRAINT FK_Data_DimTerritory Foreign Key(DimTerritory)
	REFERENCES [CH01-01-Dimension].[DimTerritory] (TerritoryKey);

	ALTER TABLE [CH01-01-Fact].Data
	ADD CONSTRAINT FK_Data_SalesManagers Foreign Key(SalesManagersKey)
	REFERENCES [CH01-01-Dimension].[SalesManagers] (SalesManagersKey);

	ALTER TABLE [CH01-01-Fact].Data
	ADD CONSTRAINT FK_Data_DimGender Foreign Key(Gender)
	REFERENCES [CH01-01-Dimension].[DimGender] (Gender);

	ALTER TABLE [CH01-01-Fact].Data
	ADD CONSTRAINT FK_Data_DimCustomer Foreign Key(CustomerKey)
	REFERENCES [CH01-01-Dimension].[DimCustomer] (CustomerKey);

	ALTER TABLE [CH01-01-Fact].Data
	ADD CONSTRAINT FK_Data_DimProduct Foreign Key(ProductKey)
	REFERENCES [CH01-01-Dimension].[DimProduct] (ProductKey);

	ALTER TABLE [CH01-01-Dimension].[DimProduct] 
	ADD CONSTRAINT FK_DimProduct Foreign Key(ProductSubcategoryKey)
	REFERENCES [CH01-01-Dimension].[DimProductSubcategory](ProductSubcategoryKey)
	
	ALTER TABLE [CH01-01-Dimension].[DimProductSubcategory]
	ADD CONSTRAINT FK_DimProductSubcategory Foreign Key(ProductCategoryKey)
	REFERENCES [CH01-01-Dimension].[DimProductCategory](ProductCategoryKey)
	
	declare @rowCount as INT;
	set @rowCount = 0;
	set @startT = SYSDATETIME();
	set @endT = SYSDATETIME();

	EXEC [Process].[usp_TrackWorkFlow]
		@UserAuthorization = @GroupMemberUserAuthorizationKey,
		@WorkFlowDescription = N'Adds All Foreign Key Constraints To All Tables',
		@startTime = @startT,
		@endTime = @endT,
		@WorkFlowStepTableRowCount = @rowCount;

END;
