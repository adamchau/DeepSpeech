#!/bin/bash
if [ -d $1 ];then
python -u data/manifest_conversion.py --source $1 --target $2
fi
