#!/bin/bash

# Get the path to the JSON file from the first CLI argument
json_file_path="$1"

# Read the JSON file and set environment variables
jq -r 'to_entries[] | .key + "=" + (.value | tostring)' "$json_file_path" | while IFS= read -r env_var; do
  export "$env_var"
done