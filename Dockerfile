FROM l3iggs/lamp
MAINTAINER l3iggs <l3iggs@live.com>

# h5ai deps
RUN sudo pacman -Suy --noconfirm --needed zip
RUN sudo pacman -Suy --noconfirm --needed openexr openjpeg2 libwmf librsvg libwebp imagemagick

# install some owncloud optional deps
RUN yaourt -Suya --noconfirm --needed h5ai

# remove info.php
#RUN ruso rm /srv/http/info.php

# start apache and mysql
CMD cd '/usr'; sudo /usr/bin/mysqld_safe --datadir='/var/lib/mysql'& sudo apachectl -DFOREGROUND
