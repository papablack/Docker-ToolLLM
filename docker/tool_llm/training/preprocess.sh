#!/bin/bash
cd /app

export PYTHONPATH=/app

if [ ! -d $LLM_DATA_PATH/data/answer/toolllama_G1_dfs.json ]; then
  echo "Preprocess retriever data:"
  python preprocess/preprocess_retriever_data.py \
      --query_file $LLM_DATA_PATH/data/instruction/G1_query.json \
      --index_file $LLM_DATA_PATH/data/test_query_ids/G1_instruction_test_query_ids.json \
      --dataset_name G1 \
      --output_dir $LLM_DATA_PATH/data/retrieval/G1

  echo "Preprocess ToolLlama data:"
  python preprocess/preprocess_toolllama_data.py \
      --tool_data_dir $LLM_DATA_PATH/data/answer/G1_answer \
      --method DFS_woFilter_w2 \
      --output_file $LLM_DATA_PATH/data/answer/toolllama_G1_dfs.json
fi

echo "Train retriever:"
python toolbench/retrieval/train.py \
    --data_path $LLM_DATA_PATH/data/retrieval/G1/ \
    --model_name bert-base-uncased \
    --output_path $LLM_MODELS_PATH/retrieval_model \
    --num_epochs $PREPROCESS_EPOCHS_NUM \
    --train_batch_size $PREPROCESS_BATCH_SIZE \
    --learning_rate $PREPROCESS_LEARNING_RATE \
    --warmup_steps $PREPROCESS_WARMUP_STEP \
    --max_seq_length $PREPROCESS_SEQ_LEN
  