cd ~

git -C spotifylounge/ pull


cd ~/spotifylounge
npm run build


rm -r /var/www/spotifylounge/html/
mkdir /var/www/spotifylounge/html

cp -r ~/spotifylounge/build/* /var/www/spotifylounge/html


git -C SpotifyLoungeAPI/ pull

dotnet build ~/SpotifyLoungeAPI/

rm -r /var/www/spotifylounge/SpotifyLoungeAPI/
mkdir /var/www/spotifylounge/SpotifyLoungeAPI
rm -r /var/www/spotifylounge/SpotifyLoungeAPI/
mkdir /var/www/spotifylounge/SpotifyLoungeAPI

rm -r /var/www/spotifylounge/SpotifyLoungeRoomServer/
mkdir /var/www/spotifylounge/SpotifyLoungeRoomServer
rm -r /var/www/spotifylounge/SpotifyLoungeRoomServer/
mkdir /var/www/spotifylounge/SpotifyLoungeRoomServer





cp -r ~/SpotifyLoungeAPI/SpotifyLoungeAPI/bin/Debug/net6.0/* /var/www/spotifylounge/SpotifyLoungeAPI/
cp -r ~/SpotifyLoungeAPI/SpotifyLoungeRoomServer/bin/Debug/net6.0/* /var/www/spotifylounge/SpotifyLoungeRoomServer/

sqlcmd -U sa -i ~/SpotifyLoungeAPI/SQL\ Scripts/InitDB.sql 

systemctl stop spotifyapi.service 
systemctl start spotifyapi.service 

systemctl stop spotifyroomserver.service 
systemctl start spotifyroomserver.service 