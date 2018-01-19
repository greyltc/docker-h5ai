#!/usr/bin/env bash
docker stop h5ai
docker rm h5ai
docker pull greyltc/h5ai
docker run \
  --detach=true \
  --restart='always' \
  --name h5ai \
  --env APACHE_ENABLE_PORT_80='true' \
  --publish 2345:80 \
  --mount type=bind,source="$HOME/www",target=/srv/http/pub \
  --tty=false \
  --interactive=false \
  greyltc/h5ai
