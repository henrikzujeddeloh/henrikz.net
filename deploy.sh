#!/usr/bin/env bash

rm -r ./public

hugo

rsync -r --delete ./public henrik@henrikz.net:/home/henrik/docker/caddy/data/
