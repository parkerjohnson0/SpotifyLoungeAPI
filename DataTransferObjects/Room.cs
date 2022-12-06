using Dapper.Contrib.Extensions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataTransferObjects
{
    public class Room
    {
        public long? RoomID { get; set; }
        public string? Name { get; set; }
        public string? SongName { get; set; }
        public string? SongArtist { get; set; }
        public string? AlbumPicture { get; set; }
        [Computed]
        public int? NumUsers { get; set; }
        public long? ProgressMS { get; set; }
        public long? DurationMS { get; set; }
        public bool? CurrentlyPlaying { get; set; }
        public string? AlbumURI { get; set; }
        public int? AlbumContext { get; set; }
    }
}
