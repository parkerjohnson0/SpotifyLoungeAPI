USE [SpotifyApp]
GO

/****** Object:  Table [dbo].[RoomSongHistory]    Script Date: 8/26/2022 11:07:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RoomSongHistory](
	[RoomID] [bigint] NULL,
	[SongName] [varchar](50) NULL,
	[SongArtist] [varchar](50) NULL,
	[SongURI] [varchar](50) NULL,
	[AlbumPicture] [varchar](255) NULL,
	[DatePlayed] [datetime] NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[RoomSongHistory]  WITH CHECK ADD  CONSTRAINT [FK_RoomSongHistory_Rooms] FOREIGN KEY([RoomID])
REFERENCES [dbo].[Rooms] ([RoomID])
GO

ALTER TABLE [dbo].[RoomSongHistory] CHECK CONSTRAINT [FK_RoomSongHistory_Rooms]
GO

