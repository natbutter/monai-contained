#To build this file:
#sudo docker build . -t sydneyinformaticshub/monailabel

# Pull base image.
FROM nvidia/cuda:10.2-cudnn8-devel-ubuntu16.04
MAINTAINER Nathaniel Butterworth USYD SIH

# Set up ubuntu dependencies
RUN apt-get update -y && \
  apt-get install -y wget git build-essential git curl libgl1 libglib2.0-0 libsm6 libxrender1 libxext6 openslide-tools && \
  rm -rf /var/lib/apt/lists/*

# Make the dir everything will go in
WORKDIR /build

# Intall anaconda
ENV PATH="/build/miniconda3/bin:${PATH}"
ARG PATH="/build/miniconda3/bin:${PATH}"
RUN curl -o miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-py38_4.12.0-Linux-x86_64.sh &&\
	mkdir /build/.conda && \
	bash miniconda.sh -b -p /build/miniconda3 &&\
	rm -rf miniconda.sh

RUN conda install pip && pip install --upgrade pip setuptools wheel

RUN pip install torch==1.11.0+cu102 torchvision==0.12.0+cu102 torchaudio==0.11.0 --extra-index-url https://download.pytorch.org/whl/cu102

RUN pip install monailabel

RUN mkdir /project /scratch && touch /usr/bin/nvidia-smi

WORKDIR /project

CMD /bin/bash
#monailabel start_server --app /project/apps/radiology --studies /project/datasets/Task09_Spleen/imagesTr --conf models all
#
