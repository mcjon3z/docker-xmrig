FROM alpine as builder

RUN apk --no-cache add \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    hwloc-dev

RUN apk --no-cache add git make cmake libstdc++ gcc g++ libuv-dev openssl-dev

WORKDIR /xmrig

ARG XMRIG_BUILD_ARGS="-DCMAKE_BUILD_TYPE=Release"

RUN git clone --depth 1 https://github.com/MoneroOcean/xmrig ./ && \
    sed -i 's/kMinimumDonateLevel = 1;/kMinimumDonateLevel = 0;/g' ./src/donate.h && \
    cmake ${XMRIG_BUILD_ARGS} . && \
    make && \
    ./xmrig --help

FROM alpine

COPY --from=builder /xmrig/xmrig /bin/

RUN apk --no-cache add \
    libuv-dev 

RUN apk --no-cache add \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    hwloc-dev

ENTRYPOINT ["xmrig"]
CMD [ "--help" ]