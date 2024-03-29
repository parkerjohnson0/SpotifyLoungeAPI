USE [SpotifyApp]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetRecentChatMessages]    Script Date: 11/13/2022 3:15:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetRecentChatMessages]
	-- Add the parameters for the stored procedure here
	@RoomID BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT TOP(20) cm.*, u.DisplayName FROM ChatMessages cm
	INNER JOIN Users u
	ON u.UserID = cm.UserID
	WHERE cm.RoomID=@RoomID
	AND DATEDIFF(DAY,GetUTCDATE(), DatePosted) < 1
	ORDER BY DatePosted DESC
END
