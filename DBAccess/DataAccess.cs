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

    public async Task<UserInfo> InsertUpdateUser(UserInfo userInfo)
    {
        var parameters = new
        {
            Username = userInfo.Username,
            AccessToken = userInfo.AccessToken,
            DisplayName = userInfo.DisplayName
        };
         return await _connection.QuerySingleAsync<UserInfo>(StoredProcedures.sp_InsertUpdateUser, parameters, commandType: CommandType.StoredProcedure);
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
    //public async Task<bool> InsertRoom(Room room)
    //{

    //}

    public void Dispose()
    {
        _connection.Dispose();
    }
}