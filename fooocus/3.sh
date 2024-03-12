# Setup kubectl access to the new cluster.
gcloud container clusters get-credentials ${CLUSTER_NAME} --location=${REGION}
