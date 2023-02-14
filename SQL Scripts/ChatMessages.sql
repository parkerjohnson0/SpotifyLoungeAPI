USE [SpotifyApp]
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

