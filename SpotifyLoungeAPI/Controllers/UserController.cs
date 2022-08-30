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
        public async Task<IActionResult> JoinRoom([FromBody] UserInfo user)
        {
            using (var connection = new DataAccess(ConnectionManager.GetConnectionString()))
            {

                user = await connection.InsertUpdateUser(user);
            }
            if (user.RoomID is not null)
            {
                return Ok(new
                {
                    Success = true
                });

            }
            return Ok(new
            {
                Success = false
            });
        }
    }
}
