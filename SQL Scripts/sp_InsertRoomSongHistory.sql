USE [SpotifyApp]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertRoomSongHistory]    Script Date: 11/19/2022 10:04:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_InsertRoomSongHistory]
	-- Add the parameters for the stored procedure here
	@RoomID BIGINT,
	@SongName varchar(50),
	@SongArtist varchar(50),
	@AlbumPicture varchar(255),
    @AlbumURI VARCHAR(255),
    @AlbumContext SMALLINT,
	@DurationMS BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO RoomSongHistory(RoomID, SongName, SongArtist, AlbumPicture, AlbumURI,AlbumContext, DatePlayed, DurationMS) VALUES 
		(@RoomID,@SongName, @SongArtist, @AlbumPicture, @AlbumURI,@AlbumContext, GETUTCDATE(), @DurationMS)
END
