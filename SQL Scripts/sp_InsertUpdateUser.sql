USE [SpotifyApp]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertUpdateUser]    Script Date: 2/14/2023 1:48:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertUpdateUser]
	-- Add the parameters for the stored procedure here
	@UserID BIGINT = NULL,
	@Username VARCHAR(50) = NULL,
	@AccessToken VARCHAR(500) = NULL,
	@DisplayName VARCHAR(50) = NULL

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF (SELECT COUNT(Username)FROM Users WHERE Username=@Username OR UserID=@UserID) > 0
		UPDATE Users
		SET Username = ISNULL(@Username, Username),
			AccessToken=ISNULL(@AccessToken, AccessToken),
			DisplayName=ISNULL(@DisplayName, DisplayName),
			AccessTokenRetrieved = 
				CASE
					WHEN @AccessToken IS NOT NULL THEN SYSDATETIME()
				END
		OUTPUT inserted.*
		WHERE Username=@Username OR UserID=@UserID
	ELSE
		INSERT INTO Users(Username,AccessToken,AccessTokenRetrieved,DisplayName)
			OUTPUT inserted.*
			VALUES (@Username, @AccessToken, SYSDATETIME(), @DisplayName)

		
END
