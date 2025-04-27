FROM debian:bookworm as build

RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    libcurl4-openssl-dev \
    libexpat1-dev \
    libusb-1.0-0-dev \
    gettext \
    unzip \
    wget

WORKDIR /build

COPY Makefile .
COPY src/ src/

RUN make

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    libusb-1.0-0 \
    && rm -rf /var/lib/apt/lists/*
COPY --from=build /build/whsniff /usr/local/bin/

ENTRYPOINT [ "/usr/local/bin/whsniff" ]
