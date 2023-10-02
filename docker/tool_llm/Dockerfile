# Use an official Python runtime as a parent image
FROM nvidia/cuda:12.2.0-runtime-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set the working directory in the container
WORKDIR /app

# Install wget
RUN apt-get update && apt-get install -y \
    jq \
    curl \
    ca-certificates \
    git \
    bzip2 \
    unzip \
    nano \
    zip \
    dos2unix \
    htop \
    git-lfs \
    libx11-6

RUN apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        python3.10 \
        python3.10-distutils \
        python3.10-dev \
        python3-pip \
        nvidia-cuda-toolkit && \
        apt-get clean

RUN sh -c 'echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/cuda.list' && \
    sh -c 'echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/cuda_learn.list'    

RUN apt-get install -y --no-install-recommends \
    cuda-11-0 \
    libcudnn8=8.0.4.30-1+cuda11.0  \
    libcudnn8-dev=8.0.4.30-1+cuda11.0

ENV LD_LIBRARY_PATH /usr/local/cuda-11.0/lib64:$LD_LIBRARY_PATH
ENV PATH /usr/local/cuda-11.0/bin:$PATH

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

COPY ./options.json /var/llm_options.json
COPY ./azure /var/azure
COPY ./training /var/training
COPY ./setenv /var/setenv

RUN chmod -R 777 /var/azure
RUN chmod -R 777 /var/training
RUN chmod -R 777 /var/setenv

RUN chmod 777 /var/llm_options.json

COPY ./training/train-llama.sh /var/training/train-llama.sh

RUN chmod +x /var/install.sh
RUN chmod +x /var/entrypoint.sh

RUN chmod -R +x /var/training
RUN chmod -R +x /var/setenv

RUN python /var/setenv/setenv.py /var/llm_options.json

RUN dos2unix /var/install.sh
RUN dos2unix /var/entrypoint.sh

RUN dos2unix /var/training/preprocess.sh
RUN dos2unix /var/training/train-llama.sh
RUN dos2unix /var/training/post-train.sh


# Run entrypoint.sh when the container launches
ENTRYPOINT ["/var/entrypoint.sh"]
