FROM greyltc/lamp-aur
MAINTAINER Grey Christoforo <grey@christoforo.net>

# remove info.php
RUN rm /srv/http/info.php

# uncomment this to update the container's mirrorlist
RUN get-new-mirrors

# install h5ai
ADD setup-h5ai.sh /usr/sbin/setup-h5ai
RUN setup-h5ai

# add and enable .htaccess
#ADD .htaccess /srv/http/
#RUN sed -i '/<Directory "\/srv\/http">/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/g' /etc/httpd/conf/httpd.conf

# treat .qc files as text files
#RUN sed -i 's:\["\*\.text", "\*\.txt"\],:\["\*\.text", "\*\.txt", "\*\.qc"\],:g' /srv/http/_h5ai/conf/types.json

# set some default variables for the startup script
ENV REGENERATE_SSL_CERT false
ENV START_APACHE true
ENV START_MYSQL false

# start the servers, then wait forever
CMD start-servers; sleep infinity
