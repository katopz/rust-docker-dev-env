FROM rust:slim-buster
RUN cargo install cargo-watch
COPY ./watch-run.sh /usr/local/bin/watch-run.sh
VOLUME /usr/app
WORKDIR /usr/app