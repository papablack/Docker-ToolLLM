import subprocess

commands = [
    "export PYTHONPATH=/app",
    "sh /var/azure/train-llama.sh",    
]

for cmd in commands:
    subprocess.run(cmd, shell=True, check=True)