-- =============================================
-- Author: Arnan Khan
-- Create date: 11/05/2023
-- Description: Sequence objects for DimProduct, DimProductCategory, DimProductSubcategory
-- =============================================
CREATE SEQUENCE 
[PKSequence].[DimProductSequenceObject]
	AS [int]
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	CACHE
GO
USE BIClass
ALTER TABLE [CH01-01-Dimension].[DimProduct]
ADD [UserAuthorizationKey] [int] NOT NULL;
go
ALTER TABLE [CH01-01-Dimension].[DimProduct]
ADD [DateAdded] [datetime2](7) NOT NULL;
go
ALTER TABLE [CH01-01-Dimension].[DimProduct]
ADD CONSTRAINT [DF_DimProduct_DateAdded] default(sysdatetime()) for [DateAdded]
go
ALTER TABLE [CH01-01-Dimension].[DimProduct]
ADD [DateOfLastUpdate] [datetime2](7) NOT NULL;
go
ALTER TABLE [CH01-01-Dimension].[DimProduct] 
ADD CONSTRAINT [DF_DimProduct_DateOfLastUpdated] default(sysdatetime()) for [DateOfLastUpdate]