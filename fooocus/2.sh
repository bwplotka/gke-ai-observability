# Create a pool with one node with NVIDIA L4 GPU.
gcloud container node-pools create gpupool \
  --accelerator type=nvidia-l4,count=1,gpu-driver-version=latest \
  --project=${PROJECT_ID} \
  --location=${REGION} \
  --node-locations=${REGION}-a \
  --cluster=${CLUSTER_NAME} \
  --machine-type=g2-standard-8 \
  --num-nodes=1
