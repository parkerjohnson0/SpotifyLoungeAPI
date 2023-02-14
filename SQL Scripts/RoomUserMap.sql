USE [SpotifyApp]
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

