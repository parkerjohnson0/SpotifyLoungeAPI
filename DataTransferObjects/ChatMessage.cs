using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataTransferObjects
{
    public class ChatMessage
    {
        public long MessageID { get; set; }
        public long RoomID { get; set; }
        public long UserID { get; set; }
        public string DisplayName { get; set; }
        public DateTime DatePosted { get; set; }
        public string Message { get; set; }
    }
}
