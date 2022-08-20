USE [SpotifyApp]
GO

/****** Object:  Table [dbo].[Rooms]    Script Date: 8/20/2022 9:28:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Rooms](
	[RoomID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[SongName] [varchar](50) NULL,
	[SongPicture] [varchar](255) NULL,
	[SongArtist] [varchar](50) NULL
) ON [PRIMARY]
GO

