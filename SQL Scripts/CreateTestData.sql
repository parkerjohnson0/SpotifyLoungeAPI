--test rooms
EXEC sp_InsertRoom @Name= 'Room 1', @SongName='Kyoto', @AlbumPicture='https://i.scdn.co/image/ab67616d0000b273a91b75c9ef65ed8d760ff600', 
	@SongArtist='Phoebe Bridgers'
EXEC sp_InsertRoom @Name= 'Room 2', @SongName='The Modern Age', @AlbumPicture='https://i.scdn.co/image/ab67616d0000b27313f2466b83507515291acce4', 
@SongArtist='The Strokes'
EXEC sp_InsertRoom @Name= 'Room 3', @SongName='Words', @AlbumPicture='https://i.scdn.co/image/ab67616d0000b273af202a7e0acbdedb41c25de4', 
@SongArtist='Feint, Laura Brehm'

EXEC sp_InsertRoomSongQueue @RoomID = 3, @SongName='Soma', @SongArtist='The Strokes', @SongURI = 'spotify:track:6gU7ohksNd6LsEJMWfDRhp', @AlbumPicture='https://i.scdn.co/image/ab67616d0000b27313f2466b83507515291acce4'
EXEC sp_InsertRoomSongQueue @RoomID = 3, @SongName='Barely Legal', @SongArtist='The Strokes', @SongURI = 'spotify:track:21Ay8Y9Pr91nSauPGtK6MW', @AlbumPicture='https://i.scdn.co/image/ab67616d0000b27313f2466b83507515291acce4'
EXEC sp_InsertRoomSongQueue @RoomID = 3, @SongName='Someday', @SongArtist='The Strokes', @SongURI = 'spotify:track:7hm4HTk9encxT0LYC0J6oI', @AlbumPicture='https://i.scdn.co/image/ab67616d0000b27313f2466b83507515291acce4'
EXEC sp_InsertRoomSongHistory @RoomID = 3, @SongName='Life Is Simple in the Moonlight', @SongArtist='The Strokes', @SongURI = 'spotify:track:4ileLT7ldd2uX8bMemWqbm', @AlbumPicture='https://i.scdn.co/image/ab67616d0000b273397d02cfe1aab2923f9d1697'
EXEC sp_InsertRoomSongHistory @RoomID = 3, @SongName='Machu Picchu', @SongArtist='The Strokes', @SongURI = 'spotify:track:6mVD1SfTvlFAPVi7txFL5H', @AlbumPicture='https://i.scdn.co/image/ab67616d0000b273397d02cfe1aab2923f9d1697'
EXEC sp_InsertRoomSongHistory @RoomID = 3, @SongName='Call Me Back', @SongArtist='The Strokes', @SongURI = 'spotify:track:6z5mh42xSM54RncKZMM8hS', @AlbumPicture='https://i.scdn.co/image/ab67616d0000b273397d02cfe1aab2923f9d1697'
