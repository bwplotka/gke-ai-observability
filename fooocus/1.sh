# Assuming you set your project via gcloud config set project "<you project ID>"
export CLUSTER_NAME="kubecon-ai-o11y-1"
export REGION="us-central1"
export PROJECT_ID=$(gcloud config get project)

gcloud container clusters create ${CLUSTER_NAME} \
  --project=${PROJECT_ID} \
  --region=${REGION} \
  --zone=${REGION}-a \
  --workload-pool=${PROJECT_ID}.svc.id.goog \
  --release-channel=rapid \
  --cluster-version=1.29 \
  --num-nodes=1 \
  --monitoring=SYSTEM,CADVISOR,KUBELET,DCGM,POD,DAEMONSET # Available in future GKE versions
