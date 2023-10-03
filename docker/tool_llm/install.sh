#!/bin/bash

if [ ! -f /var/.llm_install_done ]; then
    echo "alias python='python3'" >> /root/.bashrc
    # Install any needed packages specified in requirements.txt
    
    cd /app
    pip install --no-cache-dir -r /app/requirements.txt
    pip install azureml-sdk
    pip uninstall bitsandbytes
    cd /root
    rm -rf bitsandbytes
    git clone https://github.com/TimDettmers/bitsandbytes.git
    cd bitsandbytes
    python3 setup.py install
    cd /app   
    touch /var/.llm_install_done
fi
