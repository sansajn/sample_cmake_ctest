# Copy build docker manipulation helper makefile
HOSTNAME ?= cmake_test
IMAGE_NAME ?= ${HOSTNAME}:1.0
CONTAINER_NAME ?= ${HOSTNAME}_container

image:
	docker build -t ${IMAGE_NAME} \
		.

start:
	# create image if it is not already there
	docker images|grep ${HOSTNAME} \
	|| make image
	
	docker run -it --name ${CONTAINER_NAME} -d \
		--network host \
		--hostname ${HOSTNAME} \
		${IMAGE_NAME} \
	|| \
	docker start ${CONTAINER_NAME}

stop:
	docker stop ${CONTAINER_NAME}

join: start
	docker exec -it ${CONTAINER_NAME} /bin/bash

rm: stop
	-docker rm ${CONTAINER_NAME}

purge: rm
	docker rmi ${IMAGE_NAME}

clean: start
	rm -r report
	docker exec ${CONTAINER_NAME} rm -rf build

build: start clean
	docker exec ${CONTAINER_NAME} cmake -S . -B build
	docker exec ${CONTAINER_NAME} cmake --build build -j16

test: build
	docker exec ${CONTAINER_NAME} ctest --test-dir build --output-on-failure --output-junit junit.report
	mkdir report
	docker cp ${CONTAINER_NAME}:/sample_cmake_ctest/build/junit.report report/junit.report

.PHONY: image start join stop rm purge clean build test
