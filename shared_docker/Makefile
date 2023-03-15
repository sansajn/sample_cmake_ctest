HOSTNAME ?= cmake_test_shared
IMAGE_NAME ?= ${HOSTNAME}:1.0
CONTAINER_NAME ?= ${HOSTNAME}_container

image:
	docker build -t ${IMAGE_NAME} \
		--build-arg UID=`id -u` \
		.

start:
	# create image if it is not already there
	docker images|grep ${HOSTNAME} \
	|| make image
	
	docker run -it --name ${CONTAINER_NAME} -d \
		-v `realpath ..`:/sample_cmake_ctest -w /sample_cmake_ctest \
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
	docker exec ${CONTAINER_NAME} rm -rf build

build: start clean
	docker exec ${CONTAINER_NAME} cmake -S . -B build
	docker exec ${CONTAINER_NAME} cmake --build build -j16

test: start
	docker exec ${CONTAINER_NAME} ctest --test-dir build --output-on-failure --output-junit junit.report

.PHONY: image start join stop rm purge clean build test
