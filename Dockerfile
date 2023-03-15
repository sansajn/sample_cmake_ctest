FROM ubuntu:22.04
MAINTAINER Adam Hlavatovic

# TODO: remove developer, we do not need it anymore nothing shared with host

RUN apt-get update -y ;\
	apt-get install -y \
		locales \
		sudo \
		pkg-config \
		gcc \
		g++ \
		cmake \ 
		catch2

# set locales
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# copy source files to docker
RUN mkdir /sample_cmake_ctest
COPY * /sample_cmake_ctest/

RUN ls -lah /sample_cmake_ctest

WORKDIR /sample_cmake_ctest
