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
