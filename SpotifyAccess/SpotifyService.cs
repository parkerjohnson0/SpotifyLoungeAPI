using System.Net;
using System.Text.Json;
using DataTransferObjects;
using DBAccess;
using Newtonsoft.Json.Linq;
using SpotifyAccess.Builder;
using SpotifyAccess.Builder.StaticValues;
using Authorization = System.Net.Authorization;

namespace SpotifyAccess
{
    public class SpotifyService : IDisposable
    {
        /// <summary>
        ///  Ephemeral client from IHttpClientFactory, disposed of after each request. This follows Microsoft guidelines.
        /// </summary>
        /// <param name="httpClient"></param>
        private HttpClient _requestClient;

        public SpotifyService(HttpClient httpClient)
        {
            _requestClient = httpClient;
        }

        /// <summary>
        /// Get auth token from Spotify API. Lasts one hour.
        /// </summary>
        /// <param name="code"></param>
        public async Task<UserInfo> GetToken(string code)
        {
            IRequestBuilder request = new PostRequestBuilder("https://accounts.spotify.com/api/token");
                request.Body(Body.Code, code)
                .Body(Body.GrantType, "authorization_code")
                .Body(Body.Redirect_URI, "https://localhost:7040/api/Auth")
                .ContentType(ContentType.FormEncoded)
                .Authorization(AuthType.Basic, AuthValue.Basic);
            HttpResponseMessage response =  await request.Execute(_requestClient);
            JObject obj = JObject.Parse(response.Content.ReadAsStringAsync().Result);
            string accessToken =  (string)obj["access_token"];
            UserInfo user = await GetUserInfo(accessToken);
            
            using (DataAccess connection = new DataAccess(ConnectionManager.GetConnectionString()))
            {
                user = await connection.InsertUpdateUser(user);
            }
            return user;
        }

        private async Task<UserInfo?> GetUserInfo(string? accessToken)
        {
            IRequestBuilder request = new GetRequestBuilder("https://api.spotify.com/v1/me");
            request.Authorization(AuthType.Bearer, accessToken);
            HttpResponseMessage response = await request.Execute(_requestClient);
            UserInfo user = JsonSerializer.Deserialize<UserInfo>(response.Content.ReadAsStream());
            user.AccessToken = accessToken;
            return user;
        }

        public void Dispose()
        {
            _requestClient.Dispose();
        }
    }
}