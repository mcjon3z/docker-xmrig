FROM alpine as builder

RUN apk add git make cmake libstdc++ gcc g++ automake libtool autoconf linux-headers

WORKDIR /xmrig

ARG XMRIG_BUILD_ARGS="-DCMAKE_BUILD_TYPE=Release -DXMRIG_DEPS=scripts/deps -DBUILD_STATIC=ON"

RUN git clone --depth 1 https://github.com/MoneroOcean/xmrig ./ && \
    sed -i 's/kMinimumDonateLevel = 1;/kMinimumDonateLevel = 0;/g' ./src/donate.h && \
    cd scripts && ./build_deps.sh && cd .. && \
    cmake ${XMRIG_BUILD_ARGS} . && \
    make -j$(nproc) && \
    ./xmrig --help

FROM alpine

COPY --from=builder /xmrig/xmrig /bin/

ENTRYPOINT ["xmrig"]
CMD [ "--help" ]