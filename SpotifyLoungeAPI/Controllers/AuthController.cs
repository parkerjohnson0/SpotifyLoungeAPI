using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SpotifyAccess;

namespace SpotifyLoungeAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private HttpClient _client;
        public AuthController(IHttpClientFactory factory)
        {
            _client = factory.CreateClient();

        }
        [HttpGet]
        public async Task Auth(string code)
        {
            SpotifyService spotify = new SpotifyService(_client);
            string accessToken = await spotify.GetToken(code);
            Response.Redirect("http://localhost:3000/"+ accessToken);
            //return Ok("Success! You are now authorized with Spotify's API.");
        }

        [HttpGet("check_auth")]
        public IActionResult CheckAuth()
        {
            //todo check db for 
            return NoContent();
        }
    }
}

