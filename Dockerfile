FROM alpine:latest

MAINTAINER Volodymyr Shynkar <volodymyr.shynkar@gmail.com>

ENV NPM_VERSION=3 CONFIG_FLAGS="--fully-static" NPM_FLAG="--without-npm" 
ENV DEL_PKGS="curl make gcc g++ binutils-gold python linux-headers paxctl libgcc libstdc++"

#VOLUME ["/var/www/html/", "/opt/app/"]

RUN apk add --no-cache curl make gcc g++ binutils-gold python linux-headers paxctl libgcc libstdc++
RUN VERSION=`curl -s https://nodejs.org/dist/latest/ | grep '.tar.gz' | head -1 | cut -d'-' -f2` \
  &&  curl -sSL https://nodejs.org/dist/${VERSION}/node-${VERSION}.tar.gz | tar -xz \
  &&  cd /node-${VERSION} \
  &&  ./configure --prefix=/usr ${CONFIG_FLAGS} \
  &&    make --jobs=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
  &&    make install \
  &&  paxctl -cm /usr/bin/node \
  &&  cd / \
  &&  if [ -x /usr/bin/npm ]; then \
        npm install -g npm@${NPM_VERSION} && \
        find /usr/lib/node_modules/npm -name test -o -name .bin -type d | xargs rm -rf; \
      fi \
  &&  apk del ${DEL_PKGS} \
  &&  rm -rf /etc/ssl /node-${VERSION} /usr/include \
        /usr/share/man /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp \
        /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html

#EXPOSE 8888
#EXPOSE 3000

#CMD ["node", "index.js"]