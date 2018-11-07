FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y curl xz-utils

WORKDIR /opt/
RUN curl 'https://nodejs.org/dist/v10.13.0/node-v10.13.0-linux-x64.tar.xz' | tar xJ
ENV PATH="/opt/node-v10.13.0-linux-x64/bin:${PATH}"
ENV NODE_PATH /opt/node-v10.13.0-linux-x64/lib/node_modules

WORKDIR /opt
RUN npm install -g puppeteer-core minimist

WORKDIR /workdir
VOLUME /workdir