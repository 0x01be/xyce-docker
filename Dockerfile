FROM 0x01be/trilinos as trilinos

FROM alpine:3.12.0 as builder

RUN apk add --no-cache --virtual build-dependencies \
    git \
    build-base \
    cmake

RUN git clone --depth 1 https://github.com/Xyce/Xyce /xyce

RUN mkdir /xyce/build/
WORKDIR /xyce/build/

COPY --from=trilinos /opt/trilinos/ /opt/trilinos/

ENV Trilinos_DIR /opt/trilinos/

RUN cmake ..
RUN make
RUN make install

