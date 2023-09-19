import subprocess

commands = [
    "export PYTHONPATH=/app",
    "sh /var/training/train-llama.sh",
]

for cmd in commands:
    subprocess.run(cmd, shell=True, check=True)