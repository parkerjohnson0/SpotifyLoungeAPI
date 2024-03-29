USE [SpotifyApp]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertRoomUserMap]    Script Date: 2/14/2023 1:48:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertRoomUserMap]
	-- Add the parameters for the stored procedure here
	@RoomID BIGINT,
	@UserID BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO RoomUserMap(UserID, RoomID) VALUES (@UserID, @RoomID)
END
