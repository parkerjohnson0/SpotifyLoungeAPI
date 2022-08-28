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
        [HttpPut]
        public async Task JoinRoom(int userID)
        {
            using (var connection = new DataAccess(ConnectionManager.GetConnectionString()))
            {
                //connection.
            }
        }
    }
}
