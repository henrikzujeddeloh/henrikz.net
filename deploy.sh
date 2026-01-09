#!/usr/bin/env bash

rm -r ./public

hugo

rsync -r --delete ./public henrik@electron.ts:/home/henrik/docker/caddy/data/
