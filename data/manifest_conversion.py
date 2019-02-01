# -*- coding: utf-8 -*-
"""Prepare Aishell mandarin dataset

Download, unpack and create manifest files.
Manifest file is a json-format file with each line containing the
meta data (i.e. audio filepath, transcript and audio duration)
of each audio file in the data set.
"""
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import codecs
import wave
import json
import argparse


def create_manifest_from_file(manifest_path, manifest_path_out):
    print("Creating manifest %s ..." % manifest_path)
    json_lines = []
    transcript_dict = {}
    with open(manifest_path, 'r') as fr:
        for line in fr.readlines():
            path = line.strip().split(',')[0]
            text = line.strip().split(',')[1]
            transcript_dict[path] = text

    data_types = ['test']
    for type in data_types:
        del json_lines[:]
        for path in transcript_dict.keys():
            file = wave.open(path)
            duration = '{:.3f}'.format(file.getparams().nframes/file.getparams().framerate)
            with codecs.open(transcript_dict[path], 'r', 'utf-8') as fr2:
                text = fr2.readline().strip()
            json_lines.append(json.dumps(
                {
                    'audio_filepath': path,
                    'duration': float(duration),
                    'text': text
                },
                ensure_ascii=False))
            file.close()
        with codecs.open(manifest_path_out, 'w', 'utf-8') as fout:
            for line in json_lines:
                fout.write(line + '\n')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--target",
        default='./mani_out.txt',
        type=str,
        help="Directory to save the dataset")
    parser.add_argument(
        "--source",
        default="/home/ydzhao/PycharmProjects/deepspeech.pytorch/data/aishell2_lite/test.csv",
        type=str,
        help="Filepath prefix for output manifests.")
    args = parser.parse_args()
    create_manifest_from_file(args.source, args.target)


if __name__ == '__main__':
    main()
