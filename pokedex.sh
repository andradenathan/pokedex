#!/bin/bash

if [ $# -eq 0 ]; then
    echo "You need to specify an argument to search for your pokemon"
    exit 1
fi

url="https://pokeapi.co/api/v2/pokemon/$1"

data=$(curl -s $url)

echo "$data" | jq -r '(["Name", "Height", "Weight", "Types"] | 
    (., map(length* "-"))), (
        [.name, .height, .weight, (.types[].type.name)]) | @tsv' | column -t
