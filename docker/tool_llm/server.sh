cd /app

export PYTHONPATH=/app

python ./toolbench/inference/toolbench_server.py \
    --tool_root_dir /llm_data/data/toolenv/tools/ \
    --corpus_tsv_path /llm_data/data/retrieval/G1/corpus.tsv \
    --retrieval_model_path /llm_data/retrival_model \
    --retrieved_api_nums 5 \
    --backbone_model toolllama \
    --model_path huggyllama/llama-7b \
    --lora \
    --lora_path /llm_data/trained/toolllama_lora \
    --max_observation_length 1024 \
    --method DFS_woFilter_w2 \
    --input_query_file /llm_data/data/instruction/inference_query_demo_open_domain.json \
    --output_answer_file toolllama_lora_dfs_open_domain_result \
    --rapidapi_key $RAPIDAPIKEY