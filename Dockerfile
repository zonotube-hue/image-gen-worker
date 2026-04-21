FROM runpod/worker-comfyui:5.8.5-base-cuda12.8.1

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

RUN cat > /comfyui/extra_model_paths.yaml <<'YAML'
runpod-worker-comfy:
  base_path: /runpod-volume/
  checkpoints: models/checkpoints/
  clip: models/clip/
  clip_vision: models/clip_vision/
  configs: models/configs/
  controlnet: models/controlnet/
  diffusers: models/diffusers/
  embeddings: models/embeddings/
  loras: models/loras/
  style_models: models/style_models/
  upscale_models: models/upscale_models/
  vae: models/vae/
  ipadapter: models/ipadapter/
  insightface: models/insightface/
YAML

RUN python -c "import insightface; print('insightface ok', insightface.__version__)" || true

LABEL org.opencontainers.image.title="image-gen-tool worker-comfyui (ipadapter)"
