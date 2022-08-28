USE [SpotifyApp]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetRooms]    Script Date: 8/28/2022 3:18:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetRooms]

	@RoomID BIGINT = NULL,
	@Name varchar(100) = NULL,
	@SongName varchar(100) = NULL,
	@SongArtist varchar(100) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.




    -- Insert statements for procedure here
	SELECT r.*, COUNT(u.UserID) as NumUsers FROM Rooms r
	LEFT JOIN Users u
	ON u.RoomID = r.RoomID
	WHERE (r.RoomID = @RoomID OR @RoomID IS NULL) 
	AND (r.Name = @Name OR @Name IS NULL) 
	AND (r.SongName = @SongName OR @SongName IS NULL) 
	AND (r.SongArtist = @SongArtist OR @SongArtist IS NULL) 
	GROUP BY r.RoomID, r.Name, r.AlbumPicture, r.CurrentlyPlaying, r.SongArtist, r.SongName

END
