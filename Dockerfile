FROM alpine:3.12 as builder

RUN apk --no-cache add git make cmake libstdc++ gcc g++ libuv-dev openssl-dev

RUN echo 'https://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    apk --no-cache add \
    #--repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    hwloc-dev

WORKDIR /xmrig

ARG XMRIG_BUILD_ARGS="-DCMAKE_BUILD_TYPE=Release"

RUN git clone --depth 1 https://github.com/MoneroOcean/xmrig ./ && \
    sed -i 's/kMinimumDonateLevel = 1;/kMinimumDonateLevel = 0;/g' ./src/donate.h && \
    cmake ${XMRIG_BUILD_ARGS} . && \
    make -j$(nproc) && \
    ./xmrig --help

FROM alpine:3.12

COPY --from=builder /xmrig/xmrig /xmrig/scripts/randomx_boost.sh /bin/

RUN apk --no-cache add \
    libuv-dev

RUN echo 'https://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    apk --no-cache add \
    #--repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    hwloc-dev

ENTRYPOINT ["xmrig"]
CMD [ "--help" ]