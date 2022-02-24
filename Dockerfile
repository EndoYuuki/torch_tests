FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
    && apt-get -y upgrade \
    && apt-get install -y --no-install-recommends \
        python3 python3-pip python3-dev python3-tk libgl1-mesa-dev \
        sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

ARG DOCKER_UID=1000
ARG DOCKER_USER=docker
ARG DOCKER_PASSWORD=docker

RUN useradd -m --uid ${DOCKER_UID} --groups sudo ${DOCKER_USER} \
	  && echo ${DOCKER_USER}:${DOCKER_PASSWORD} | chpasswd

RUN chown -R docker /workspace 

USER ${DOCKER_USER}

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install setuptools
COPY requirements.txt /tmp/
RUN python3 -m pip install -r /tmp/requirements.txt