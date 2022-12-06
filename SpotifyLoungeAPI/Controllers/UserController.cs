using DataTransferObjects;
using DBAccess;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace SpotifyLoungeAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private HttpClient _client;

        public UserController(IHttpClientFactory factory)
        {
            _client = factory.CreateClient();
        }
        [HttpPut("Join")]
        public async Task<IActionResult> JoinRoom([FromBody] RoomUserMap roomUser)
        {
            using (var connection = new DataAccess(ConnectionManager.GetConnectionString()))
            {

                await connection.InsertRoomUserMap(roomUser);
            }
            return Ok();
        }
        [HttpPut("Leave")]
        public async Task<IActionResult> LeaveRoom([FromBody] RoomUserMap roomUser)
        {
            using (var connection = new DataAccess(ConnectionManager.GetConnectionString()))
            {

                await connection.DeleteRoomUserMap(roomUser);
            }
            return Ok();
        }
    }
}
