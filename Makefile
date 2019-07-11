#
#   Simple makefile for golang project
#
#   Alex Shvid
#
#

GO_VER := 1.12.2
IMAGE := ubuntu-golang
VERSION := $(GO_VER)-$(shell git describe --tags --always --dirty)
REGISTRY := shvid

all: build

version:
	@echo $(VERSION)

build:
	docker build -t $(REGISTRY)/$(IMAGE):$(VERSION) --build-arg GO_VER=$(GO_VER) -f Dockerfile .

run: build
	docker run $(REGISTRY)/$(IMAGE):$(VERSION) go version

push: build
	docker push ${REGISTRY}/${IMAGE}:${VERSION}
	docker tag ${REGISTRY}/${IMAGE}:${VERSION} ${REGISTRY}/${IMAGE}:latest
	docker push ${REGISTRY}/${IMAGE}:latest
