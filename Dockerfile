# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
# No registry-verified custom nodes found in workflow.
# The following custom nodes were in the workflow under unknown_registry but could not be resolved because no aux_id (GitHub repo) was provided:
# Could not resolve unknown_registry node: KSampler (no aux_id provided)
# Could not resolve unknown_registry node: CLIPTextEncode (no aux_id provided)
# Could not resolve unknown_registry node: VAEEncodeTiled (no aux_id provided)
# Could not resolve unknown_registry node: PerturbedAttention (no aux_id provided)
# Could not resolve unknown_registry node: ACN_AdvancedControlNetApply (no aux_id provided)
# Could not resolve unknown_registry node: ACN_ScaledSoftControlNetWeights (no aux_id provided)
# Could not resolve unknown_registry node: VAEDecode (no aux_id provided)
# Could not resolve unknown_registry node: ConditioningAverage (no aux_id provided)
# Could not resolve unknown_registry node: Save_as_jpeg (no aux_id provided)
# Could not resolve unknown_registry node: VAEDecodeTiled (no aux_id provided)
# Could not resolve unknown_registry node: TimestepKeyframe (no aux_id provided)
# Could not resolve unknown_registry node: ShowText|pysssss (no aux_id provided)
# Could not resolve unknown_registry node: IPAdapterEmbeds (no aux_id provided)
# Could not resolve unknown_registry node: IPAdapterUnifiedLoader (no aux_id provided)
# Could not resolve unknown_registry node: IPAdapterLoadEmbeds (no aux_id provided)
# Could not resolve unknown_registry node: ImageNormalization (no aux_id provided)
# Could not resolve unknown_registry node: AnyLineArtPreprocessor_aux (no aux_id provided)
# Could not resolve unknown_registry node: ResizeImage (no aux_id provided)
# Could not resolve unknown_registry node: CropImage (no aux_id provided)
# Could not resolve unknown_registry node: Text Overlay (no aux_id provided)
# Could not resolve unknown_registry node: DepthMapColorizer (no aux_id provided)
# Could not resolve unknown_registry node: ImageBlend (no aux_id provided)
# Could not resolve unknown_registry node: PaletteOptimalTransportTransfer (no aux_id provided)
# Could not resolve unknown_registry node: LoadImage (no aux_id provided)
# Could not resolve unknown_registry node: PrepImageForClipVision (no aux_id provided)
# Could not resolve unknown_registry node: CLIPVisionLoader (no aux_id provided)
# Could not resolve unknown_registry node: IPAdapterEncoder (no aux_id provided)
# Could not resolve unknown_registry node: IPAdapterModelLoader (no aux_id provided)
# Could not resolve unknown_registry node: ColorPalette (no aux_id provided)
# Could not resolve unknown_registry node: BLIPImageCaptioning (no aux_id provided)
# Could not resolve unknown_registry node: ImageUpscaleWithModel (no aux_id provided)
# Could not resolve unknown_registry node: LamaRemover (no aux_id provided)

# download models into comfyui

RUN comfy model download --url https://huggingface.co/h94/IP-Adapter/resolve/main/models/image_encoder/model.safetensors --relative-path models/clip_vision --filename CLIP-ViT-H-14-laion2B-s32B-b79K.safetensors

RUN comfy model download --url https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter_sdxl_vit-h.safetensors --relative-path models/ipadapter --filename ip-adapter_sdxl_vit-h.safetensors

RUN comfy model download --url https://huggingface.co/stabilityai/sdxl-vae/resolve/main/sdxl_vae.safetensors --relative-path models/vae/SDXL --filename sdxl_vae.safetensors

RUN comfy model download --url https://huggingface.co/diffusers/controlnet-canny-sdxl-1.0/resolve/main/diffusion_pytorch_model_V2.safetensors --relative-path models/controlnet/SDXL/controlnet-canny-sdxl-1.0 --filename diffusion_pytorch_model_V2.safetensors

RUN comfy model download --url https://huggingface.co/diffusers/controlnet-depth-sdxl-1.0/resolve/main/diffusion_pytorch_model.safetensors --relative-path models/controlnet/SDXL/controlnet-depth-sdxl-1.0 --filename diffusion_pytorch_model.safetensors

RUN comfy model download --url https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.1/RealESRGAN_x2plus.pth --relative-path models/upscale_models --filename RealESRGAN_x2plus.pth

RUN comfy model download --url https://github.com/ultralytics/assets/releases/download/v8.3.0/yolo11x-seg.pt --relative-path models/ultralytics --filename yolo11x-seg.pt

RUN comfy model download --url https://civitai.com/api/download/models/293991?type=Model&format=SafeTensor --relative-path models/checkpoints --filename SDXLFaetastic_v24.safetensors

RUN comfy node install https://github.com/pamparamm/sd-perturbed-attention

RUN comfy node install https://github.com/Kosinkadink/ComfyUI-Advanced-ControlNet

RUN comfy node install https://github.com/Layer-norm/comfyui-lama-remover

RUN comfy node install https://github.com/45uee/ComfyUI-Color_Transfer

RUN comfy node install https://github.com/Fannovel16/comfyui_controlnet_aux

RUN comfy node install https://github.com/cubiq/ComfyUI_IPAdapter_plus

RUN comfy node install https://github.com/pythongosssss/ComfyUI-Custom-Scripts


# RUN # Could not find URL for <model-name> (all models in this workflow were resolved)

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
COPY input/ /comfyui/input/
