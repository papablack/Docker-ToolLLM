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
    --output_path retrieval_model \
    --num_epochs 5 \
    --train_batch_size 32 \
    --learning_rate 2e-5 \
    --warmup_steps 500 \
    --max_seq_length 256    

python preprocess/preprocess_toolllama_data.py \
    --tool_data_dir /llm_data/data/answer/G1_answer \
    --method DFS_woFilter_w2 \
    --output_file /llm_data/data/answer/toolllama_G1_dfs.json  

torchrun --nproc_per_node=$GPU_CORES --master_port=20001 toolbench/train/train_mem.py \
    --model_name_or_path huggyllama/llama-7b  \
    --data_path  /llm_data/data/toolllama_G123_dfs_train.json \
    --eval_data_path  /llm_data/data/toolllama_G123_dfs_eval.json \
    --conv_template tool-llama-single-round \
    --bf16 $GPU_BF16 \
    --output_dir /llm_data/trained/toolllama \
    --num_train_epochs 2 \
    --per_device_train_batch_size 2 \
    --per_device_eval_batch_size 2 \
    --gradient_accumulation_steps 8 \
    --evaluation_strategy "epoch" \
    --prediction_loss_only \
    --save_strategy "epoch" \
    --save_total_limit 8 \
    --learning_rate 5e-5 \
    --weight_decay 0. \
    --warmup_ratio 0.04 \
    --lr_scheduler_type "cosine" \
    --logging_steps 1 \
    --fsdp "full_shard auto_wrap" \
    --fsdp_transformer_layer_cls_to_wrap 'LlamaDecoderLayer' \
    --tf32 $GPU_TF32  \
    --source_model_max_length 2048 \
    --model_max_length 8192 \
    --gradient_checkpointing True \
    --lazy_preprocess True \
    --report_to none    

python toolbench/inference/qa_pipeline.py \
    --tool_root_dir /llm_data/data/toolenv/tools/ \
    --backbone_model /llm_data/trained/toolllama \
    --model_path ToolBench/ToolLLaMA-7b \
    --max_observation_length 1024 \
    --observ_compress_method truncate \
    --method DFS_woFilter_w2 \
    --input_query_file /llm_data/data/instruction/inference_query_demo.json \
    --output_answer_file toolllama_dfs_inference_result \
    --rapidapi_key $RAPIDAPI_KEY \
    --use_rapidapi_key

    python toolbench/inference/qa_pipeline.py \
    --tool_root_dir /llm_data/data/toolenv/tools/ \
    --backbone_model chatgpt_function \
    --openai_key $OPENAI_KEY \
    --max_observation_length 1024 \
    --method DFS_woFilter_w2 \
    --input_query_file /llm_data/data/instruction/inference_query_demo.json \
    --output_answer_file chatgpt_dfs_inference_result \
    --rapidapi_key $RAPIDAPI_KEY \
    --use_rapidapi_key