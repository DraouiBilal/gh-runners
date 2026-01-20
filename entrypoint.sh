#!/bin/bash

CONFIG_FILE="$RUNNER_CONFIG_FILE"

if [ -z "$RUNNER_CONFIG_FILE" ] ; then
  CONFIG_FILE="config/runner-config.yaml"
fi

URL=$(yq '.runner_config.url' "$CONFIG_FILE")
RUNNER_GROUP=$(yq '.runner_config.runner_group' "$CONFIG_FILE")
WORK_DIR=$(yq '.runner_config.work_directory' "$CONFIG_FILE")
LABELS=$(yq '.runner_config.labels | join(",")' "$CONFIG_FILE")

if [ -z "$URL" ] || [ -z "$TOKEN" ] || [ -z "$NAME" ] || [ -z "$LABELS" ] || [ -z "$RUNNER_GROUP" ] || [ -z "$WORK_DIR" ] ; then
  echo "Error: URL, TOKEN, LABELS, RUNNER_GROUP, WORK_DIR and NAME variables must be set."
  exit 1
fi

echo "Name: $NAME"
echo "URL: $URL"
echo "Labels: $LABELS"
echo "Runner Group: $RUNNER_GROUP"
echo "Work Directory: $WORK_DIR"

./config.sh --url $URL --token $TOKEN --name "$NAME" --runnergroup "$RUNNER_GROUP" --labels "$LABELS" --work "$WORK_DIR"

./run.sh
