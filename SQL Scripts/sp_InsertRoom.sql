USE [SpotifyApp]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertRoom]    Script Date: 8/23/2022 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_InsertRoom]
	-- Add the parameters for the stored procedure here
	@Name VARCHAR(50),
	@SongName VARCHAR(50) = NULL,
	@SongArtist VARCHAR(50) = NULL,
	@AlbumPicture VARCHAR(255) = NULL

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO Rooms(Name, SongName, AlbumPicture, SongArtist) OUTPUT Inserted.RoomID VALUES
	(@Name, @SongName, @AlbumPicture, @SongArtist)
	
END
