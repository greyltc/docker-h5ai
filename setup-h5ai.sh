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
mv /usr/share/webapps/h5ai /srv/http/_h5ai

