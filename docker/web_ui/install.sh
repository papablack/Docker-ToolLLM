#!/bin/bash

if [ ! -f /var/.ui_install_done ]; then
    cd /llm_ui
    chmod -R 777 .
    
    node /var/fix_llm_ui.js        

    npm install
    npm run build

    touch /var/.ui_install_done
fi
