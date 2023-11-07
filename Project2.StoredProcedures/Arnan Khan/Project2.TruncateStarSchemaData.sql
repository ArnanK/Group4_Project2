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

	
END;
	

