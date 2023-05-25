# Dan Gitschooldude : 037 Develop Software Inside a Docker Container : https://www.youtube.com/watch?v=vME5H51UULw

.PHONY: all help devi-build devi-run devi-run-local help
.DEFAULT_GOAL := all

all: ## build the project, in the Docker image or not
	g++ -Wall -O0 -g -o hello hello.cpp box.cpp

clean: ## clean the project, in the Docker image or not
	rm -f hello

devi-build: ## build the required Docker image
	docker build \
	--build-arg hostuser=$(shell whoami) \
	--build-arg hostuid=$(shell id -u) \
	--build-arg hostgid=$(shell id -g) \
	--build-arg hostgrp=$(shell id -g -n) \
	-t devi devi

devi-run: devi-build ## run the Docker image interactively
	docker run -it --rm devi

devi-run-local: devi-build ## run interactive and mirror user settings
	docker run -ti --rm \
	-e HOME=${HOME} \
	-v "${HOME}:${HOME}/" \
	--security-opt seccomp=unconfined \
	-e DISPLAY=${DISPLAY} \
	-u $(shell id -u ${USER} ):$(shell id -g ${USER} ) \
	-w ${PWD} \
	devi

help:
	@echo "docker-live-dev:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo "\nYou probably want to build the Docker image, run it interactively with user settings mirrored"
	@echo "  ... and then create the make commands to build the project for the containered platform."
	@echo
