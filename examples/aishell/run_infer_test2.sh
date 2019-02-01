#! /usr/bin/env bash

# infer
CUDA_VISIBLE_DEVICES=0 \
python -u infer.py \
--num_samples=10 \
--trainer_count=1 \
--beam_size=300 \
--num_proc_bsearch=8 \
--num_conv_layers=2 \
--num_rnn_layers=3 \
--rnn_layer_size=1024 \
--alpha=2.6 \
--beta=5.0 \
--cutoff_prob=0.99 \
--cutoff_top_n=40 \
--use_gru=True \
--use_gpu=True \
--share_rnn_weights=False \
--mean_std_path='models/aishell/mean_std.npz' \
--infer_manifest='data/aishell/test_pp.txt' \
--vocab_path='models/aishell/vocab.txt' \
--model_path='models/aishell/params.tar.gz' \
--lang_model_path='models/lm/zh_giga.no_cna_cmn.prune01244.klm' \
--decoding_method='ctc_beam_search' \
--error_rate_type='cer' \
--specgram_type='linear'

if [ $? -ne 0 ]; then
    echo "Failed in inference!"
    exit 1
fi


exit 0
