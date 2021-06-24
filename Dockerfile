FROM alpine as builder

RUN apk add git make cmake libstdc++ gcc g++ automake libtool autoconf linux-headers

WORKDIR /xmrig
# Clone XMRIG
RUN git clone --depth 1 https://github.com/MoneroOcean/xmrig ./ && \
    sed -i 's/kMinimumDonateLevel = 1;/kMinimumDonateLevel = 0;/g' ./src/donate.h && \
    mkdir build && \
    cd scripts && ./build_deps.sh && cd ../build && \
    cmake .. -DXMRIG_DEPS=scripts/deps -DBUILD_STATIC=ON && \
    make -j$(nproc)

FROM alpine

COPY --from=builder /xmrig/build/xmrig /bin/

ENTRYPOINT ["xmrig"]
CMD [ "--help" ]