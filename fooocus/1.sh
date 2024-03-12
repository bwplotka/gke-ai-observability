gcloud config set project "<you project ID>"
export CLUSTER_NAME="<cluster name of your choice>"
export REGION="us-central1"
export PROJECT_ID=$(gcloud config get project)

gcloud container clusters create ${CLUSTER_NAME} \
  --project=${PROJECT_ID} \
  --region=${REGION} \
  --zone=${REGION}-a \
  --workload-pool=${PROJECT_ID}.svc.id.goog \
  --release-channel=rapid \
  --cluster-version=1.29 \
  --monitoring=SYSTEM,CADVISOR,KUBELET,POD,DAEMONSET \
  --num-nodes=1
