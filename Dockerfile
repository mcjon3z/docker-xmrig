FROM alpine as builder

RUN echo 'https://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    apk update && \
    apk --no-cache add git make cmake libstdc++ gcc g++ libuv-dev openssl-dev hwloc-dev

WORKDIR /xmrig
# Clone XMRIG
RUN git clone --depth 1 https://github.com/MoneroOcean/xmrig ./ && \
    sed -i 's/kMinimumDonateLevel = 1;/kMinimumDonateLevel = 0;/g' ./src/donate.h && \
    mkdir build && \
    cmake . && \
    make && \
    ./xmrig --help

FROM alpine

COPY --from=builder /xmrig/xmrig /bin/

RUN echo 'https://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    apk update && \
    apk --no-cache add libuv-dev openssl-dev hwloc-dev

ENTRYPOINT ["xmrig"]
CMD [ "--help" ]