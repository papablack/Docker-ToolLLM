#!/bin/bash

if [ ! -f /var/.llm_install_done ]; then
    # Install any needed packages specified in requirements.txt
    cd /app
    pip install --no-cache-dir -r /app/requirements.txt
    pip install azureml-sdk

    if [ ! -d /llm_data/data ]; then
        if [ ! -d /llm_data ]; then
            mkdir /llm_data
        fi  

        if [ ! -d /llm_data/trained ]; then
            mkdir /llm_data/trained
        fi

        cd /llm_data

        curl -L 'https://docs.google.com/uc?export=download&id=1Vis-RxBstXLKC1W1agIQUJNuumPJrrw0&confirm=yes' -o data.zip
        
        unzip data.zip && rm data.zip

        chmod -R 777 /llm_data        

        sh /var/preprocess.sh
    fi

    chmod -R 777 /llm_ui        

    cd /llm_ui
    
    node /var/fix_llm_ui.js    

    touch /var/.llm_install_done

    npm install
    npm run build
fi
