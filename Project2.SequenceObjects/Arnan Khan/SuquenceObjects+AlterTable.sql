-- =============================================
-- Author: Arnan Khan
-- Create date: 11/05/2023
-- Description: Sequence objects for DimProduct, DimProductCategory, DimProductSubcategory
-- =============================================
CREATE SEQUENCE 
[CH01-01-Dimension].[DimProduct]
	AS [int]
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	CACHE
GO
CREATE SEQUENCE 
[CH01-01-Dimension].[DimProductCategory]
	AS [int]
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	CACHE
GO
CREATE SEQUENCE 
[CH01-01-Dimension].[DimProductSubcategory]
	AS [int]
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	CACHE
GO