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
        [HttpPost("/api/Rooms/PlaybackState")]
        public async Task<ActionResult> UpdatePlaybackState([FromBody] Room room)
        {
            using (var connection = new DataAccess(ConnectionManager.GetConnectionString()))
            {
                int ret = await connection.UpdateRoom(room);
                return Ok(ret);
            }
        }
        [HttpPost("/api/Rooms/{roomID}")]
        public async Task<ActionResult> Update([FromBody] Room room)
        {
            using (var connection = new DataAccess(ConnectionManager.GetConnectionString()))
            {
                int ret = await connection.UpdateRoom(room);
                return Ok(ret);
            }
        }
        [HttpPost("/api/Rooms/")]
        public async Task<ActionResult> Create([FromBody] Room room)
        {
            using (var connection = new DataAccess(ConnectionManager.GetConnectionString()))
            {
                int ret = await connection.CreateRoom(room);
                return Ok(ret);
            }
        }



    }
}
