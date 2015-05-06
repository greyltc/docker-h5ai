FROM l3iggs/lamp-aur
MAINTAINER l3iggs <l3iggs@live.com>

# h5ai deps
RUN sudo pacman -S --noconfirm --needed zip
RUN sudo pacman -S --noconfirm --needed ffmpeg
RUN sudo pacman -S --noconfirm --needed ghostscript
RUN sudo pacman -S --noconfirm --needed openexr
RUN sudo pacman -S --noconfirm --needed openjpeg2
RUN sudo pacman -S --noconfirm --needed libwmf
RUN sudo pacman -S --noconfirm --needed libwebp
RUN sudo pacman -S --noconfirm --needed imagemagick

# install h5ai
RUN yaourt -S --noconfirm --needed h5ai
RUN sudo mv /usr/share/webapps/h5ai /srv/http/_h5ai

# add and enable .htaccess
ADD .htaccess /srv/http/
RUN sudo sed -i '/<Directory "\/srv\/http">/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/g' /etc/httpd/conf/httpd.conf

# treat .qc files as text files
RUN sudo  sed -i 's:\["\*\.text", "\*\.txt"\],:\["\*\.text", "\*\.txt", "\*\.qc"\],:g' /srv/http/_h5ai/conf/types.json

# remove info.php
RUN sudo rm /srv/http/info.php

# start servers
ENV START_APACHE true
ENV START_MYSQL false
CMD ["sudo","-E","/root/startServers.sh"]
