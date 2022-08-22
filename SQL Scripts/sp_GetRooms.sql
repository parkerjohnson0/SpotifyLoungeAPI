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
CREATE PROCEDURE sp_GetRooms

	@RoomID BIGINT = NULL,
	@Name varchar(100) = NULL,
	@SongName varchar(100) = NULL,
	@SongArtist varchar(100) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.




    -- Insert statements for procedure here
	SELECT * FROM Rooms
	WHERE (RoomID = @RoomID OR @RoomID IS NULL) 
	AND (Name = @Name OR @Name IS NULL) 
	AND (SongName = @SongName OR @SongName IS NULL) 
	AND (SongArtist = @SongArtist OR @SongArtist IS NULL) 

END
GO
