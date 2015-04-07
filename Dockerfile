FROM alpine:3.1
MAINTAINER Adrian Fedoreanu, adrian.fedoreanu@gmail.com

ENV LUAJIT_VERSION 2.0.3
ENV TURBO_VERSION 1.1.1

RUN ["apk", "--update", "add", "build-base", "openssl-dev"]
 
RUN wget http://luajit.org/download/LuaJIT-$LUAJIT_VERSION.tar.gz && \
  gunzip LuaJIT-$LUAJIT_VERSION.tar.gz && \
  tar xf LuaJIT-$LUAJIT_VERSION.tar && \
  cd LuaJIT-$LUAJIT_VERSION && \
  make && \
  make install && \
  cd .. && \
  rm -rf luajit-$LUA_VERSION luajit-$LUA_VERSION.tar

RUN wget http://s3-eu-west-1.amazonaws.com/quikkly-jpeg/turbo-$TURBO_VERSION.tar.gz && \
  gunzip turbo-$TURBO_VERSION.tar.gz && \
  tar xf turbo-$TURBO_VERSION.tar && \
  cd turbo-v.$TURBO_VERSION && \
  make LUAJIT_VERSION=$LUAJIT_VERSION && \
  make install && \
  cd .. && \
  rm -rf turbo-v.$TURBO_VERSION turbo-$TURBO_VERSION.tar

#RUN apk del build-base && \
 # rm -rf /var/cache/apk/*

RUN ["apk", "del", "build-base", "openssl-dev"]

RUN ["apk", "add", "libgcc"]

RUN rm -rf /var/cache/apk/*

WORKDIR /source

ADD . ./

EXPOSE 8888

ENTRYPOINT ["luajit", "json-server.lua"]
