USE [BIClass]

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
	UserAuthorizationKey int NOT NULL,
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
ALTER TABLE [CH01-01-Dimension].[DimProductCategory] ADD  CONSTRAINT [DF_DimProductCategory_ProductCategoryKey]  DEFAULT (NEXT VALUE FOR [PKSequence].[DimProductCategorySequenceObject]) FOR [ProductCategoryKey]
GO

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
	CONSTRAINT FK_DimProductCategory Foreign Key(ProductCategoryKey)
		REFERENCES [CH01-01-Dimension].[DimProductCategory](ProductCategoryKey)
)
ALTER TABLE [CH01-01-Dimension].[DimProductSubcategory] ADD  CONSTRAINT [DF_DimProductSubcategory_ProductSubcategoryKey]  DEFAULT (NEXT VALUE FOR [PKSequence].[DimProductSubcategorySequenceObject]) FOR [ProductSubcategoryKey]
GO


--Alter DimProductTable (Script)
/****** Object:  Table [CH01-01-Dimension].[DimProduct]    Script Date: 11/11/2023 2:40:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
DROP TABLE IF EXISTS [CH01-01-Dimension].[DimProduct];
CREATE TABLE [CH01-01-Dimension].[DimProduct](
	[ProductKey] [int] NOT NULL,
	[ProductSubcategoryKey] [int] NULL,
	[ProductCategory] [varchar](20) NULL,
	[ProductSubcategory] [varchar](20) NULL,
	[ProductCode] [varchar](10) NULL,
	[ProductName] [varchar](40) NULL,
	[Color] [varchar](10) NULL,
	[ModelName] [varchar](30) NULL,
	[UserAuthorizationKey] [int] NOT NULL,
	[DateAdded] [datetime2](7) NOT NULL,
	[DateOfLastUpdate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_DimProduct] PRIMARY KEY CLUSTERED 
(
	[ProductKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [CH01-01-Dimension].[DimProduct] ADD  CONSTRAINT [DF_DimProduct_DateAdded]  DEFAULT (sysdatetime()) FOR [DateAdded]
GO

ALTER TABLE [CH01-01-Dimension].[DimProduct] ADD  CONSTRAINT [DF_DimProduct_DateOfLastUpdated]  DEFAULT (sysdatetime()) FOR [DateOfLastUpdate]
GO

ALTER TABLE [CH01-01-Dimension].[DimProduct] ADD  CONSTRAINT [DF_DimProduct_ProductKey]  DEFAULT (NEXT VALUE FOR [PKSequence].[DimProductSequenceObject]) FOR [ProductKey]
GO

ALTER TABLE [CH01-01-Dimension].[DimProduct]  WITH CHECK ADD  CONSTRAINT [FK_DimProductSubcategory] FOREIGN KEY([ProductSubcategoryKey])
REFERENCES [CH01-01-Dimension].[DimProductSubcategory] ([ProductSubcategoryKey])
GO

ALTER TABLE [CH01-01-Dimension].[DimProduct] CHECK CONSTRAINT [FK_DimProductSubcategory]

-- =============================================
-- Author: Akash
-- Table: 
-- Create date: 11/06/2023
-- Description: 
-- =============================================
GO

/****** Object:  Table [CH01-01-Dimension].[DimOrderDate]    Script Date: 11/12/2023 7:38:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [CH01-01-Dimension].[DimOrderDate](
	[OrderDate] [date] NOT NULL,
	[MonthName] [varchar](10) NULL,
	[MonthNumber] [int] NULL,
	[Year] [int] NULL,
	[UserAuthorizationKey] [int] NOT NULL,
	[DateAdded] [datetime2](7) NOT NULL,
	[DateOfLastUpdate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_DimOrderDate] PRIMARY KEY CLUSTERED 
(
	[OrderDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [CH01-01-Dimension].[DimOrderDate] ADD  CONSTRAINT [DF_DimOrderDate_DateAdded]  DEFAULT (sysdatetime()) FOR [DateAdded]
GO

ALTER TABLE [CH01-01-Dimension].[DimOrderDate] ADD  CONSTRAINT [DF_DimOrderDate_DateOfLastUpdated]  DEFAULT (sysdatetime()) FOR [DateOfLastUpdate]
GO

/****** Object:  Table [CH01-01-Dimension].[DimTerritory]    Script Date: 11/12/2023 7:54:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [CH01-01-Dimension].[DimTerritory](
	[TerritoryKey] [int] NOT NULL,
	[TerritoryGroup] [varchar](20) NULL,
	[TerritoryCountry] [varchar](20) NULL,
	[TerritoryRegion] [varchar](20) NULL,
	[UserAuthorizationKey] [int] NOT NULL,
	[DateAdded] [datetime2](7) NOT NULL,
	[DateOfLastUpdate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_DimTerritory] PRIMARY KEY CLUSTERED 
(
	[TerritoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [CH01-01-Dimension].[DimTerritory] ADD  CONSTRAINT [DF_DimTerritory_DateAdded]  DEFAULT (sysdatetime()) FOR [DateAdded]
GO

ALTER TABLE [CH01-01-Dimension].[DimTerritory] ADD  CONSTRAINT [DF_DimTerritory_DateOfLastUpdated]  DEFAULT (sysdatetime()) FOR [DateOfLastUpdate]
GO

ALTER TABLE [CH01-01-Dimension].[DimTerritory] ADD  CONSTRAINT [DF_DimTerritory_TerritoryKey]  DEFAULT (NEXT VALUE FOR [PKSequence].[DimTerritorySequenceObject]) FOR [TerritoryKey]
GO



GO

GO

/****** Object:  Table [CH01-01-Fact].[Data]    Script Date: 11/12/2023 7:21:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [CH01-01-Fact].[Data](
	[SalesKey] [int] NOT NULL,
	[SalesManagerKey] [int] NULL,
	[OccupationKey] [int] NULL,
	[TerritoryKey] [int] NULL,
	[ProductKey] [int] NULL,
	[CustomerKey] [int] NULL,
	[ProductCategory] [varchar](20) NULL,
	[SalesManager] [varchar](20) NULL,
	[ProductSubcategory] [varchar](20) NULL,
	[ProductCode] [varchar](10) NULL,
	[ProductName] [varchar](40) NULL,
	[Color] [varchar](10) NULL,
	[ModelName] [varchar](30) NULL,
	[OrderQuantity] [int] NULL,
	[UnitPrice] [money] NULL,
	[ProductStandardCost] [money] NULL,
	[SalesAmount] [money] NULL,
	[OrderDate] [date] NULL,
	[MonthName] [varchar](10) NULL,
	[MonthNumber] [int] NULL,
	[Year] [int] NULL,
	[CustomerName] [varchar](30) NULL,
	[MaritalStatus] [char](1) NULL,
	[Gender] [char](1) NULL,
	[Education] [varchar](20) NULL,
	[Occupation] [varchar](20) NULL,
	[TerritoryRegion] [varchar](20) NULL,
	[TerritoryCountry] [varchar](20) NULL,
	[TerritoryGroup] [varchar](20) NULL,
 CONSTRAINT [PK_Data] PRIMARY KEY CLUSTERED 
(
	[SalesKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



