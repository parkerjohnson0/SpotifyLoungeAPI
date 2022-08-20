using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace SpotifyLoungeAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RoomsController : ControllerBase
    {
        HttpClient _client;
        public RoomsController(IHttpClientFactory factory)
        {
            _client = factory.CreateClient();
        }
        [HttpGet]
        public IActionResult Rooms()
        {
            //todo return list of rooms
            //todo refactor
            var json = new
            {
                response = "test"
            };
            return Ok(json);
        }
    }
}
