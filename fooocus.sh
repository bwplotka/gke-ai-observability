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

export CLUSTER_NAME="kubecon-ai-o11y-1"
export REGION="us-central1"
export PROJECT_ID=$(gcloud config get project)

echo -e "${GREY}Let's deploy & observe an AI workload on GKE:\n\n${COLOR_RESET}"

r "$(cat fooocus/1.sh)" "bash fooocus/1-patched.sh"
r "$(cat fooocus/2.sh)" "bash fooocus/2.sh"
r "$(cat fooocus/3.sh)" "bash fooocus/3.sh"

p "# Let's review fooocus application, instrumented with eBPF for HTTP metrics 💪🏽"
r "cat fooocus/server-instrumented.yaml"

p "# Let's install fooocus application!"
r "kubectl apply -f fooocus/server-instrumented.yaml"

p "Port forward fooocus port to our machine"
r "kubectl port-forward service/fooocus 3000:3000"

r "That's it, thanks!" "echo '🤙🏽'"

navigate true
