USE [SpotifyApp]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertRoom]    Script Date: 8/17/2022 9:15:03 PM ******/
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
	@SongName VARCHAR(50),
	@SongArtist VARCHAR(50),
	@SongPicture VARCHAR(255)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO Rooms(Name, SongName, SongPicture, SongArtist) VALUES
	(@Name, @SongName, @SongPicture, @SongArtist)
	
END
