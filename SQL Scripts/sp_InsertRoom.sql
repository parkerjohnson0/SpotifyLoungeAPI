USE [SpotifyApp]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertRoom]    Script Date: 2/14/2023 1:47:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertRoom]
	-- Add the parameters for the stored procedure here
	@Name VARCHAR(50),
	@SongName VARCHAR(50) = NULL,
	@SongArtist VARCHAR(50) = NULL,
	@AlbumPicture VARCHAR(255) = NULL,
    @AlbumURI VARCHAR(255) = NULL,
    @AlbumContext SMALLINT = NULL,
    @DurationMS BIGINT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO Rooms(Name, SongName, AlbumPicture, SongArtist, CurrentlyPlaying, AlbumURI, AlbumContext, DurationMS, ProgressMS) OUTPUT Inserted.RoomID VALUES
	(@Name, @SongName, @AlbumPicture, @SongArtist, 0, @AlbumURI, @AlbumContext, @DurationMS, 0)
	
END
