USE [SpotifyApp]
GO

/****** Object:  Table [dbo].[Rooms]    Script Date: 8/26/2022 11:07:24 PM ******/
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
	[ProgressMS] [BIGINT] NULL
 CONSTRAINT [PK_Rooms] PRIMARY KEY CLUSTERED 
(
	[RoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

