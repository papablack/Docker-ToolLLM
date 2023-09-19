#!/bin/bash
cd /app

export PYTHONPATH=/app

python preprocess/preprocess_retriever_data.py \
    --query_file /llm_data/data/instruction/G1_query.json \
    --index_file /llm_data/data/test_query_ids/G1_instruction_test_query_ids.json \
    --dataset_name G1 \
    --output_dir /llm_data/data/retrieval/G1

python toolbench/retrieval/train.py \
    --data_path /llm_data/data/retrieval/G1/ \
    --model_name bert-base-uncased \
    --output_path /llm_data/retrieval_model \
    --num_epochs 5 \
    --train_batch_size 32 \
    --learning_rate 2e-5 \
    --warmup_steps 500 \
    --max_seq_length 256    

python preprocess/preprocess_toolllama_data.py \
    --tool_data_dir /llm_data/data/answer/G1_answer \
    --method DFS_woFilter_w2 \
    --output_file /llm_data/data/answer/toolllama_G1_dfs.json