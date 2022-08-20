namespace DBAccess;

public static class ConnectionManager
{
    public static string GetConnectionString()
    {
#if DEBUG
        return "Server=DESKTOP-9D6BNJG;Database=SpotifyApp;Trusted_Connection=True;";
#endif
    }
}