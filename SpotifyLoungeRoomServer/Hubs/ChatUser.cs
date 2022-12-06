using DataTransferObjects;

namespace SpotifyLoungeRoomServer.Hubs
{
    //todo add convenience methods for checking existence of user in a room
    public class ChatUsersList : List<ChatUser>
    {
        internal ChatUser Add(RoomUserMap newUser, string connectionID)
        {
            var user = new ChatUser()
            {
                RoomUserMap = newUser,
                ConnectionID = connectionID,
                LastPing = DateTime.Now,
                //assign new user as the room leader if room has no current leader
                IsLeader = !this.Any(x => x.IsLeader && x.RoomUserMap.RoomID == newUser.RoomID)
            };
            Add(user);
            return user;
        }
        internal ChatUser Remove(string connectionID)
        {
            //var removeUser = new ChatUser()
            //{
            //    RoomUserMap = user,
            //    ConnectionID = connectionID,
            //};
            var user = this.FirstOrDefault(x => x.ConnectionID == connectionID);
            Remove(user);
            return user;
        }
    }
    public class ChatUser
    {
        public RoomUserMap RoomUserMap { get; set; }
        public string ConnectionID { get; set; }
        public DateTime LastPing { get; set; }
        /// <summary>
        /// Property used to determine which user should send periodic (every 5 seconds) playback updates back to the server
        /// </summary>
        public bool IsLeader { get; set; }
        public override bool Equals(object? obj)
        {
            var chatUser = obj as ChatUser;
            return this.RoomUserMap.Equals(chatUser?.RoomUserMap)
                && this.ConnectionID == chatUser.ConnectionID;
        }

    }
}
