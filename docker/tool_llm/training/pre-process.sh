#!/bin/bash
cd /app

export PYTHONPATH=/app


echo "Preprocess retriever data:"
python3 preprocess/preprocess_retriever_data.py \
    --query_file $LLM_DATA_PATH/data/instruction/G1_query.json \
    --index_file $LLM_DATA_PATH/data/test_query_ids/G1_instruction.json \
    --dataset_name G1 \
    --output_dir $LLM_DATA_PATH/data/retrieval/G1
