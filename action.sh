#!/bin/bash

set -exv

if [[ -n "${INPUT_BASE_URL_OVERRIDE}" ]]; then
    echo "initial-base-url=$(grep "BASE_URL" ${INPUT_K6_SCRIPT} | head -1)" >> $GITHUB_OUTPUT
    sed -i "s,const BASE_URL =.*,const BASE_URL = \"${INPUT_BASE_URL_OVERRIDE}\";,g" $INPUT_K6_SCRIPT
    echo "resulting-base-url=$(grep "BASE_URL" ${INPUT_K6_SCRIPT} | head -1)" >> $GITHUB_OUTPUT
fi

echo "Starting K6 after 60s warm-up delay..."
sleep 60
echo "Starting K6 tests."

acct=$(aws sts get-caller-identity --query 'Account' --output text)
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${acct}.dkr.ecr.us-east-1.amazonaws.com

if [[ -n "${INPUT_ADDITIONAL_MOUNT}" ]]; then
    docker run -v $(pwd)/${INPUT_K6_SCRIPT}:/k6/${INPUT_K6_SCRIPT} -v $(pwd)/${INPUT_ADDITIONAL_MOUNT}:/k6/${INPUT_ADDITIONAL_MOUNT} ${acct}.dkr.ecr.us-east-1.amazonaws.com/docker-hub/grafana/k6:latest run ${INPUT_K6_FLAGS} /k6/${INPUT_K6_SCRIPT}
else
    docker run -v $(pwd)/${INPUT_K6_SCRIPT}:/k6/${INPUT_K6_SCRIPT} ${acct}.dkr.ecr.us-east-1.amazonaws.com/docker-hub/grafana/k6:latest run ${INPUT_K6_FLAGS} /k6/${INPUT_K6_SCRIPT}
fi
