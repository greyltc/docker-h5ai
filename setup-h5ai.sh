#!/usr/bin/env bash

# h5ai deps
pacman -S --noprogressbar --noconfirm --needed zip
pacman -S --noprogressbar --noconfirm --needed ffmpeg
#pacman -S --noprogressbar --noconfirm --needed ghostscript
#pacman -S --noprogressbar --noconfirm --needed openexr
#pacman -S --noprogressbar --noconfirm --needed openjpeg2
#pacman -S --noprogressbar --noconfirm --needed libwmf
#pacman -S --noprogressbar --noconfirm --needed libwebp
pacman -S --noprogressbar --noconfirm --needed imagemagick
pacman -S --noprogressbar --noconfirm --needed tar
pacman -S --noprogressbar --noconfirm --needed coreutils

# install h5ai
su docker -c 'pacaur -S --noprogressbar --noedit --noconfirm h5ai'
mv /usr/share/webapps/h5ai /srv/http/_h5ai
chown http /srv/http/_h5ai/private/cache
chown http /srv/http/_h5ai/public/cache

# use h5ai for index
sed -i 's,DirectoryIndex index.html,DirectoryIndex index.html /_h5ai/public/index.php,g' /etc/httpd/conf/httpd.conf

#enable .htaccess
sed -i '/<Directory "\/srv\/http">/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/g' /etc/httpd/conf/httpd.conf

# treat .qc files as text files
#RUN sed -i 's:\["\*\.text", "\*\.txt"\],:\["\*\.text", "\*\.txt", "\*\.qc"\],:g' /srv/http/_h5ai/conf/types.json
