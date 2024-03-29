USE [SpotifyApp]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetRooms]    Script Date: 2/14/2023 1:47:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetRooms]

	@RoomID BIGINT = NULL,
	@Name varchar(100) = NULL,
	@SongName varchar(100) = NULL,
	@SongArtist varchar(100) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.


	DECLARE @RoomUsers AS TABLE(RoomID BIGINT, UserID BIGINT)
	INSERT INTO @RoomUsers(RoomID, UserID) SELECT DISTINCT RoomID, UserID FROM RoomUserMap 
		
    -- Insert statements for procedure here
	SELECT r.*, COUNT(roomusers.UserID) as NumUsers FROM Rooms r
	LEFT JOIN @RoomUsers roomusers
	ON roomusers.RoomID= r.RoomID
	WHERE (r.RoomID = @RoomID OR @RoomID IS NULL) 
	AND (r.Name = @Name OR @Name IS NULL) 
	AND (r.SongName = @SongName OR @SongName IS NULL) 
	AND (r.SongArtist = @SongArtist OR @SongArtist IS NULL) 

	GROUP BY r.RoomID, r.Name, r.AlbumPicture, r.CurrentlyPlaying, r.SongArtist, r.SongName,r.ProgressMS, r.AlbumURI, r.AlbumContext, r.DurationMS

END
