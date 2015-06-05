FROM armbuild/alpine:3.1
MAINTAINER Adrian Fedoreanu <adrian.fedoreanu@gmail.com>

ENV LUAJIT_VERSION 2.0.4
ENV TURBO_VERSION 1.1.4

ADD apk/repositories /etc/apk/

RUN ["apk", "--update", "add", "build-base", "openssl-dev", "curl"]

RUN wget http://luajit.org/download/LuaJIT-$LUAJIT_VERSION.tar.gz && \
  tar xzf LuaJIT-$LUAJIT_VERSION.tar.gz && \
  cd LuaJIT-$LUAJIT_VERSION && \
  make && \
  make install && \
  cd .. && \
  rm -rf luajit-$LUA_VERSION luajit-$LUA_VERSION.tar.gz

RUN curl -L https://github.com/kernelsauce/turbo/archive/v$TURBO_VERSION.tar.gz > turbo-$TURBO_VERSION.tar.gz && \
  tar xzf turbo-$TURBO_VERSION.tar.gz && \
  cd turbo-$TURBO_VERSION && \
  make LUAJIT_VERSION=$LUAJIT_VERSION && \
  make install && \
  cd .. && \
  rm -rf turbo-$TURBO_VERSION turbo-$TURBO_VERSION.tar.gz

RUN ["apk", "del", "build-base", "openssl-dev", "curl"]

RUN ["apk", "add", "libgcc"]

RUN rm -rf /var/cache/apk/*

WORKDIR /source
CMD ["luajit"]
