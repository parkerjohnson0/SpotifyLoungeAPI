using DataTransferObjects;
using DBAccess;
using Microsoft.AspNetCore.Connections.Features;
using Microsoft.AspNetCore.SignalR;

namespace SpotifyLoungeRoomServer.Hubs
{
    public class RoomHub : Hub
    {
        private static ChatUsersList _connectedUsers = new ChatUsersList();
        public async Task<dynamic> Connected(int userID, int roomID )
        {
            await Groups.AddToGroupAsync(Context.ConnectionId, roomID.ToString());
            SetupHeartbeat();
            if (!ConnectedToRoom(userID, roomID))
            {
                var newUser = new RoomUserMap(userID, roomID);
                Console.WriteLine($"User {userID} connected to room {roomID}");
                using (DataAccess connection = new DataAccess(ConnectionManager.GetConnectionString()))
                {
                    await connection.InsertRoomUserMap(newUser);
                }
                var user = _connectedUsers.Add(newUser, Context.ConnectionId);
                return new
                {
                    Error = false,
                    IsLeader =user.IsLeader 
                };
            }
            return new
            {
                Error = true,
                IsLeader =false 
            };
            //await Clients.All.SendAsync("messageReceived", username, message);
            //await Task.Delay(100);
            //return new {IsLeader = true };
        }
        //public async Task Connected(int userID, int roomID)
        //{
        //    await Groups.AddToGroupAsync(Context.ConnectionId, roomID.ToString());
        //    SetupHeartbeat();
        //    if (!ConnectedToRoom(userID, roomID))
        //    {
        //        var newUser = new RoomUserMap(userID,roomID);
        //        Console.WriteLine($"User {userID} connected to room {roomID}");
        //        using (DataAccess connection = new DataAccess(ConnectionManager.GetConnectionString()))
        //        {
        //             await connection.InsertRoomUserMap(newUser);
        //        }
        //        _connectedUsers.Add(newUser, Context.ConnectionId);
        //    }
        //    await Clients.All.SendAsync("messageReceived", username, message);  
        //}

        public async Task RefreshQueue(int roomID, string connectionID)
        {
            await Clients.GroupExcept(roomID.ToString(), connectionID).SendAsync("refreshQueue");
        }

        private void SetupHeartbeat()
        {
            var heartbeat = Context.Features.Get<IConnectionHeartbeatFeature>();
            heartbeat.OnHeartbeat(state =>
            {
                (HttpContext context, string connectionID) = ((HttpContext, string)) state;
                Console.WriteLine("Heartbeat for connection: " + connectionID + "at " + DateTime.Now);

            }, (Context.GetHttpContext(), Context.ConnectionId));
        }
        public async Task ChatMessage(string message, int userID, string roomID)
        {
            using (DataAccess connection = new DataAccess(ConnectionManager.GetConnectionString()))
            {
                UserInfo user = await connection.GetUser(userID);
                await Clients.Group(roomID).SendAsync("newChatMessage",user.DisplayName,message);
                await connection.InsertChatMessage(message, userID, roomID);
            }
            //todo save message into chat message table
        }
        public async Task Disconnected(int userID, int roomID)
        {
            //TODO update this with new stuff
            //if (ConnectedToRoom(userID, roomID))
            //{
            //    var newUser = new RoomUserMap(userID, roomID);
            //    _connectedUsers.Add(newUser);
            //    Console.WriteLine($"User {userID} disconnect from room {roomID}");
            //    using (DataAccess connection = new DataAccess(ConnectionManager.GetConnectionString()))
            //    {
            //        await connection.DeleteRoomUserMap(newUser);
            //    }
            //    _connectedUsers.RemoveAll(x => x.UserID == userID && x.RoomID == roomID);
            //}
            //await Clients.All.SendAsync("messageReceived", username, message);  
            await Groups.RemoveFromGroupAsync(Context.ConnectionId, roomID.ToString());
            if (ConnectedToRoom(userID, roomID))
            {
                var newUser = new RoomUserMap(userID, roomID);
                Console.WriteLine($"User {userID} disconnected from room {roomID}");
                using (DataAccess connection = new DataAccess(ConnectionManager.GetConnectionString()))
                {
                    await connection.DeleteRoomUserMap(newUser);
                }
                var user = _connectedUsers.Remove(Context.ConnectionId);
                if (user.IsLeader)
                {
                    var groupUsers = _connectedUsers.Where(x => x.RoomUserMap.RoomID == roomID);
                    if  (groupUsers.Count() != 0)
                    {
                        var newLeader = groupUsers.ElementAt(0);
                        newLeader.IsLeader = true;
                        await Clients.Client(newLeader.ConnectionID).SendAsync("newLeaderSelected");
                    }
                }
            }
        }
        public async Task NewLeaderSelected(string connectionID, long roomID)
        {
            var groupUsers = _connectedUsers.Where(x => x.RoomUserMap.RoomID == roomID);
            if  (groupUsers.Count() != 0)
            {
                foreach (var item in groupUsers)
                {
                    item.IsLeader = false;
                }
            }
            var user = groupUsers.FirstOrDefault(x => x.ConnectionID == connectionID);
            user.IsLeader = true;
            await Clients.Client(user.ConnectionID).SendAsync("newLeaderSelected");
        }
        public override Task OnDisconnectedAsync(Exception? exception)
        {
            return base.OnDisconnectedAsync(exception);
        }
        private bool ConnectedToRoom(int userID, long roomID)
        {
            return (_connectedUsers.Any(x => x.RoomUserMap.RoomID == roomID && x.RoomUserMap.UserID == userID
                && x.ConnectionID == Context.ConnectionId));
        }
        public async Task StartNextSong(long roomID)
        {
            //todo update db to next songs information
            //todo send event to all group members to refetch room data
            using (DataAccess connection = new DataAccess(ConnectionManager.GetConnectionString()))
            {
                await connection.StartNextSong(roomID);
            }
            await Clients.Groups(roomID.ToString()).SendAsync("refreshRoom");
        }

    }
}
