using DataTransferObjects;
using DBAccess;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;

namespace SpotifyLoungeAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RoomQueueController : ControllerBase
    {
        HttpClient _client;
        public RoomQueueController(IHttpClientFactory factory)
        {
            _client = factory.CreateClient();
        }
        [HttpGet]
        public async Task<ActionResult> RoomQueue([FromQuery] long RoomID)
        {
            //todo return list of rooms queued songs
            using (var connection = new DataAccess(ConnectionManager.GetConnectionString()))
            {
                List<QueuedSong> queue = await connection.GetQueuedSongs(RoomID);
                return Ok(queue);
            };
        }
        [HttpPost]
        public async Task<ActionResult> RoomQueue([FromBody] QueuedSong song)
        {
            //todo return list of rooms queued songs
            using (var connection = new DataAccess(ConnectionManager.GetConnectionString()))
            {
                await connection.InsertRoomSongQueue(song);
                return Ok();
            };
        }
    }
}
