USE [SpotifyApp]
GO

/****** Object:  Table [dbo].[RoomSongQueue]    Script Date: 8/26/2022 11:07:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RoomSongQueue](
	[RoomID] [bigint] NOT NULL,
	[SongName] [varchar](50) NULL,
	[SongArtist] [varchar](50) NULL,
	[SongURI] [varchar](255) NULL,
	[AlbumPicture] [varchar](255) NULL,
	[Position] [int] NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[RoomSongQueue]  WITH CHECK ADD  CONSTRAINT [FK_RoomSongQueue_Rooms] FOREIGN KEY([RoomID])
REFERENCES [dbo].[Rooms] ([RoomID])
GO

ALTER TABLE [dbo].[RoomSongQueue] CHECK CONSTRAINT [FK_RoomSongQueue_Rooms]
GO

