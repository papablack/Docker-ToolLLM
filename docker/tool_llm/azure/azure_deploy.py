from azureml.core import Workspace, Experiment, Environment, ScriptRunConfig, Dataset
from azureml.core.compute import ComputeTarget

# Connect to your Azure ML workspace
ws = Workspace.from_config()

# Select your compute target
compute_target = ComputeTarget(workspace=ws, name="your-compute-target-name")

# Set up the custom Docker environment
custom_docker_env = Environmgit ent(name="Azure-ToolLLM-env")
custom_docker_env.docker.enabled = True
custom_docker_env.docker.base_image = "thepapablack/docker-tool_llm:latest"
custom_docker_env.python.user_managed_dependencies = True

# Create a script run configuration
src = ScriptRunConfig(
    source_directory="/var/azure",
    script="train_script.py",
    arguments=[],
    compute_target=compute_target,
    environment=custom_docker_env
)

# Submit the experiment
experiment = Experiment(workspace=ws, name="LLM-Training-Experiment")
run = experiment.submit(src)
run.wait_for_completion(show_output=True)
