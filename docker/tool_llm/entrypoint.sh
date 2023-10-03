#!/bin/bash
export PYTHONPATH=$PYTHONPATH:/app

sh /var/install.sh

echo "LLM container awaiting action..."


while true; do sleep 15 ; done;
