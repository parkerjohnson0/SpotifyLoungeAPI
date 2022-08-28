USE [SpotifyApp]
GO

/****** Object:  Table [dbo].[Users]    Script Date: 8/28/2022 3:17:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Users](
	[UserID] [bigint] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NULL,
	[AccessToken] [varchar](500) NULL,
	[AccessTokenRetrieved] [datetime] NULL,
	[DisplayName] [varchar](50) NULL,
	[RoomID] [bigint] NULL
) ON [PRIMARY]
GO

