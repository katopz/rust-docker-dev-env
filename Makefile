.PHONY: default build release clean

default: build ;

RUST_VERSION := 1.59.0
IMAGE_USER := katopz
IMAGE_NAME := rust-dev-env-origin
DOCKER_FILE := ./origin.Dockerfile
IMAGE := $(IMAGE_USER)/$(IMAGE_NAME)

build:
	docker build \
		-t $(IMAGE):$(RUST_VERSION) \
		-f $(DOCKER_FILE) \
		--build-arg=rust_version=$(RUST_VERSION) \
		$(dir $(realpath $(firstword $(MAKEFILE_LIST))))

release:
	docker push $(IMAGE):latest
	docker push $(IMAGE):$(RUST_VERSION)

clean:
	docker rmi -f \
		$(IMAGE):latest \
		$(IMAGE):$(RUST_VERSION) \
