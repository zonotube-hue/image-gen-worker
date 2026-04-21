# RunPod Serverless ComfyUI Worker + IP-Adapter Face (SDXL)
FROM runpod/worker-comfyui:5.8.5-base-cuda12.8.1

RUN set -eux; \
    cd /comfyui/custom_nodes && \
    git clone --depth 1 https://github.com/cubiq/ComfyUI_IPAdapter_plus.git

RUN pip install --no-cache-dir \
      insightface==0.7.3 \
      onnxruntime-gpu==1.24.4

RUN python -c "import insightface; print('insightface ok', insightface.__version__)" || true

LABEL org.opencontainers.image.title="image-gen-tool worker-comfyui (ipadapter)"
