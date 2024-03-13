# Assuming you set your project via gcloud config set project "<you project ID>"
export CLUSTER_NAME="kubecon-ai-o11y"
export REGION="us-central1"
export PROJECT_ID=$(gcloud config get project)

# Start a new cluster.
gcloud container clusters create ${CLUSTER_NAME} \
  --project=${PROJECT_ID} \
  --region=${REGION} \
  --workload-pool=${PROJECT_ID}.svc.id.goog \
  --release-channel=rapid \
  --cluster-version=1.29 \
  --num-nodes=1 \
  --monitoring=SYSTEM,POD,DAEMONSET # Removed not ready packages, we will install manually those resources for now (cadvisor and DCGM).

# Make sure to set up kubectl and install
# DCGM exporter, will be automatically done for you soon with DCGM package.
# kubectl apply -f fooocus/dcgm-monitoring.yaml
# Same here, should be part of KUBELET,CADVISOR soon.
# kubectl apply -f fooocus/gcm-cadvisor.yaml
