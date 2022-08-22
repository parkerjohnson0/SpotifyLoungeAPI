using DataTransferObjects;
using DBAccess;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;

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
        public async Task<ActionResult> Rooms([FromQuery] Room room)
        {
            //todo return list of rooms
            //todo refactor

            using (var connection = new DataAccess(ConnectionManager.GetConnectionString()))
            {
                List<Room> rooms = await connection.GetRooms(room);
                //return Ok(new JsonResult(rooms, new JsonSerializerOptions()
                //{
                //    PropertyNameCaseInsensitive = true,

                //}));
                return Ok(rooms);
            };
        }



    }
}
