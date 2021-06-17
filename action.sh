#!/bin/bash

set -e
if [[ -n "${INPUT_BASE_URL_OVERRIDE}" ]]; then 
    echo "::set-output name=initial-base-url::$(grep "BASE_URL" ${INPUT_K6_SCRIPT} | head -1)"
    sed -i "s,const BASE_URL =.*,const BASE_URL = \"${INPUT_BASE_URL_OVERRIDE}\";,g" $INPUT_K6_SCRIPT
    echo "::set-output name=resulting-base-url::$(grep "BASE_URL" ${INPUT_K6_SCRIPT} | head -1)"
fi
docker run -v $(pwd)/${INPUT_K6_SCRIPT}:/k6/${INPUT_K6_SCRIPT} loadimpact/k6 run ${INPUT_K6_FLAGS} /k6/${INPUT_K6_SCRIPT}