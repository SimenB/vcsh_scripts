#!/usr/bin/env bash

function yesterworkday() {
    if [[ "1" == "$(date +%u)" ]]
    then
        echo "last friday"
    else
        echo "yesterday"
    fi
}

git log --no-merges --since "$(yesterworkday)" --author "$(git config user.name)" --oneline
