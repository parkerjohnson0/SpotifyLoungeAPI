using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataTransferObjects
{
    public class QueuedSong
    {
        public long RoomID { get; set; }
        public string SongName { get; set; }
        public string SongArtist { get; set; }
        public string AlbumPicture { get; set; }
        public int Position { get; set; }
        public int AlbumContext { get; set; }
        public string AlbumURI { get; set; }
        public long DurationMS { get; set; }
    }
}
