USE [SpotifyApp]
GO

/****** Object:  Table [dbo].[RoomUserMap]    Script Date: 8/30/2022 6:43:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RoomUserMap](
	[UserID] [bigint] NOT NULL,
	[RoomID] [bigint] NOT NULL
) ON [PRIMARY]
GO

