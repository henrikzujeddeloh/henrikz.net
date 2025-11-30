#!/usr/bin/env bash

rsync -r --delete ./public henrik@henrikz.net:/home/henrik/docker/caddy/data/
