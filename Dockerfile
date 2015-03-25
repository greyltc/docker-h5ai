FROM l3iggs/lamp
MAINTAINER l3iggs <l3iggs@live.com>

# h5ai deps
RUN sudo pacman -Suy --noconfirm --needed zip
#RUN sudo pacman -Suy --noconfirm --needed ffmpeg
RUN sudo pacman -Suy --noconfirm --needed ghostscript openexr openjpeg2 libwmf libwebp imagemagick

# install h5ai
RUN yaourt -Suya --noconfirm --needed h5ai
RUN sudo mv /srv/http/h5ai /srv/http/_h5ai

# add and enable .htaccess
ADD .htaccess /srv/http/
RUN sudo sed -i '/<Directory "\/srv\/http">/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/g' /etc/httpd/conf/httpd.conf

# treat .qc files as text files
RUN sudo  sed -i 's:\["\*\.text", "\*\.txt"\],:\["\*\.text", "\*\.txt", "\*\.qc"\],:g' /srv/http/_h5ai/conf/types.json

# remove info.php
RUN sudo rm /srv/http/info.php

# start apache and mysql
CMD cd '/usr'; sudo /usr/bin/mysqld_safe --datadir='/var/lib/mysql'& sudo apachectl -DFOREGROUND
