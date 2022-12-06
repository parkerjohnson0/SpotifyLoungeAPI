using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataTransferObjects
{
    public class RoomUserMap
    {
        public RoomUserMap(int userID, int roomID)
        {
            UserID = userID;
            RoomID = roomID;
        }

        public long RoomID { get; set; }
        public long UserID { get; set; }
        public override bool Equals(object? obj)
        {
            var roomUserMap = obj as RoomUserMap;
            return roomUserMap?.RoomID == this.RoomID
                && roomUserMap.UserID == this.UserID;
        }

    }
}
