#!/usr/bin/env bash

# Example on how to use it https://github.com/bwplotka/demo-nav/blob/master/example/demo-example.sh

NUMS=false
#IMMEDIATE_REVEAL=true

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "${DIR}/demo-nav.sh"

# Yolo aliases
function cat() {
    bat -p --color=always "$@"
}

clear

export CLUSTER_NAME="kubecon-ai-o11y"
export REGION="us-central1"
export PROJECT_ID=$(gcloud config get project)

echo -e "${GREY}Let's deploy & observe an AI workload on GKE:\n\n${COLOR_RESET}"

r "$(cat fooocus/1.sh)" "bash fooocus/1-patched.sh"
r "$(cat fooocus/2.sh)" "bash fooocus/2.sh"
r "$(cat fooocus/3.sh)" "bash fooocus/3.sh"

p "# Let's review fooocus application, instrumented with eBPF for HTTP metrics 💪🏽"
r "cat fooocus/server-instrumented-rest.yaml"

p "# Let's install fooocus application!"
r "kubectl apply -f fooocus/server-instrumented-rest.yaml"
r "kubectl wait --timeout=1200s --for=condition=Available deployment/fooocus && kubectl get po"

p "# Port forward fooocus port to our machine"
r "kubectl port-forward service/fooocus 8888:8888 &"

p "# Let's generate some fishermen!"
r "cat fooocus/stress.sh"
r "bash fooocus/stress.sh"

r "That's it, thanks!" "echo '🤙🏽'"

navigate true
