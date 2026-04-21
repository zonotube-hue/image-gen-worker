# RunPod Serverless ComfyUI Worker + IP-Adapter Face (SDXL)
FROM runpod/worker-comfyui:5.8.5-base-cuda12.8.1

# insightface は C 拡張がビルドされるため gcc 等が必要
RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential \
      python3-dev \
    && rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    cd /comfyui/custom_nodes && \
    git clone --depth 1 https://github.com/cubiq/ComfyUI_IPAdapter_plus.git

RUN pip install --no-cache-dir \
      insightface \
      onnxruntime-gpu

LABEL org.opencontainers.image.title="image-gen-tool worker-comfyui (ipadapter)"
