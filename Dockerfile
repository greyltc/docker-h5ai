FROM l3iggs/lamp-aur
MAINTAINER l3iggs <l3iggs@live.com>

# h5ai deps
RUN sudo pacman -S --noconfirm --needed zip
RUN sudo pacman -S --noconfirm --needed ffmpeg
RUN sudo pacman -S --noconfirm --needed ghostscript openexr openjpeg2 libwmf libwebp imagemagick

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

# start apache and mysql
CMD cd '/usr'; sudo /usr/bin/mysqld_safe --datadir='/var/lib/mysql'& sudo apachectl -DFOREGROUND
