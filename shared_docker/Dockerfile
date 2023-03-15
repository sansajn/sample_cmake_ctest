FROM ubuntu:22.04
MAINTAINER Adam Hlavatovic

ARG UID
ARG USER=developer

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

# create $USER user (and change password to $USER)
RUN useradd -d /home/${USER} -l -U -G sudo -m -s /bin/bash -u ${UID} ${USER}
RUN echo "root:${USER}" | chpasswd
RUN echo "${USER}:${USER}" | chpasswd

VOLUME ["/sample_cmake_ctest"]

# switch to user
USER ${USER}
WORKDIR /home/${USER}
