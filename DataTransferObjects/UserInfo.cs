using System.Text.Json.Serialization;

namespace DataTransferObjects;

public class UserInfo
{
    public long UserId { get; set; }
    [JsonPropertyName("display_name")]
    public string DisplayName { get; set; }
    [JsonPropertyName("id")]
    public string Username { get; set; }

    public string AccessToken { get; set; }
    public long RoomID { get; set; }

}