using System.Data;
using System.Data.SqlClient;
using Dapper;
using SpotifyAccess.ApiModels;

namespace DBAccess;

//todo have this implement an interface. for mock testing practice
public class DataAccess : IDisposable
{
    private readonly IDbConnection _connection;

    public DataAccess(string connectionString)
    {
        _connection = new SqlConnection(connectionString);
    }

    public async Task<bool> InsertUpdateUser(UserInfo userInfo)
    {
        var parameters = new
        {
            Username = userInfo.Username,
            AccessToken = userInfo.AccessToken,
            DisplayName = userInfo.DisplayName
        };
        int rowsAffected = await _connection.ExecuteAsync(StoredProcedures.sp_InsertUpdateUser, parameters, commandType: CommandType.StoredProcedure);
        return rowsAffected > 0;
    }

    public void Dispose()
    {
        _connection.Dispose();
    }
}