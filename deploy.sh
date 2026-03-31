#!/usr/bin/env bash

rm -r ./public

hugo

rsync -r --delete ./public henrik@neutron.lan:/home/henrik/docker/caddy/data/
