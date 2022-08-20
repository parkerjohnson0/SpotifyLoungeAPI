namespace SpotifyAccess.Builder;

public interface IRequestBuilder
{
   IRequestBuilder Body(string bodyKey, string bodyValue);
   IRequestBuilder ContentType(string contentType);
   IRequestBuilder Authorization(string basic, string authType);
   Task<HttpResponseMessage> Execute(HttpClient client);
}