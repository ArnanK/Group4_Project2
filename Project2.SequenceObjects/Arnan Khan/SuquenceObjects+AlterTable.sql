-- =============================================
-- Author: Arnan Khan
-- Create date: 11/05/2023
-- Description: Sequence objects for DimProduct, DimProductCategory, DimProductSubcategory
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

