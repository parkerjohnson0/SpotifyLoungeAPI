USE [SpotifyApp]
GO
/****** Object:  StoredProcedure [dbo].[sp_StartNextSongInRoom]    Script Date: 2/14/2023 1:48:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
----
---- Use the Specify Values for Template Parameters 
---- command (Ctrl-Shift-M) to fill in the parameter 
---- values below.
----
---- This block of comments will not be included in
---- the definition of the procedure.
---- ================================================
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
---- =============================================
---- Author:		<Author,,Name>
---- Create date: <Create Date,,>
---- Description:	<Description,,>
---- =============================================
CREATE PROCEDURE [dbo].[sp_StartNextSongInRoom]
--	-- Add the parameters for the stored procedure here
	@RoomID BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @temp TABLE (RoomID BIGINT,SongName VARCHAR(50), AlbumPicture VARCHAR(255),SongArtist VARCHAR(50),
	AlbumURI VARCHAR(255), AlbumContext SMALLINT, DurationMS BIGINT) 
	INSERT INTO @temp (RoomID, SongName,AlbumPicture, SongArtist, AlbumURI, AlbumContext, DurationMS)
	SELECT TOP 1 RoomID, SongName,AlbumPicture, SongArtist,AlbumURI, AlbumContext, DurationMS FROM RoomSongQueue

	WHERE RoomID = @RoomID
		ORDER BY Position ASC
	--SELECT * FROM @temp

	--todo update room with information from temp table
	IF EXISTS(SELECT 1 FROM @temp)
		BEGIN

			UPDATE Rooms 
			SET Rooms.AlbumContext=[@temp].AlbumContext,
			Rooms.AlbumPicture=[@temp].AlbumPicture,
			Rooms.AlbumURI=[@temp].AlbumURI,
			Rooms.DurationMS=[@temp].DurationMS,
			Rooms.SongArtist=[@temp].SongArtist,
			Rooms.SongName=[@temp].SongName,
			Rooms.ProgressMS = 0
			FROM @temp
			WHERE Rooms.RoomID=[@temp].RoomID

			exec sp_DequeueSong @RoomID=@RoomID, @Position=1

		END



END
