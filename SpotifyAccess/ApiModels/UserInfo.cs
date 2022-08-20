using System.Text.Json.Serialization;

namespace SpotifyAccess.ApiModels;

public class UserInfo
{
    [JsonPropertyName("display_name")]
    public string DisplayName { get; set; }
    [JsonPropertyName("id")]
    public string Username { get; set; }

    public string AccessToken { get; set; }
}