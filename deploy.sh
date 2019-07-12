docker build -t $DOCKERID/multi-client:latest -t $DOCKERID/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t $DOCKERID/multi-server:latest -t $DOCKERID/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t $DOCKERID/multi-worker:latest -t $DOCKERID/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push $DOCKERID/multi-client:latest
docker push $DOCKERID/multi-client:$GIT_SHA
docker push $DOCKERID/multi-server:latest
docker push $DOCKERID/multi-server:$GIT_SHA
docker push $DOCKERID/multi-worker:latest
docker push $DOCKERID/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=hypy/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=hypy/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=hypy/multi-worker:$GIT_SHA
