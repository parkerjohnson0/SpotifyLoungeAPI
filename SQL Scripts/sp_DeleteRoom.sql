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
ALTER PROCEDURE sp_DeleteRoom
	-- Add the parameters for the stored procedure here
	@RoomID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF NOT EXISTS(SELECT UserID FROM RoomUserMap WHERE RoomID=@RoomID)      
		BEGIN
		DELETE RoomUserMap WHERE RoomID=@RoomID
		DELETE RoomSongHistory WHERE RoomID=@RoomID
		DELETE RoomSongQueue WHERE RoomID=@RoomID
		DELETE Rooms WHERE RoomID=@RoomID
		END

END
GO
