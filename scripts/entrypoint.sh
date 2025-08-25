#!/bin/bash

# I need the URL and TOKEN to be passed as environment variables
# If not, the script will fail

if [ -z "$URL" ] || [ -z "$TOKEN" ] || [ -z "$NAME" ] || [ -z "$LABELS" ] ; then
  echo "Error: URL, TOKEN, LABELS and NAME environment variables must be set."
  exit 1
fi

./config.sh --url $URL --token $TOKEN --name "$NAME" --runnergroup "default" --labels "$LABELS" --work "_work"

./run.sh
