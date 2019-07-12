openssl aes-256-cbc -K $encrypted_0c35eebf403c_key -iv $encrypted_0c35eebf403c_iv -in service.json.enc -out service.json -d
curl https://sdk.cloud.google.com | bash > /dev/null;
source $HOME/google-cloud-sdk/path.bash.inc
gcloud components update kubectl
gcloud auth activate-service-account --key-file service.json
gcloud config set project multi-k8s-246509
gcloud config set compute/zone europe-west1-b
gcloud container clusters get-credentials multi-cluster
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker build -t $DOCKERID/multi-client:latest -t $DOCKERID/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t $DOCKERID/multi-server:latest -t $DOCKERID/multi-server:$GIT_SHA -f ./server/Dockerfile ./client
docker build -t $DOCKERID/multi-worker:latest -t $DOCKERID/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./client

docker push $DOCKERID/multi-client:latest
docker push $DOCKERID/multi-client:$GIT_SHA
docker push $DOCKERID/multi-server:latest
docker push $DOCKERID/multi-server:$GIT_SHA
docker push $DOCKERID/multi-worker:latest
docker push $DOCKERID/multi-worker:$GIT_SHA

kubectl apply -f k8s
