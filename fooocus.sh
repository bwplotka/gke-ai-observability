#!/usr/bin/env bash

# Example on how to use it https://github.com/bwplotka/demo-nav/blob/master/example/demo-example.sh

NUMS=false
#IMMEDIATE_REVEAL=true

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "${DIR}/demo-nav.sh"

# Yolo aliases
function cat() {
    bat -p "$@"
}

clear

#export PROJECT_ID=$(gcloud config get project) # "<Your Project ID">
#export REGION="us-central1"
#export CLUSTER_NAME="kubecon-ai-o11y-1"

printf "Let's deploy & observe an AI workload on GKE:\n\n"

r "$(cat fooocus/1.sh)" "echo 'yolo'"

r "That's it, thanks!" "echo '🤙🏽'"

navigate true
