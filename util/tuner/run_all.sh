#!/bin/bash

# THIS_DIR="$( cd "$( dirname "$BASH_SOURCE" )" && pwd )"
export CUDA_INSTALL_PATH="/usr/local/cuda-12.8/"
export PATH=$CUDA_INSTALL_PATH/bin:$PATH
SCRIPT_DIR="./gpu-app-collection-partial/src/cuda/GPU_Microbenchmark/"
echo "Running make in $SCRIPT_DIR"
make -C "$SCRIPT_DIR" tuner -j || { echo "make failed"; exit 1; }

cd ${SCRIPT_DIR}/bin/
for f in ./*; do
    if [[ "$f" == *_corr ]]; then
        continue
    fi

    echo "running $f microbenchmark"
    $f
    echo "/////////////////////////////////"
done