# Dan Gitschooldude : 037 Develop Software Inside a Docker Container : https://www.youtube.com/watch?v=vME5H51UULw

.PHONY: all clean devi-build devi-run devi-run-local

all:
	g++ -Wall -O0 -g -o hello hello.cpp box.cpp

clean:
	rm -f hello

devi-build:
	docker build \
	--build-arg hostuser=$(shell whoami) \
	--build-arg hostuid=$(shell id -u) \
	--build-arg hostgid=$(shell id -g) \
	--build-arg hostgrp=$(shell id -g -n) \
	-t devi devi

devi-run: devi-build
	docker run -it --rm devi

devi-run-local: devi-build
	docker run -ti --rm \
	-e HOME=${HOME} \
	-v "${HOME}:${HOME}/" \
	--security-opt seccomp=unconfined \
	-e DISPLAY=${DISPLAY} \
	-u $(shell id -u ${USER} ):$(shell id -g ${USER} ) \
	-w ${PWD} \
	devi

