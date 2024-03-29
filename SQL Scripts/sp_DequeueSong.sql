USE [SpotifyApp]
GO
/****** Object:  StoredProcedure [dbo].[sp_DequeueSong]    Script Date: 2/14/2023 1:43:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DequeueSong]
	-- Add the parameters for the stored procedure here
	@RoomID BIGINT,
	@Position INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--delete song from parameter
    DELETE FROM RoomSongQueue
	WHERE RoomID=@RoomID
	AND Position = @Position

	--get the rest of the songs and increment their positions by 1
	UPDATE 
	RoomSongQueue
	SET Position=Position-1
	WHERE RoomID=@RoomID
END
