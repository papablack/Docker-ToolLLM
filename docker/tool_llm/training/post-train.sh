#!/bin/bash

export PYTHONPATH=/app

cd /app

python toolbench/inference/qa_pipeline.py \
    --tool_root_dir $LLM_DATA_PATH/data/toolenv/tools/ \
    --backbone_model $LLM_MODELS_PATH/ToolLLaMA-2-7b \
    --model_path ToolBench/ToolLLaMA-2-7b \
    --max_observation_length 1024 \
    --observ_compress_method truncate \
    --method DFS_woFilter_w2 \
    --input_query_file $LLM_DATA_PATH/data/instruction/inference_query_demo.json \
    --output_answer_file toolllama_dfs_inference_result \
    --rapidapi_key $RAPIDAPI_KEY \
    --use_rapidapi_key