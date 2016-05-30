# Makefile for the Docker image sqerison/alpine-nodejs
# MAINTAINER: Volodymyr Shynkar <volodymyr.shynkar@gmail.com>

IMAGE = sqerison/alpine-nodejs
VERSIONS = 4.2.2 5.5.0 5.6.0
VERSION =

build:
	  docker build -t sqerison/alpine-nodejs:4.2.2 .

debug:
	  docker run -it --rm sqerison/alpine-nodejs:4.2.2 /bin/sh

run:
	  docker run -i -P sqerison/alpine-nodejs:4.2.2 -v /var/www/html/:/opt/app/ nodejs/422 node index.js