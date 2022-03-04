FROM rust:slim-buster
ARG rust_version
ENV RUST_VERSION ${rust_version}
ENV RUST_ARCH unknown-linux-gnu
ENV RUST_CPU x86_64
LABEL version ${rust_version}
LABEL description "Rust development environment"
LABEL maintainer "Marc Carre <carre.marc@gmail.com>"
RUN apt-get update && apt-get install -y \
        inotify-tools && \
    rm -rf /var/lib/apt/lists/*
COPY ./build-continuously.sh /usr/local/bin/build-continuously.sh
VOLUME /usr/app
WORKDIR /usr/app
