using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataTransferObjects
{
    public class Room
    {
        public int? RoomID { get; set; }
        public string? Name { get; set; }
        public string? SongName { get; set; }
        public string? SongArtist { get; set; }
        public string? AlbumPicture { get; set; }
    }
}
