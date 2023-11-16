USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[LoadStarSchemaData]    Script Date: 11/10/2023 11:13:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		
-- Create date: 
-- Description:	
-- =============================================
ALTER PROCEDURE [Project2].[LoadStarSchemaData]
    -- Add the parameters for the stored procedure here
AS
BEGIN
    SET NOCOUNT ON;

    --
    --	Drop All of the foreign keys prior to truncating tables in the star schema
 	--
    EXEC  [Project2].[DropForeignKeysFromStarSchemaData] @GroupMemberUserAuthorizationKey = 1;
	--
	--	Check row count before truncation
	EXEC	[Project2].[ShowTableStatusRowCount]
		@GroupMemberUserAuthorizationKey = 1,  -- Change -1 to the appropriate UserAuthorizationKey
		@TableStatus = N'''Pre-truncate of tables'''
    --
    --	Always truncate the Star Schema Data
    --
    EXEC  [Project2].[TruncateStarSchemaData] @GroupMemberUserAuthorizationKey = 1;
    --
    --	Load the star schema
    --
    EXEC  [Project2].[Load_DimProductCategory] @GroupMemberUserAuthorizationKey = 2;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimProductSubcategory] @GroupMemberUserAuthorizationKey = 2;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimProduct] @GroupMemberUserAuthorizationKey = 1;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_SalesManagers] @GroupMemberUserAuthorizationKey = 3;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimGender] @GroupMemberUserAuthorizationKey = 3;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimMaritalStatus] @GroupMemberUserAuthorizationKey = 4;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimOccupation] @GroupMemberUserAuthorizationKey = 4;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimOrderDate] @GroupMemberUserAuthorizationKey = 1;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimTerritory] @GroupMemberUserAuthorizationKey = 1;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_DimCustomer] @GroupMemberUserAuthorizationKey = 6;  -- Change -1 to the appropriate UserAuthorizationKey
    EXEC  [Project2].[Load_Data] @GroupMemberUserAuthorizationKey = 6;  -- Change -1 to the appropriate UserAuthorizationKey
  --
    --	Recreate all of the foreign keys prior after loading the star schema
    --
 	--
	--	Check row count before truncation
	EXEC	[Project2].[ShowTableStatusRowCount]
		@GroupMemberUserAuthorizationKey = 1,  -- Change -1 to the appropriate UserAuthorizationKey
		@TableStatus = N'''Row Count after loading the star schema'''
	--
   EXEC [Project2].[AddForeignKeysToStarSchemaData] @GroupMemberUserAuthorizationKey = 1;  -- Change -1 to the appropriate UserAuthorizationKey
    --
END;
SELECT *
FROM DbSecurity.UserAuthorization