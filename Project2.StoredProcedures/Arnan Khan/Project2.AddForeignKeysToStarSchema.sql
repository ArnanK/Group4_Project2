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
	ADD CONSTRAINT FK_Data_DimMaritalStatus Foreign Key(MaritalStatus)
	REFERENCES [CH01-01-Dimension].[DimMaritalStatus] (MaritalStatus);

	ALTER TABLE [CH01-01-Fact].Data
	ADD CONSTRAINT FK_Data_DimOccupation Foreign Key(OccupationKey)
	REFERENCES [CH01-01-Dimension].[DimOccupation] (OccupationKey);

	ALTER TABLE [CH01-01-Fact].Data
	ADD CONSTRAINT FK_Data_DimOrderDate Foreign Key(OrderDate)
	REFERENCES [CH01-01-Dimension].[DimOrderDate] (OrderDate);

	ALTER TABLE [CH01-01-Fact].Data
	ADD CONSTRAINT FK_Data_DimTerritory Foreign Key(TerritoryKey)
	REFERENCES [CH01-01-Dimension].[DimTerritory] (TerritoryKey);

	ALTER TABLE [CH01-01-Fact].Data
	ADD CONSTRAINT FK_Data_SalesManager Foreign Key(SalesManagerKey)
	REFERENCES [CH01-01-Dimension].[SalesManagers] (SalesManagerKey);

	ALTER TABLE [CH01-01-Fact].Data
	ADD CONSTRAINT FK_Data_DimGender Foreign Key(Gender)
	REFERENCES [CH01-01-Dimension].[DimGender] (Gender);

	ALTER TABLE [CH01-01-Fact].Data
	ADD CONSTRAINT FK_Data_DimCustomer Foreign Key(CustomerKey)
	REFERENCES [CH01-01-Dimension].[DimCustomer] (CustomerKey);

	 ALTER TABLE [CH01-01-Fact].[Data] 
	 WITH CHECK ADD CONSTRAINT [FK_Data_DimProduct] 
	 FOREIGN KEY ([ProductKey]) 
	 REFERENCES [CH01-01-Dimension].[DimProduct] ([ProductKey]);
	 ALTER TABLE [CH01-01-Fact].[Data] CHECK CONSTRAINT [FK_Data_DimProduct];

	ALTER TABLE [CH01-01-Dimension].[DimProduct] 
	ADD CONSTRAINT FK_DimProductSubcategory Foreign Key(ProductSubcategoryKey)
	REFERENCES [CH01-01-Dimension].[DimProductSubcategory](ProductSubcategoryKey)
	
	ALTER TABLE [CH01-01-Dimension].[DimProductSubcategory]
	ADD CONSTRAINT FK_DimProductCategory Foreign Key(ProductCategoryKey)
	REFERENCES [CH01-01-Dimension].[DimProductCategory](ProductCategoryKey)
	
	declare @rowCount as INT;
	set @rowCount = 0;
	set @startT = SYSDATETIME();
	set @endT = SYSDATETIME();

	INSERT INTO Process.WorkflowSteps (UserAuthorizationKey, WorkFlowStepDescription, StartingDateTime, EndingDateTime, WorkFlowStepTableRowCount)
	VALUES(
		@GroupMemberUserAuthorizationKey,
		N'Loads all of the Products.',
		@startT,
		 @endT,
		@rowCount
	)


END;


SELECT *
FROM [CH01-01-Dimension].DimCustomer