USE SpotifyApp
DELETE FROM RoomSongHistory
DELETE FROM RoomSongQueue
DELETE FROM Rooms

BEGIN TRANSACTION
DECLARE @RoomIDs AS TABLE (
	RoomID BIGINT
)
--test rooms

INSERT @RoomIDs EXEC sp_InsertRoom @Name= 'Phoebe Bridgers Fan Club', @SongName='Kyoto', @AlbumPicture='https://i.scdn.co/image/ab67616d0000b273a91b75c9ef65ed8d760ff600', 
	@SongArtist='Phoebe Bridgers', @AlbumURI='spotify:album:6Pp6qGEywDdofgFC1oFbSH', @AlbumContext=2, @DurationMS=184524

INSERT @RoomIDs  EXEC sp_InsertRoom @Name= 'Strokers', @SongName='The Modern Age', @AlbumPicture='https://i.scdn.co/image/ab67616d0000b27313f2466b83507515291acce4', 
@SongArtist='The Strokes',@AlbumURI='spotify:album:2k8KgmDp9oHrmu0MIj4XDE', @AlbumContext=1, @DurationMS=208066

INSERT @RoomIDs EXEC sp_InsertRoom @Name= 'Good Tunez', @SongName='Words', @AlbumPicture='https://i.scdn.co/image/ab67616d0000b273af202a7e0acbdedb41c25de4', 
@SongArtist='Feint, Laura Brehm', @AlbumURI='spotify:album:2bR8ogDs7UucJ0sIXzgHC7', @AlbumContext=0, @DurationMS=276000


DECLARE @ID BIGINT = (SELECT TOP 1 RoomID FROM @RoomIDs)
DECLARE @LAST BIGINT = (SELECT TOP 1 RoomID FROM @RoomIDs ORDER BY RoomID DESC)
SELECT @ID
SELECT @LAST
WHILE @ID <= @LAST
	BEGIN
		SELECT @ID
		EXEC sp_InsertRoomSongQueue @RoomID = @ID, @SongName='Soma', @SongArtist='The Strokes',  @AlbumPicture='https://i.scdn.co/image/ab67616d0000b27313f2466b83507515291acce4',@AlbumURI='spotify:album:2k8KgmDp9oHrmu0MIj4XDE', @AlbumContext=2, @DurationMS=153840
		EXEC sp_InsertRoomSongQueue @RoomID = @ID, @SongName='Barely Legal', @SongArtist='The Strokes', @AlbumPicture='https://i.scdn.co/image/ab67616d0000b27313f2466b83507515291acce4',@AlbumURI='spotify:album:2k8KgmDp9oHrmu0MIj4XDE', @AlbumContext=3, @DurationMS=234693
		EXEC sp_InsertRoomSongQueue @RoomID = @ID, @SongName='Someday', @SongArtist='The Strokes',  @AlbumPicture='https://i.scdn.co/image/ab67616d0000b27313f2466b83507515291acce4',@AlbumURI='spotify:album:2k8KgmDp9oHrmu0MIj4XDE', @AlbumContext=4, @DurationMS=183440
		EXEC sp_InsertRoomSongHistory @RoomID = @ID, @SongName='Life Is Simple in the Moonlight', @SongArtist='The Strokes',  @AlbumPicture='https://i.scdn.co/image/ab67616d0000b273397d02cfe1aab2923f9d1697', @AlbumURI='spotify:album:6Jx4cGhWHewTcfKDJKguBQ',@AlbumContext=9, @DurationMS=255240
		EXEC sp_InsertRoomSongHistory @RoomID = @ID, @SongName='Machu Picchu', @SongArtist='The Strokes', @AlbumPicture='https://i.scdn.co/image/ab67616d0000b273397d02cfe1aab2923f9d1697',@AlbumURI='spotify:album:6Jx4cGhWHewTcfKDJKguBQ',@AlbumContext=0, @DurationMS=209626
		EXEC sp_InsertRoomSongHistory @RoomID = @ID, @SongName='Call Me Back', @SongArtist='The Strokes', @AlbumPicture='https://i.scdn.co/image/ab67616d0000b273397d02cfe1aab2923f9d1697',@AlbumURI='spotify:album:6Jx4cGhWHewTcfKDJKguBQ',@AlbumContext=6, @DurationMS=182026
		SET @ID = @ID + 1
	END

EXEC sp_InsertChatMessage @ID, 1, 'blah blah blah chat message'
EXEC sp_InsertChatMessage @ID, 1, 'i am talking to myself'
EXEC sp_InsertChatMessage @ID, 1, 'fuck you carverj95'
EXEC sp_InsertChatMessage @ID, 1, 'u r mum'
COMMIT TRANSACTION
--ROLLBACK TRANSACTION