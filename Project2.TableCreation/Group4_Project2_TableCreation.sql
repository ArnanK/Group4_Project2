USE [BIClass]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Arnan Khan
-- Table: Process.WorkflowSteps
-- Create date: 11/05/2023
-- Description: Info about workflow for project 2.
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Process')
BEGIN
    EXEC('CREATE SCHEMA Process')
END
GO
DROP TABLE IF EXISTS Process.WorkflowSteps;
CREATE TABLE Process.WorkflowSteps
(
	WorkFlowStepKey int NOT NULL IDENTITY(1,1),
	UserAuthorizationKey int NOT NULL,
	WorkFlowStepDescription nvarchar(100) NOT NULL,
	WorkFlowStepTableRowCount int NULL
		CONSTRAINT DFT_WorkflowSteps_WorkFlowStepTableRowCount DEFAULT(0),
	StartingDateTime datetime2(7) NULL
		CONSTRAINT DFT_WorkflowSteps_StartingDateTime DEFAULT(SYSDATETIME()),
	EndingDateTime datetime2(7) NULL
		CONSTRAINT DFT_WorkflowSteps_EndingDateTime DEFAULT(SYSDATETIME()),
	ClassTime char(5) NULL
		CONSTRAINT DFT_WorkflowSteps_ClassTime DEFAULT('09:15'),
	CONSTRAINT PK_Workflowsteps Primary Key(WorkFlowStepKey),
	CONSTRAINT FK_UserAuthorizationKey Foreign Key(UserAuthorizationKey)
		REFERENCES DbSecurity.UserAuthorization(UserAuthorizationKey)
);


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Arnan Khan
-- Table: DbSecurity.UserAuthorization
-- Create date: 11/05/2023
-- Description: User GroupMember info for enhanced security.
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'DbSecurity')
BEGIN
    EXEC('CREATE SCHEMA DbSecurity')
END
GO
DROP TABLE IF EXISTS DbSecurity.UserAuthorization;
CREATE TABLE DbSecurity.UserAuthorization
(
	UserAuthorizationKey int NOT NULL IDENTITY(1,1),
	ClassTime char(5) NULL
		CONSTRAINT DFT_WorkflowSteps_ClassTime DEFAULT('09:15'),
	IndividualProject nvarchar(100) NULL
		CONSTRAINT DFT_UserAuthorization_IndividualProject DEFAULT('PROJECT 2 RECREATE THE BICLASS DATABASE STAR SCHEMA'),
	DateAdded datetime2(7) NULL
		CONSTRAINT DFT_UserAuthorization_DateAdded DEFAULT(SYSDATETIME()),
	GroupMemberLastName nvarchar(35) NOT NULL,
	GroupMemberFirstName nvarchar(25) NOT NULL,
	GroupName nvarchar(20) NOT NULL,
	CONSTRAINT PK_UserAuthorization Primary Key(UserAuthorizationKey)
);


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Arnan Khan
-- Table: [CH01-01-Dimension].[DimProductCategory]
-- Create date: 11/06/2023
-- Description: Parent table of ProductSubCategory and Product Tables.
-- =============================================
DROP TABLE IF EXISTS [CH01-01-Dimension].[DimProductCategory];
CREATE TABLE [CH01-01-Dimension].[DimProductCategory]
(
	ProductCategoryKey int NOT NULL,
	ProductCategory varchar(20) NULL,
	UserAuthorizationKey int NOT NULL,
	DateAdded datetime2(7) NULL
		CONSTRAINT DFT_DimProductCategory_DateAdded DEFAULT(SYSDATETIME()),
	DateofLastUpdate datetime2(7) NULL
		CONSTRAINT DFT_DimProductCategory_DateofLastUpdate DEFAULT(SYSDATETIME()),
	CONSTRAINT PK_DimProductCategory Primary Key(ProductCategoryKey)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Arnan Khan
-- Table: [CH01-01-Dimension].[DimProductSubcategory]
-- Create date: 11/06/2023
-- Description: Parent table of Product and children of DimProductCategory.
-- =============================================
DROP TABLE IF EXISTS [CH01-01-Dimension].[DimProductSubcategory];
CREATE TABLE [CH01-01-Dimension].[DimProductSubcategory]
(
	ProductSubcategoryKey int NOT NULL,
	ProductCategoryKey int NOT NULL,
	ProductSubcategory varchar(20) NULL,
	UserAuthorizationKey int NOT NULL,
	DateAdded datetime2(7) NULL
		CONSTRAINT DFT_DimProductSubcategory_DateAdded DEFAULT(SYSDATETIME()),
	DateofLastUpdate datetime2(7) NULL
		CONSTRAINT DFT_DimProductSubcategory_DateofLastUpdate DEFAULT(SYSDATETIME()),
	CONSTRAINT PK_DimProductSubcategory Primary Key(ProductSubcategoryKey),
	CONSTRAINT FK_DimProductSubcategory Foreign Key(ProductCategoryKey)
		REFERENCES [CH01-01-Dimension].[DimProductCategory](ProductCategoryKey)
)

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
go
