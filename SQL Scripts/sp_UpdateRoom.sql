USE [SpotifyApp]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateRoom]    Script Date: 2/14/2023 1:49:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateRoom]
	-- Add the parameters for the stored procedure here
	@RoomID BIGINT,
	@Name VARCHAR(50) = NULL,
	@SongName VARCHAR(50) = NULL,
	@AlbumPicture VARCHAR(255) = NULL,
	@SongArtist VARCHAR(50) = NULL,
	@CurrentlyPlaying BIT = NULL,
	@ProgressMS BIGINT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Rooms 
	SET Name = ISNULL(@Name, Name),
	SongName = ISNULL(@SongName, SongName),
	AlbumPicture = ISNULL(@AlbumPicture, AlbumPicture),
	SongArtist = ISNULL(@SongArtist, SongArtist),
	CurrentlyPlaying = ISNULL(@CurrentlyPlaying, CurrentlyPlaying),
	ProgressMS = ISNULL(@ProgressMS, ProgressMS)
	WHERE RoomID = @RoomID
END
