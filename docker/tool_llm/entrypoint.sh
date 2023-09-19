#!/bin/bash
export PYTHONPATH=$PYTHONPATH:/app

sh /var/install.sh

echo "Building docker for $PORT port"

cd /llm_ui

npm run start

while true; do sleep 15 ; done;
