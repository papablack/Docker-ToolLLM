#!/bin/bash

export PYTHONPATH=/app

cd /app

torchrun --nproc_per_node=$GPU_CORES --master_port=20001 toolbench/train/train_mem.py \
    --model_name_or_path huggyllama/llama-2-7b  \
    --data_path  $LLM_DATA_PATH/data/toolllama_G123_dfs_train.json \
    --eval_data_path  $LLM_DATA_PATH/data/toolllama_G123_dfs_eval.json \
    --conv_template tool-llama-single-round \
    --bf16 $GPU_BF16 \
    --output_dir $LLM_MODELS_PATH/trained/toolllama \
    --num_train_epochs $TRAIN_EPOCHS_NUM \
    --per_device_train_batch_size $TRAIN_BATCH_SIZE \
    --per_device_eval_batch_size $TRAIN_EVAL_SIZE \
    --gradient_accumulation_steps $TRAIN_GRADIENT_STEPS \
    --evaluation_strategy "epoch" \
    --prediction_loss_only \
    --save_strategy "epoch" \
    --save_total_limit 2 \
    --learning_rate $TRAIN_LEARNING_RATE \
    --weight_decay 0. \
    --warmup_ratio $TRAIN_WARMUP_RATIO \
    --lr_scheduler_type "cosine" \
    --logging_steps 1 \
    --fsdp "full_shard auto_wrap" \
    --fsdp_transformer_layer_cls_to_wrap 'LlamaDecoderLayer' \
    --tf32 $GPU_TF32  \
    --source_model_max_length $TRAIN_SOURCE_MAX_LEN \
    --model_max_length $TRAIN_MODEL_MAX_LEN \
    --gradient_checkpointing True \
    --lazy_preprocess True \
    --report_to none \
    --max_split_size_mb 1024
