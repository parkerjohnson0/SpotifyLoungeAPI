using SpotifyLoungeRoomServer.Hubs;

namespace SpotifyLoungeRoomServer
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);
            builder.Services.AddCors(options =>
            {
                options.AddPolicy(name: "ReactWebApp",
                    policy =>
                    {
                        policy.WithOrigins("http://localhost:3000")
                        .AllowAnyHeader()
                        .AllowCredentials()
                        .AllowAnyMethod();
                    });
            });
            builder.Services.AddSignalR();
            var app = builder.Build();
            app.UseCors("ReactWebApp");
            app.MapHub<RoomHub>("/room");
            app.Run();
        }
    }
}