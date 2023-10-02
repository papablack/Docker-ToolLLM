cd /app

export PYTHONPATH=/app

python toolbench/inference/toolbench_server.py \
    --tool_root_dir $LLM_DATA_PATH/data/toolenv/tools/ \
    --corpus_tsv_path $LLM_DATA_PATH/data/retrieval/G1/corpus.tsv \
    --retrieval_model_path $LLM_MODELS_PATH/retrival_model \
    --retrieved_api_nums 5 \
    --backbone_model toolllama \
    --model_path $LLM_MODELS_PATH/llama-2-7b \
    --max_observation_length 1024 \
    --method DFS_woFilter_w2 \
    --input_query_file data/test_instruction/G1_instruction.json \
    --output_answer_file toolllama_lora_dfs_open_domain_result \
    --rapidapi_key $RAPIDAPIKEY