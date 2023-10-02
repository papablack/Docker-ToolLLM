#!/bin/bash

if [ ! -f /var/.llm_install_done ]; then
    # Install any needed packages specified in requirements.txt
    cd /root
    pip install --no-cache-dir -r /app/requirements.txt
    pip install azureml-sdk

    pip uninstall bitsandbytes
    git clone https://github.com/TimDettmers/bitsandbytes.git
    cd bitsandbytes
    python setup.py install

    cd /app   
    touch /var/.llm_install_done
fi
