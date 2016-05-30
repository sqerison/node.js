FROM node:4.4.2
MAINTAINER Volodymyr Shynkar <volodymyr.shynkar@gmail.com>

RUN npm install -g grunt-cli grunt-google-cdn bower phantomjs-prebuilt

RUN useradd -u 1001 -ms /bin/bash jenkins
RUN chmod -R 777 /usr/local/lib/node_modules/
USER jenkins

WORKDIR /sources
