docker build -t lothid/multi-client:latest -t lothid/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lothid/multi-server:latest -t lothid/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lothid/multi-worker:latest -t lothid/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lothid/multi-client:latest
docker push lothid/multi-client:$SHA
docker push lothid/multi-server:latest
docker push lothid/multi-server:$SHA
docker push lothid/multi-worker:latest
docker push lothid/multi-worker:$SHA

kubectl apply -f k8s/
kubectl set image deployments/client-deployment client=lothid/multi-client:$SHA
kubectl set image deployments/server-deployment server=lothid/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=lothid/multi-worker:$SHA
