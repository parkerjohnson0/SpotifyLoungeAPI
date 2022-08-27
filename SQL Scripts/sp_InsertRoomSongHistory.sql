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
ALTER PROCEDURE sp_InsertRoomSongHistory
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

	INSERT INTO RoomSongHistory(RoomID, SongName, SongArtist, AlbumPicture, SongURI, DatePlayed ) VALUES 
		(@RoomID,@SongName, @SongArtist, @AlbumPicture, @SongURI, GETUTCDATE())
END
GO
