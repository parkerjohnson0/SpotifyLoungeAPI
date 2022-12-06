namespace DBAccess;

public static class StoredProcedures
{
    public static string sp_InsertUpdateUser = "sp_InsertUpdateUser";
    public static string sp_InsertRoom = "sp_InsertRoom";
    public static string sp_GetRooms = "sp_GetRooms";
    public static string sp_GetRecentChatMessages = "sp_GetRecentChatMessages";
    internal static string sp_InsertRoomUserMap = "sp_InsertRoomUserMap";
    internal static string sp_DeleteRoomUserMap = "sp_DeleteRoomUserMap";
    internal static string sp_UpdateRoom = "sp_UpdateRoom";
    internal static string sp_GetRoomSongQueue = "sp_GetRoomSongQueue";
    internal static string sp_GetUser = "sp_GetUser";
    internal static string sp_InsertChatMessage = "sp_InsertChatMessage";
    internal static string sp_InsertRoomSongQueue = "sp_InsertRoomSongQueue";
    internal static string sp_StartNextSongInRoom = "sp_StartNextSongInRoom";
}