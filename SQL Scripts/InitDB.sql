DROP TABLE RoomSongHistory
DROP TABLE RoomSongQueue

DROP TABLE ChatMessages
DROP TABLE RoomUserMap
DROP TABLE Users
DROP TABLE Rooms

DROP PROC sp_DeleteRoomUserMap
DROP PROC sp_DequeueSong
DROP PROC sp_GetRecentChatMessages
DROP PROC sp_GetRooms
DROP PROC sp_GetRoomSongQueue
DROP PROC sp_GetUser
DROP PROC sp_InsertChatMessage
DROP PROC sp_InsertRoom
DROP PROC sp_InsertRoomSongQueue
DROP PROC sp_InsertRoomSongHistory
DROP PROC sp_InsertUpdateUser
DROP PROC sp_StartNextSongInRoom
DROP PROC sp_UpdateRoom



GO

/****** Object:  Table [dbo].[Rooms]    Script Date: 2/14/2023 2:02:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Rooms](
	[RoomID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[SongName] [varchar](50) NULL,
	[AlbumPicture] [varchar](255) NULL,
	[SongArtist] [varchar](50) NULL,
	[CurrentlyPlaying] [bit] NULL,
	[ProgressMS] [bigint] NULL,
	[AlbumURI] [varchar](255) NULL,
	[AlbumContext] [smallint] NULL,
	[DurationMS] [bigint] NULL,
 CONSTRAINT [PK_Rooms] PRIMARY KEY CLUSTERED 
(
	[RoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


GO

/****** Object:  Table [dbo].[RoomSongHistory]    Script Date: 2/14/2023 2:02:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RoomSongHistory](
	[RoomID] [bigint] NULL,
	[SongName] [varchar](50) NULL,
	[SongArtist] [varchar](50) NULL,
	[AlbumPicture] [varchar](255) NULL,
	[DatePlayed] [datetime] NULL,
	[DurationMS] [bigint] NULL,
	[AlbumContext] [smallint] NULL,
	[AlbumURI] [varchar](255) NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[RoomSongHistory]  WITH CHECK ADD  CONSTRAINT [FK_RoomSongHistory_Rooms] FOREIGN KEY([RoomID])
REFERENCES [dbo].[Rooms] ([RoomID])
GO

ALTER TABLE [dbo].[RoomSongHistory] CHECK CONSTRAINT [FK_RoomSongHistory_Rooms]
GO

GO

/****** Object:  Table [dbo].[RoomSongQueue]    Script Date: 2/14/2023 2:02:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RoomSongQueue](
	[RoomID] [bigint] NOT NULL,
	[SongName] [varchar](50) NULL,
	[SongArtist] [varchar](50) NULL,
	[AlbumPicture] [varchar](255) NULL,
	[Position] [int] NULL,
	[AlbumContext] [smallint] NULL,
	[AlbumURI] [varchar](255) NULL,
	[DurationMS] [bigint] NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[RoomSongQueue]  WITH CHECK ADD  CONSTRAINT [FK_RoomSongQueue_Rooms] FOREIGN KEY([RoomID])
REFERENCES [dbo].[Rooms] ([RoomID])
GO

ALTER TABLE [dbo].[RoomSongQueue] CHECK CONSTRAINT [FK_RoomSongQueue_Rooms]
GO

GO

/****** Object:  Table [dbo].[Users]    Script Date: 2/14/2023 2:02:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Users](
	[UserID] [bigint] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NULL,
	[AccessToken] [varchar](500) NULL,
	[AccessTokenRetrieved] [datetime] NULL,
	[DisplayName] [varchar](50) NULL
) ON [PRIMARY]
GO


GO

/****** Object:  Table [dbo].[RoomUserMap]    Script Date: 2/14/2023 2:02:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RoomUserMap](
	[UserID] [bigint] NOT NULL,
	[RoomID] [bigint] NOT NULL
) ON [PRIMARY]
GO




GO

/****** Object:  Table [dbo].[ChatMessages]    Script Date: 2/14/2023 2:02:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ChatMessages](
	[RoomID] [bigint] NOT NULL,
	[UserID] [bigint] NOT NULL,
	[DatePosted] [datetime] NOT NULL,
	[Message] [nvarchar](280) NOT NULL,
	[MessageID] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_ChatMessages] PRIMARY KEY CLUSTERED 
(
	[MessageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

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
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertUpdateUser]    Script Date: 2/14/2023 1:48:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertUpdateUser]
	-- Add the parameters for the stored procedure here
	@UserID BIGINT = NULL,
	@Username VARCHAR(50) = NULL,
	@AccessToken VARCHAR(500) = NULL,
	@DisplayName VARCHAR(50) = NULL

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF (SELECT COUNT(Username)FROM Users WHERE Username=@Username OR UserID=@UserID) > 0
		UPDATE Users
		SET Username = ISNULL(@Username, Username),
			AccessToken=ISNULL(@AccessToken, AccessToken),
			DisplayName=ISNULL(@DisplayName, DisplayName),
			AccessTokenRetrieved = 
				CASE
					WHEN @AccessToken IS NOT NULL THEN SYSDATETIME()
				END
		OUTPUT inserted.*
		WHERE Username=@Username OR UserID=@UserID
	ELSE
		INSERT INTO Users(Username,AccessToken,AccessTokenRetrieved,DisplayName)
			OUTPUT inserted.*
			VALUES (@Username, @AccessToken, SYSDATETIME(), @DisplayName)

		
END
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertRoomSongQueue]    Script Date: 2/14/2023 1:48:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertRoomSongQueue]
	-- Add the parameters for the stored procedure here
	@RoomID BIGINT,
	@SongName varchar(50),
	@SongArtist varchar(50),
	@AlbumPicture varchar(255),
    @AlbumURI VARCHAR(255),
    @AlbumContext SMALLINT,
	@DurationMS BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @position INT = (SELECT TOP 1 Position FROM RoomSongQueue WHERE RoomID=@RoomID ORDER BY Position DESC);
	IF @position IS NULL
		SET @position = 1
	ELSE
		SET @position = @position + 1

	INSERT INTO RoomSongQueue(RoomID, SongName, SongArtist, AlbumPicture,Position, AlbumURI, AlbumContext, DurationMS) VALUES 
		(@RoomID,@SongName, @SongArtist, @AlbumPicture,  @position, @AlbumURI, @AlbumContext,@DurationMS)
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertRoomSongHistory]    Script Date: 2/14/2023 1:48:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertRoomSongHistory]
	-- Add the parameters for the stored procedure here
	@RoomID BIGINT,
	@SongName varchar(50),
	@SongArtist varchar(50),
	@AlbumPicture varchar(255),
    @AlbumURI VARCHAR(255),
    @AlbumContext SMALLINT,
	@DurationMS BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO RoomSongHistory(RoomID, SongName, SongArtist, AlbumPicture, AlbumURI,AlbumContext, DatePlayed, DurationMS) VALUES 
		(@RoomID,@SongName, @SongArtist, @AlbumPicture, @AlbumURI,@AlbumContext, GETUTCDATE(), @DurationMS)
END
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
CREATE PROCEDURE sp_InsertChatMessage
	-- Add the parameters for the stored procedure here
	@RoomID BIGINT,
	@UserID BIGINT,
	@Message NVARCHAR(280)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	INSERT INTO ChatMessages(DatePosted, Message, RoomID, UserID)
		VALUES  (GETUTCDATE(), @Message, @RoomID, @UserID)
END
GO
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUser]    Script Date: 2/14/2023 1:47:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUser]
	-- Add the parameters for the stored procedure here
	@UserID BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Users WHERE UserID=@UserID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetRoomSongQueue]    Script Date: 2/14/2023 1:47:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetRoomSongQueue]
	@RoomID BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM RoomSongQueue WHERE RoomID=@RoomID ORDER BY Position
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetRooms]    Script Date: 2/14/2023 1:47:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetRooms]

	@RoomID BIGINT = NULL,
	@Name varchar(100) = NULL,
	@SongName varchar(100) = NULL,
	@SongArtist varchar(100) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.


	DECLARE @RoomUsers AS TABLE(RoomID BIGINT, UserID BIGINT)
	INSERT INTO @RoomUsers(RoomID, UserID) SELECT DISTINCT RoomID, UserID FROM RoomUserMap 
		
    -- Insert statements for procedure here
	SELECT r.*, COUNT(roomusers.UserID) as NumUsers FROM Rooms r
	LEFT JOIN @RoomUsers roomusers
	ON roomusers.RoomID= r.RoomID
	WHERE (r.RoomID = @RoomID OR @RoomID IS NULL) 
	AND (r.Name = @Name OR @Name IS NULL) 
	AND (r.SongName = @SongName OR @SongName IS NULL) 
	AND (r.SongArtist = @SongArtist OR @SongArtist IS NULL) 

	GROUP BY r.RoomID, r.Name, r.AlbumPicture, r.CurrentlyPlaying, r.SongArtist, r.SongName,r.ProgressMS, r.AlbumURI, r.AlbumContext, r.DurationMS

END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetRecentChatMessages]    Script Date: 11/13/2022 3:15:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetRecentChatMessages]
	-- Add the parameters for the stored procedure here
	@RoomID BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT TOP(20) cm.*, u.DisplayName FROM ChatMessages cm
	INNER JOIN Users u
	ON u.UserID = cm.UserID
	WHERE cm.RoomID=@RoomID
	AND DATEDIFF(DAY,GetUTCDATE(), DatePosted) < 1
	ORDER BY DatePosted DESC
END
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
CREATE PROCEDURE sp_DeleteRoomUserMap
	-- Add the parameters for the stored procedure here
	@RoomID BIGINT,
	@UserID BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM RoomUserMap WHERE RoomID= @RoomID
	AND UserID=@UserID
END
GO
