#!/bin/bash

# Usage
#  - exec-kubectl.sh prod1 app=mfinn 'jstack -l 22'
#  - exec-kubectl.sh prod1 app=mfinn env

set -e

if [ $# -lt 3 ]; then
  echo 'provide context, selector and command to run'
  exit 1
fi
context="$1"
selector="$2"
# Make single string into array
command=("$3")

all_pods=$(kubectl --context "$context" get pods --selector "$selector" --output name | sed 's/pods\///')

for pod in $all_pods
do
  kubectl --context "$context" exec "$pod" -- "${command[@]}" > "$pod".txt
done

