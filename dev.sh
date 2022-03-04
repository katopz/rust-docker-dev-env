docker run -it \
--rm \
--env-file ./.env \
--name rust-dev-env \
-p 9090:9090 \
-v $(pwd)/example:/usr/app \
katopz/rust-dev-env:1.59.0 \
build-continuously.sh .