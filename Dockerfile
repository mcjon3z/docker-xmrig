FROM alpine as builder

RUN apk --no-cache add git make cmake libstdc++ gcc g++ libuv-dev openssl-dev && \
    apk add hwloc-dev --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted

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

RUN apk --no-cache add libuv-dev openssl-dev && \
    apk add hwloc-dev --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted

ENTRYPOINT ["xmrig"]
CMD [ "--help" ]