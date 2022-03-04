[![Build Status](https://travis-ci.org/marccarre/rust-docker-dev-env.svg?branch=master)](https://travis-ci.org/marccarre/rust-docker-dev-env)
[![Docker Pulls on Quay](https://quay.io/repository/marccarre/rust-dev-env/status 'Docker Repository on Quay')](https://quay.io/repository/marccarre/rust-dev-env)
[![Docker Pulls on DockerHub](https://img.shields.io/docker/pulls/marccarre/rust-dev-env.svg?maxAge=604800)](https://hub.docker.com/r/marccarre/rust-dev-env/)

# rust-docker-dev-env

Rust development environment based on Docker.

### Features

- Image is based on the latest slim version of Debian Jessie.
- Image is kept as small as possible.
- Rust binaries are verified using GPG.
- Rust binaries are pulled from the official repository, hence are based on `glibc`, _NOT_ `musl`: you will therefore _NOT_ be able to compile static Rust binaries.
- `inotify-tools` is pre-installed to allow continuous compilation scripts -- see below example.

### Usage

    $ docker pull marccarre/rust-dev-env

or

    $ docker pull quay.io/marccarre/rust-dev-env

and then either re-use in other images or run one of the below commands:

1.  Interactive shell:

        $ docker run -ti marccarre/rust-dev-env /bin/bash

2.  Interactive shell with current directory mounted:

        $ docker run -ti -v $(pwd):/home/rust marccarre/rust-dev-env /bin/bash

3.  Continuous build with current directory mounted, and assuming directory contains `/home/rust/src/main.rs`:

        $ docker run -ti -v $(pwd):/home/rust marccarre/rust-dev-env build-continuously.sh
        Setting up watches.  Beware: since -r was given, this may take a while!
        Watches established.
        [2017-03-25 20:55:58] MODIFY on main.rs. Rebuilding now...
        Compiling hello v1.0.0 (file:///home/rust)
        Finished dev [unoptimized + debuginfo] target(s) in 1.59 secs

4.  Continuous build with current directory mounted, and assuming `./example/src/main.rs`:

        $ docker run -ti -p 9090:9090 -v $(pwd)/example:/home/rust katopz/rust-dev-env-origin:1.59.0 build-continuously.sh .
        Setting up watches.  Beware: since -r was given, this may take a while!
        Watches established.
        [2017-03-25 20:56:25] MODIFY on main.rs. Rebuilding now...
        Compiling hello v1.0.0 (file:///home/rust)
        Finished dev [unoptimized + debuginfo] target(s) in 1.97 secs

### Sample project

See: https://github.com/marccarre/rust-sample-project

### Build & Release

#### Pre-requisites

- Docker
- `make`
- Internet connection

#### Build

```
$ make
```

#### Release

```
$ docker login
$ docker login quay.io
$ make release
```

---

### Modify to use `cargo-watch` and `rust:slim-buster`

- Working but rebuild time is `1m 50s` vs `1s` 🤔
  > Command

```
make
. ./dev.sh
```

> Image size

```
katopz/helloworld-rust-slim   latest    ca4151b053a6   55 minutes ago   1.04GB
katopz/helloworld-rust        latest    8b8a243e58e6   57 minutes ago   1.24GB
katopz/rust-dev-env           1.59.0    fc77db7c2d9a   2 hours ago      747MB
```
