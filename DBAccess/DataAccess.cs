using System.Data;
using System.Data.SqlClient;
using Dapper;
using DataTransferObjects;

namespace DBAccess;

//todo have this implement an interface. for mock testing practice
public class DataAccess : IDisposable
{
    private readonly IDbConnection _connection;

    public DataAccess(string connectionString)
    {
        _connection = new SqlConnection(connectionString);
    }
    public async Task InsertRoomUserMap(RoomUserMap roomUserMap)
    {
        await _connection.ExecuteAsync(StoredProcedures.sp_InsertRoomUserMap, roomUserMap, commandType:CommandType.StoredProcedure);
    }
    public async Task DeleteRoomUserMap(RoomUserMap roomUserMap)
    {
        await _connection.ExecuteAsync(StoredProcedures.sp_DeleteRoomUserMap, roomUserMap, commandType: CommandType.StoredProcedure);
    }

    public async Task<List<ChatMessage>> GetRecentChatMessages(long roomID)
    {
        var parameters = new
        {
            RoomID = roomID
        };
        var messages = await _connection.QueryAsync<ChatMessage>(StoredProcedures.sp_GetRecentChatMessages, parameters, commandType: CommandType.StoredProcedure);
        return messages.ToList();
    }

    public async Task InsertRoomSongQueue(QueuedSong song)
    {
        var parameters = new
        {
            RoomID = song.RoomID,
            SongName = song.SongName,
            SongArtist = song.SongArtist,
            AlbumPicture = song.AlbumPicture,
            AlbumURI = song.AlbumURI,
            AlbumContext = song.AlbumContext,
            DurationMS = song.DurationMS
        };
        await _connection.ExecuteAsync(StoredProcedures.sp_InsertRoomSongQueue, parameters, commandType: CommandType.StoredProcedure);
    }

    public async Task<UserInfo> InsertUpdateUser(UserInfo userInfo)
    {
        var parameters = new
        {
            UserID = userInfo.UserId,
            Username = userInfo.Username,
            AccessToken = userInfo.AccessToken,
            DisplayName = userInfo.DisplayName
        };
         return await _connection.QuerySingleAsync<UserInfo>(StoredProcedures.sp_InsertUpdateUser, parameters, commandType: CommandType.StoredProcedure);
    }

    public async Task<int> CreateRoom(Room room)
    {
        var parameters = new
        {
            Name = room.Name,
            SongName = room.SongName,
            AlbumPicture = room.AlbumPicture,
            SongArtist = room.SongArtist,
        };
        return await _connection.ExecuteAsync(StoredProcedures.sp_InsertRoom, parameters, commandType: CommandType.StoredProcedure);

    }

    public async Task<int> UpdateRoom(Room room)
    {
        var parameters = new
        {
            RoomID = room.RoomID,
            Name = room.Name,
            SongName = room.SongName,
            AlbumPicture = room.AlbumPicture,
            SongArtist = room.SongArtist,
            CurrentlyPlaying = room.CurrentlyPlaying,
            ProgressMS = room.ProgressMS
        };
        return await _connection.ExecuteAsync(StoredProcedures.sp_UpdateRoom, parameters, commandType: CommandType.StoredProcedure);
    }

    public async Task InsertChatMessage(string message, int userID, string roomID)
    {
        var parameters = new
        {
            RoomID = long.Parse(roomID),
            //mismatch between types here, dont think it matters but might be TICKING TIME BOMB IDK
            UserID = userID,
            Message = message
        };
        await _connection.ExecuteAsync(StoredProcedures.sp_InsertChatMessage, parameters, commandType: CommandType.StoredProcedure);
    }

    public async Task<UserInfo> GetUser(int userID)
    {
        var parameters = new
        {
            UserID = userID,
        };
        return await _connection.QuerySingleAsync<UserInfo>(StoredProcedures.sp_GetUser, parameters, commandType: CommandType.StoredProcedure);

    }

    public async Task<List<Room>> GetRooms(Room room = null)
    {

        var parameters = new
        {
            RoomID = room?.RoomID ?? null,
            SongName=room?.SongName ?? null,
            SongArtist = room?.SongArtist ?? null
        };
        var rooms = await _connection.QueryAsync<Room>(StoredProcedures.sp_GetRooms, parameters, commandType: CommandType.StoredProcedure);
        return rooms.ToList();
    }
    public async Task<List<QueuedSong>> GetQueuedSongs(long RoomID)
    {
        //if (room.RoomID is null) return new List<QueuedSong>();

        var parameters = new
        {
            RoomID = RoomID,
        };
        var songs = await _connection.QueryAsync<QueuedSong>(StoredProcedures.sp_GetRoomSongQueue, parameters, commandType: CommandType.StoredProcedure);
        return songs.ToList();
    }
    public void Dispose()
    {
        _connection.Dispose();
    }

    public async Task StartNextSong(long roomID)
    {
        var parameters = new
        {
            RoomID = roomID,
        };
        await _connection.ExecuteAsync(StoredProcedures.sp_StartNextSongInRoom, parameters, commandType: CommandType.StoredProcedure);
    }
}