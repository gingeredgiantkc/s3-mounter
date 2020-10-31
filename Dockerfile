FROM alpine:3.12

ENV MNT_POINT /var/s3fs

ARG S3FS_VERSION=v1.87

RUN apk --update --no-cache add bash fuse libcurl libxml2 libstdc++ libgcc alpine-sdk automake autoconf libxml2-dev fuse-dev curl-dev git; \
    git clone https://github.com/s3fs-fuse/s3fs-fuse.git; \
    cd s3fs-fuse; \
    git checkout tags/${S3FS_VERSION}; \
    ./autogen.sh; \
    ./configure --prefix=/usr; \
    make; \
    make install; \
    make clean; \
    rm -rf /var/cache/apk/*; \
    apk del alpine-sdk automake autoconf libxml2-dev fuse-dev curl-dev git;

RUN mkdir -p "$MNT_POINT"

COPY run.sh run.sh
CMD ./run.sh
