import json
import os
import sys
import re

# Get the path to the JSON file from the first CLI argument
json_file_path = sys.argv[1]

# Read the JSON file
with open(json_file_path, 'r') as f:
    data = json.load(f)

# Replace [VAR_KEY] in JSON values with ENV values
for key, value in data.items():
    if isinstance(value, str):
        matches = re.findall(r'\[(.*?)\]', value)
        for match in matches:
            env_value = os.getenv(match, '')
            value = value.replace(f'[{match}]', env_value)
        data[key] = value

for key, value in data.items():
    os.environ[key] = str(value)        

# Verify that environment variables are set and values are replaced (Optional)
for key in data.keys():
    print(f'{key} = {data[key]}')