#!/bin/bash

# Get the path to the JSON file from the first CLI argument
json_file_path=$1

# Read the JSON file and set environment variables
while IFS="=" read -r key value; do
  # Remove quotes from key and value
  key=$(echo $key | tr -d '"')
  value=$(echo $value | tr -d '"')
  
  # Replace [VAR_KEY] in JSON values with ENV values
  matches=$(echo $value | grep -o '\[[^]]*\]')
  for match in $matches; do
    var_key=$(echo $match | tr -d '[]')
    env_value=$(printenv $var_key)
    value=${value//$match/$env_value}
  done
  
  # Remove brackets [] after replacement
  value=$(echo $value | tr -d '[]')
  
  # Export key-value pair as environment variable
  export $key=$value
  
  # Verify that environment variable is set and values are replaced (Optional)
  echo "$key=$value"
done < <(jq -r 'to_entries|map("\(.key)=\(.value|tostring)")|.[]' $json_file_path)