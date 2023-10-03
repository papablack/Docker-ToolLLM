# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set environment variables to non-interactive (this prevents some prompts)
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Warsaw

# Set the working directory
WORKDIR /root

# Install some basic utilities and dependencies
RUN apt-get update 

RUN apt-get install -y \
    jq \
    curl \
    ca-certificates \
    git \
    bzip2 \
    unzip \
    nano \
    zip \
    dos2unix \
    wget \
    htop \
    git-lfs \
    libx11-6

RUN apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    add-apt-repository ppa:graphics-drivers/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        python3.10 \
        python3.10-distutils \
        python3.10-dev \
        python3-pip \
        nvidia-cuda-toolkit && \
        apt-get clean

RUN apt-get update

# Set up NodeJS environment
ENV NODE_VERSION=18.16.1
ENV NVM_DIR="/root/.nvm"

RUN mkdir $NVM_DIR

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash \
    && . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION} \
    && . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION} \
    && . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}

ENV PATH="${NVM_DIR}/versions/node/v${NODE_VERSION}/bin/:${PATH}"

COPY install.sh /var/install.sh
COPY entrypoint.sh /var/entrypoint.sh

COPY ./azure /var/azure
COPY ./training /var/training
COPY ./setenv /var/setenv

RUN chmod -R 777 /var/azure
RUN chmod -R 777 /var/training
RUN chmod -R 777 /var/setenv

RUN chmod +x /var/install.sh
RUN chmod +x /var/entrypoint.sh

RUN chmod -R +x /var/training
RUN chmod -R +x /var/setenv

RUN dos2unix /var/install.sh
RUN dos2unix /var/entrypoint.sh

RUN dos2unix /var/training/pre-process.sh
RUN dos2unix /var/training/train-retriever.sh
RUN dos2unix /var/training/train-llama.sh
RUN dos2unix /var/training/post-train.sh

# Set the working directory to /app
WORKDIR /app

RUN rm -f /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.1
RUN rm -f /usr/lib/x86_64-linux-gnu/libcuda.so.1

# Your entrypoint
ENTRYPOINT ["/var/entrypoint.sh"]
