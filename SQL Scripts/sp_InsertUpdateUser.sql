-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE sp_InsertUpdateUser
	-- Add the parameters for the stored procedure here
	@Username VARCHAR(50) = NULL,
	@AccessToken VARCHAR(50) = NULL,
	@DisplayName VARCHAR(50) = NULL

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF (SELECT COUNT(Username)FROM Users WHERE Username=@Username) > 0
		UPDATE Users SET Username = ISNULL(@Username, Username),
			AccessToken=ISNULL(@AccessToken, AccessToken),
			DisplayName=ISNULL(@DisplayName, DisplayName),
			AccessTokenRetrieved = 
				CASE
					WHEN @AccessToken IS NOT NULL THEN SYSDATETIME()
				END;
	ELSE
		INSERT INTO Users(Username,AccessToken,AccessTokenRetrieved,DisplayName)
			VALUES (@Username, @AccessToken, SYSDATETIME(), @DisplayName)
		
END
GO
