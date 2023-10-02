#!/bin/bash

export PYTHONPATH=/app
export CUDA_VISIBLE_DEVICES=0
cd /app

python toolbench/inference/qa_pipeline.py \
    --tool_root_dir $LLM_DATA_PATH/data/toolenv/tools/ \
    --backbone_model chatgpt_function \
    --openai_key $OPENAI_KEY \
    --max_observation_length 1024 \
    --method DFS_woFilter_w2 \
    --input_query_file $LLM_DATA_PATH/data/test_instruction/G1_instruction.json \
    --output_answer_file $LLM_DATA_PATH/chatgpt_dfs_inference_result \
    --rapidapi_key $RAPIDAPI_KEY \
    --use_rapidapi_key    

python toolbench/inference/qa_pipeline.py \
    --tool_root_dir $LLM_DATA_PATH/data/toolenv/tools/ \
    --backbone_model toolllama  \
    --model_path $LLM_MODELS_PATH/ToolLLaMA-2-7b \
    --max_observation_length 1024 \
    --observ_compress_method truncate \
    --method DFS_woFilter_w2 \
    --input_query_file $LLM_DATA_PATH/data/instruction/inference_query_demo.json \
    --output_answer_file $LLM_DATA_PATH/inference/chatgpt_to_llama_inference_result \
    --rapidapi_key $RAPIDAPI_KEY \
    --use_rapidapi_key