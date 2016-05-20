#!/usr/bin/env bash

echo Current tag/ref is ${CI_BUILD_TAG}${CI_BUILD_REF_NAME}.

if [ ${CI_BUILD_TAG} ]; then
    DOCKER_IMAGE_VERSION=${CI_BUILD_TAG}
else
    DOCKER_IMAGE_VERSION=${CI_BUILD_REF_NAME}
fi

DOCKER_IMAGE_NAME=${DOCKER_REGISTRY}/`echo ${CI_PROJECT_DIR} | sed 's|/builds/||g'`

docker info
docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION} .
docker login -u ${DOCKER_REGISTRY_USERNAME} -p ${DOCKER_REGISTRY_PASSWORD} -e ${DOCKER_REGISTRY_EMAIL} ${DOCKER_REGISTRY}
docker push ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION}

echo "Build Docker image success!"