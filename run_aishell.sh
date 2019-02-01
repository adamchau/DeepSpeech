#! /usr/bin/env bash
# TODO: replace the model with a mandarin model
# start demo server
CUDA_VISIBLE_DEVICES=0 \
python -u cn12k_mod.py \
--host_ip='0.0.0.0' \
--host_port=8999 \
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
--speech_save_dir='demo_cache' \
--warmup_manifest='data/aishell/test_pp.txt' \
--mean_std_path='models/aishell/mean_std.npz' \
--vocab_path='models/aishell/vocab.txt' \
--model_path='models/aishell/params.tar.gz' \
--lang_model_path='models/lm/zh_giga.no_cna_cmn.prune01244.klm' \
--decoding_method='ctc_beam_search' \
--specgram_type='linear'

if [ $? -ne 0 ]; then
    echo "Failed in starting demo server!"
    exit 1
fi


exit 0
