FROM l3iggs/lamp
MAINTAINER l3iggs <l3iggs@live.com>

# install some owncloud optional deps
RUN yaourt -Suya --noconfirm --needed h5ai

# start apache and mysql
CMD cd '/usr'; sudo /usr/bin/mysqld_safe --datadir='/var/lib/mysql'& sudo apachectl -DFOREGROUND
