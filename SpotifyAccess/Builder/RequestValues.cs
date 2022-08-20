namespace SpotifyAccess.Builder.StaticValues
{
    public static class AuthValue
    {
        public static readonly string Basic =
            "ZTgzOGI2NzIyZDFiNDBmZWIxMTZlNTM5YWUyZTYxZGE6M2I1NDAzZDNmMGYyNDI3YThiOWM3Y2Q2ZWMzNjg1MjU=";
    }

    public static class QueryParam
    {
        public static readonly string ClientID = "client_id";
        public static readonly string ResponseType = "response_type";
        public static readonly string Redirect_URI = "redirect_uri";
    }

    public static class Body
    {
        public static readonly string GrantType = "grant_type";
        public static readonly string Code = "code";
        public static readonly string Redirect_URI = "redirect_uri";
    }

    public static class ContentType
    {
        public static readonly string FormEncoded = "application/x-www-form-urlencoded";
    }

    public static class AuthType
    {
        public static readonly string Bearer = "Bearer";
        public static readonly string Basic = "Basic";
    }
}