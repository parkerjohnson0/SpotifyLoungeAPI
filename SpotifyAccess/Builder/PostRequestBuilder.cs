using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;

namespace SpotifyAccess.Builder
{

    public class PostRequestBuilder : IRequestBuilder
    {
        private Dictionary<string, string> _queries { get; set; }
        private Dictionary<string,string> _body { get; set; }
        private string _contentType;
        private string _url;
        private Dictionary<string, string> _auth { get; set; }

        public PostRequestBuilder(string url)
        {
            _url = url;
            _queries = new Dictionary<string, string>();
            _body = new Dictionary<string, string>();
            _auth = new Dictionary<string, string>();
        }
        public IRequestBuilder Query(string query, string value)
        {
            _queries.Add(query, value);
            return this;
        }


        public IRequestBuilder ContentType(string contentType)
        {
            _contentType = contentType;
            return this;
        }

        public IRequestBuilder Body(string key, string value)
        {
            
            _body.Add(key, value);
            return this;
        }

        public IRequestBuilder Authorization(string authKey, string authValue)
        {
            _auth.Add(authKey, authValue);
            return this;
        }

        public async Task<HttpResponseMessage> Execute(HttpClient client)
        {
            string queryAppend = AppendToUrl();
            var request = new HttpRequestMessage(HttpMethod.Post, _url + queryAppend);
            request.Headers.Authorization = new AuthenticationHeaderValue(_auth.Keys.Single(), _auth.Values.Single());
            request.Content = new FormUrlEncodedContent(_body);
           // client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue(_auth.Keys.Single(), _auth.Values.Single());
           // string json = JsonSerializer.Serialize(_body);
           // var data = new StringContent(json, Encoding.UTF8, _contentType);
            return await client.SendAsync(request);
        }
        private string AppendToUrl()
        {
            if (_queries.Count == 0) return "";
            
            string queryString = "?";
            foreach (var entry in _queries)
            {
                queryString += entry.Key + "=" + entry.Value + "&";
            }

            return queryString.TrimEnd('&');
        }

        //public async Task<T> Execute<T>(HttpClient requestClient)
        //{
        //    await requestClient.
        //    
        //}
    }

}