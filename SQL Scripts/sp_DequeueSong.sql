use SpotifyApp
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
CREATE PROCEDURE sp_DequeueSong
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
	
END
GO
