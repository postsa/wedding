#!/usr/bin/env bash

if [[ -z "$1" ]]; then
  exit 1;
fi

VERSION=$1

IMAGE_ID=$(docker build -q . | sed 's/sha256://g' | sed 's/ //g' | cut -c 1-12)

$(aws ecr get-login | sed 's/-e none//g')
LOGIN_RESULT=$?
if [[ $LOGIN_RESULT != 0 ]]; then
  exit $LOGIN_RESULT
fi

TAG=186539776832.dkr.ecr.us-west-2.amazonaws.com/wedding/nginx
docker tag $IMAGE_ID $TAG:$VERSION

docker push $TAG:$VERSION

PUSH_RESULT=$?
if [[ $PUSH_RESULT != 0 ]]; then
  exit $PUSH_RESULT
fi

aws cloudformation deploy --template-file template.yaml --stack-name wedding --capabilities CAPABILITY_IAM \
--parameter-overrides Version=$VERSION
