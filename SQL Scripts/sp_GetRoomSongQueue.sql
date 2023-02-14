USE [SpotifyApp]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetRoomSongQueue]    Script Date: 2/14/2023 1:47:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetRoomSongQueue]
	@RoomID BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM RoomSongQueue WHERE RoomID=@RoomID ORDER BY Position
END
