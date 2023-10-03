#!/bin/bash
cd /app

export PYTHONPATH=/app

echo "Train retriever:"
python3 toolbench/retrieval/train.py \
    --data_path $LLM_DATA_PATH/data/retrieval/G1/ \
    --model_name bert-base-uncased \
    --output_path $LLM_MODELS_PATH/retrieval_model \
    --num_epochs $PREPROCESS_EPOCHS_NUM \
    --train_batch_size $PREPROCESS_BATCH_SIZE  \
    --learning_rate $PREPROCESS_LEARNING_RATE \
    --warmup_steps $PREPROCESS_WARMUP_STEP  \
    --max_seq_length $PREPROCESS_SEQ_LEN
  