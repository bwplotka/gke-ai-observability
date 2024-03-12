# gke-ai-observability

Demo of observability setup for AI workloads on GKE

https://github.com/lllyasviel/Fooocus

## Fooocus Observability Demo

1. Create GKE cluster e.g. standard one in e.g. us-central1 region.

   ```bash
   gcloud config set project "<your project ID>"
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
   ```
   
   Then follow up with the pool: 

   ```bash
   gcloud container node-pools create gpupool \
   --accelerator type=nvidia-l4,count=1,gpu-driver-version=latest \
   --project=${PROJECT_ID} \
   --location=${REGION} \
   --node-locations=${REGION}-a \
   --cluster=${CLUSTER_NAME} \
   --machine-type=g2-standard-8 \
   --num-nodes=1
   ```

2. After cluster is up, setup kubectl

    ```bash
    gcloud container clusters get-credentials ${CLUSTER_NAME} --location=${REGION}
    ```

3. Install Fooocus inference server on your cluster, instrumented for HTTP metrics with eBPF
   
    ```bash
    kubectl apply -f fooocus/server-instrumented.yaml
    ```

4. Wait for it to come up, in the meantime you can check the logs:

   ```bash
   kubectl logs -f -l app=fooocus
   ```
   
    Once ready, there should be
   
5. Setup port-forwarding

   ```bash
   kubectl port-forward service/fooocus 3000:3000
   ```

6. Open 3000 port  
7. Add more observability!

   ```bash
   # DCGM exporter, will be automatically done for you soon.
   kubectl apply -f fooocus/dcgm-monitoring.yaml
   # Same here, should be part of KUBELET,CADVISOR soon.
   kubectl apply -f fooocus/gcm-cadvisor.yaml
   ```

8. Enjoy!
