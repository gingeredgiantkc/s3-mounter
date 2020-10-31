FROM ubuntu:18.04

ENV MNT_POINT /var/s3fs

ARG S3FS_VERSION=v1.87

RUN apt-get update -qq
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq \
 git \
 automake \
 curl \
 build-essential \
 libcurl4-openssl-dev \
 libssl-dev \
 libfuse-dev \
 libtool \
 libxml2-dev mime-support \
 tar \
 pkg-config \
 && rm -rf /var/lib/apt/lists/*
 
RUN git clone https://github.com/s3fs-fuse/s3fs-fuse.git; \
  cd s3fs-fuse; \
  git checkout tags/${S3FS_VERSION}; \
  ./autogen.sh; \
  ./configure --prefix=/usr; \
  make; \
  make install; \
  make clean; \ 

RUN mkdir -p "$MNT_POINT"

COPY run.sh run.sh
CMD ./run.sh
