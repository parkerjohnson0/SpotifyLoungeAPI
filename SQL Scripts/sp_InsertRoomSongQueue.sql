USE [SpotifyApp]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertRoomSongQueue]    Script Date: 8/26/2022 11:29:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_InsertRoomSongQueue]
	-- Add the parameters for the stored procedure here
	@RoomID BIGINT,
	@SongName varchar(50),
	@SongArtist varchar(50),
	@AlbumPicture varchar(255),
	@SongURI varchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @position INT = (SELECT TOP 1 Position FROM RoomSongQueue WHERE RoomID=@RoomID ORDER BY Position DESC);
	IF @position IS NULL
		SET @position = 1
	ELSE
		SET @position = @position + 1

	INSERT INTO RoomSongQueue(RoomID, SongName, SongArtist, AlbumPicture, SongURI, Position) VALUES 
		(@RoomID,@SongName, @SongArtist, @AlbumPicture, @SongURI, @position)
END;