#!/bin/bash
#SBATCH --job-name=mmdetection_test
#SBATCH --output=output.log
#SBATCH --time=00:05:00

# Ativa o ambiente virtual
source /workspace/mmdetection/venv/bin/activate

# Roda o script demo_video.py
cd /workspace/mmdetection
python demo/demo_video.py \
    /workspace/video/example.mp4 \
    --output result.mp4
