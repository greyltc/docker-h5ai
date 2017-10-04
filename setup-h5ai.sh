#!/usr/bin/env bash

# h5ai deps
pacman -S --noprogressbar --noconfirm --needed zip
pacman -S --noprogressbar --noconfirm --needed ffmpeg
pacman -S --noprogressbar --noconfirm --needed ghostscript
pacman -S --noprogressbar --noconfirm --needed openexr
pacman -S --noprogressbar --noconfirm --needed openjpeg2
pacman -S --noprogressbar --noconfirm --needed libwmf
pacman -S --noprogressbar --noconfirm --needed libwebp
pacman -S --noprogressbar --noconfirm --needed imagemagick

# install h5ai
su docker -c 'pacaur -S --noprogressbar --noedit --noconfirm h5ai'
cp -a /usr/share/webapps/h5ai /srv/http/_h5ai
mv /usr/share/webapps/h5ai/.htaccess /usr/share/webapps/h5ai/.bak.htaccess
cp /usr/share/webapps/h5ai/.bak.htaccess /etc/httpd/conf/extra/h5ai.conf

#indent the whole file
sed  's/^/  /' -i /etc/httpd/conf/extra/h5ai.conf
sed -i '1i\\' /etc/httpd/conf/extra/h5ai.conf
sed -i '1s;^;<Directory /usr/share/webapps/h5ai/>;' /etc/httpd/conf/extra/h5ai.conf
sed -i '1i\\' /etc/httpd/conf/extra/h5ai.conf
sed -i '1i\\' /etc/httpd/conf/extra/h5ai.conf
sed -i '1s;^;Alias /h5ai "/usr/share/webapps/h5ai";' /etc/httpd/conf/extra/h5ai.conf
sed -i '$a </Directory>' /etc/httpd/conf/extra/h5ai.conf

sed -i '$a Include conf/extra/h5ai.conf' /etc/httpd/conf/httpd.conf

# add and enable .htaccess
#ADD .htaccess /srv/http/
#RUN sed -i '/<Directory "\/srv\/http">/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/g' /etc/httpd/conf/httpd.conf

# treat .qc files as text files
#RUN sed -i 's:\["\*\.text", "\*\.txt"\],:\["\*\.text", "\*\.txt", "\*\.qc"\],:g' /srv/http/_h5ai/conf/types.json
