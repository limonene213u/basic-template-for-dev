#!/bin/sh

docker-compose run rails-app rails new . --force --database=postgresql --skip-bundle
