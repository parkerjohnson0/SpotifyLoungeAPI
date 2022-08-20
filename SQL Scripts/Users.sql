USE [SpotifyApp]
GO

/****** Object:  Table [dbo].[Users]    Script Date: 8/20/2022 9:25:44 AM ******/
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

