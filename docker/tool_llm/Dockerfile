# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /app

# Install wget
RUN apt-get update && apt-get install -y curl unzip dos2unix nano && rm -rf /var/lib/apt/lists/*


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

COPY fix_ui.js /var/fix_llm_ui.js
COPY ./training/train-llama.sh /var/training/train-llama.sh
COPY ui_scripts.json /var/llm_ui_scripts.json

RUN chmod +x /var/fix_llm_ui.js
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
