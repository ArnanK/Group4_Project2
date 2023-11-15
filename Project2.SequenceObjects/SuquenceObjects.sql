-- =============================================
-- Author: Arnan Khan
-- Create date: 11/05/2023
-- Description: Sequence objects for DimProduct
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'PKSequence')
BEGIN
    EXEC('CREATE SCHEMA PKSequence')
END
CREATE SEQUENCE 
[PKSequence].[DimProductSequenceObject]
	AS [int]
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	CACHE
GO
-- =============================================
-- Author: Samin Chowdhury
-- Create date: 11/05/2023
-- Description: Sequence objects for DimProductCategory, DimProductSubcategory
-- =============================================
CREATE SEQUENCE 
[PKSequence].[DimProductCategorySequenceObject]
	AS [int]
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	CACHE
GO
CREATE SEQUENCE 
[PKSequence].[DimProductSubcategorySequenceObject]
	AS [int]
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	CACHE
GO
-- =============================================
-- Author: Akash
-- Create date: 11/05/2023
-- Description: Sequence objects for Territory
-- =============================================
CREATE SEQUENCE 
[PKSequence].[DimTerritorySequenceObject]
	AS [int]
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	CACHE
GO

CREATE SEQUENCE 
[PKSequence].[DimCustomerSequenceObject]
	AS [int]
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	CACHE
GO

-- =============================================
-- Author: Mudabir Rizvi
-- Create date: 11/12/2023
-- Description: Sequence objects for DimCustomer,Data
-- =============================================

CREATE SEQUENCE
[PKSequence.[DimCustomer]
	AS [int]
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	CACHE
GO


CREATE SEQUENCE
[PKSequence].[Data]
	AS[int]
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	CACHE
GO



