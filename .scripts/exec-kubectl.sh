#!/bin/bash

# Usage
#  - exec-kubectl.sh prod1 app=mfinn 'jstack -l $(pgrep java)'
#  - exec-kubectl.sh prod1 app=mfinn env

set -e

start_time=$(date +%H%M%S)

if [ $# -lt 3 ]; then
  echo 'provide context, selector and command to run'
  exit 1
fi
context="$1"
selector="$2"
# Make single string into array
command=("$3")

all_pods=$(kubectl --context "$context" get pods --selector "$selector" --output json | jq -r '.items[].metadata.name')
pod_file_names=()

for pod in $all_pods
do
  pod_name="$pod".txt
  pod_file_names+=("$pod_name")

  kubectl --context "$context" exec "$pod" -- sh -c "${command[@]}" > "$pod_name" && echo "$pod" complete || echo Failed executing command in "$pod"
done

tarball_name="$start_time".tar.gz
tar czf "$tarball_name" "${pod_file_names[@]}"
echo Packaged in "$tarball_name"
