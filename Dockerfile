FROM greyltc/lamp-aur
MAINTAINER Grey Christoforo <grey@christoforo.net>

# remove info.php
RUN rm /srv/http/info.php

# h5ai deps
RUN pacman -S --noconfirm --needed zip
RUN pacman -S --noconfirm --needed ffmpeg
RUN pacman -S --noconfirm --needed ghostscript
RUN pacman -S --noconfirm --needed openexr
RUN pacman -S --noconfirm --needed openjpeg2
RUN pacman -S --noconfirm --needed libwmf
RUN pacman -S --noconfirm --needed libwebp
RUN pacman -S --noconfirm --needed imagemagick

# install h5ai
RUN su docker -c 'pacaur -m --noprogressbar --noedit --noconfirm h5ai'
RUN mv /usr/share/webapps/h5ai /srv/http/_h5ai

# add and enable .htaccess
ADD .htaccess /srv/http/
RUN sed -i '/<Directory "\/srv\/http">/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/g' /etc/httpd/conf/httpd.conf

# treat .qc files as text files
RUN sed -i 's:\["\*\.text", "\*\.txt"\],:\["\*\.text", "\*\.txt", "\*\.qc"\],:g' /srv/http/_h5ai/conf/types.json

# set some default variables for the startup script
ENV REGENERATE_SSL_CERT false
ENV START_APACHE true
ENV START_MYSQL false

# start the servers, then wait forever
CMD start-servers; sleep infinity
