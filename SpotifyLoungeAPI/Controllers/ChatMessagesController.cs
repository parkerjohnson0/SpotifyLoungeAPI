using DataTransferObjects;
using DBAccess;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace SpotifyLoungeAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ChatMessagesController : ControllerBase
    {
        HttpClient _client;
        public ChatMessagesController(IHttpClientFactory factory)
        {
            _client = factory.CreateClient();
        }
        [HttpGet]
        public async Task<ActionResult> ChatMessages([FromQuery] long roomID)
        {
            using (var connection = new DataAccess(ConnectionManager.GetConnectionString()))
            {
                List<ChatMessage> messages = await connection.GetRecentChatMessages(roomID);
                return Ok(messages);
            }
        }
    }
}
